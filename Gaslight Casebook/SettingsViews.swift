import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: CasebookStore
    @State private var showPrivacy = false
    @State private var confirmReset = false

    var body: some View {
        ZStack {
            CasebookScreen(title: "Settings", subtitle: "The detective's preferences") {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        feedbackCard
                        textSizeCard
                        privacyCard
                        resetCard
                        aboutCard
                    }
                    .clampedContentWidth()
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    .padding(.bottom, 30)
                }
            }
            if confirmReset {
                resetOverlay
            }
        }
        .sheet(isPresented: $showPrivacy) {
            GaslightCasebookWebPanel(urlString: "https://example.com")
                .edgesIgnoringSafeArea(.bottom)
                .background(Ink.night.ignoresSafeArea())
        }
    }

    // MARK: Sound & haptics

    private var feedbackCard: some View {
        VStack(spacing: 12) {
            toggleRow(icon: AnyView(SpeakerIcon(size: 22, color: Ink.amber)),
                      title: "Sound",
                      detail: "Clicks and reveals",
                      isOn: store.state.soundOn) {
                store.state.soundOn.toggle()
                store.tapFeedback()
            }
            Rectangle().fill(Ink.line.opacity(0.6)).frame(height: 1)
            toggleRow(icon: AnyView(PulseIcon(size: 22, color: Ink.amber)),
                      title: "Haptics",
                      detail: "A tap you can feel",
                      isOn: store.state.hapticsOn) {
                store.state.hapticsOn.toggle()
                store.tapFeedback()
            }
        }
        .inkCard()
    }

    private func toggleRow(icon: AnyView, title: String, detail: String,
                           isOn: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                icon
                    .frame(width: 30)
                VStack(alignment: .leading, spacing: 1) {
                    Text(title)
                        .font(Quill.serifBold(14))
                        .foregroundColor(Ink.parchment)
                    Text(detail)
                        .font(Quill.serif(11))
                        .foregroundColor(Ink.parchmentFaint)
                }
                Spacer(minLength: 0)
                ZStack(alignment: isOn ? .trailing : .leading) {
                    Capsule()
                        .fill(isOn ? Ink.amber : Ink.deep)
                        .frame(width: 52, height: 30)
                        .overlay(Capsule().stroke(isOn ? Ink.amberGlow.opacity(0.6) : Ink.line, lineWidth: 1))
                    Circle()
                        .fill(isOn ? Ink.night : Ink.parchmentFaint)
                        .frame(width: 24, height: 24)
                        .padding(3)
                }
                .animation(.easeInOut(duration: 0.16), value: isOn)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: Text size

    private var textSizeCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                QuillIcon(size: 20, color: Ink.amber)
                Text("Text Size")
                    .font(Quill.serifBold(14))
                    .foregroundColor(Ink.parchment)
                Spacer(minLength: 0)
            }
            HStack(spacing: 8) {
                sizeChip(0, "Small")
                sizeChip(1, "Medium")
                sizeChip(2, "Large")
            }
            Text("Applies to briefs, statements and evidence notes.")
                .font(Quill.serifItalic(11))
                .foregroundColor(Ink.parchmentFaint)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inkCard()
    }

    private func sizeChip(_ index: Int, _ label: String) -> some View {
        let selected = store.state.textSizeIndex == index
        return Button(action: {
            store.state.textSizeIndex = index
            store.tapFeedback()
        }) {
            Text(label)
                .font(Quill.serifBold(12 + CGFloat(index) * 1.5))
                .foregroundColor(selected ? Ink.night : Ink.parchmentDim)
                .padding(.vertical, 9)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(selected ? Ink.amber : Ink.deep)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(selected ? Ink.amberGlow.opacity(0.6) : Ink.line, lineWidth: 1)
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: Privacy

    private var privacyCard: some View {
        Button(action: { showPrivacy = true }) {
            HStack(spacing: 12) {
                BookIcon(size: 22, color: Ink.amber)
                    .frame(width: 30)
                VStack(alignment: .leading, spacing: 1) {
                    Text("Privacy Policy")
                        .font(Quill.serifBold(14))
                        .foregroundColor(Ink.parchment)
                    Text("How the casebook treats your data")
                        .font(Quill.serif(11))
                        .foregroundColor(Ink.parchmentFaint)
                }
                Spacer(minLength: 0)
                ChevronIcon(size: 11, color: Ink.parchmentFaint, pointingLeft: false)
            }
            .inkCard()
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: Reset

    private var resetCard: some View {
        Button(action: { confirmReset = true }) {
            HStack(spacing: 12) {
                CrossIcon(size: 18, color: Ink.waxBright)
                    .frame(width: 30)
                VStack(alignment: .leading, spacing: 1) {
                    Text("Reset All Progress")
                        .font(Quill.serifBold(14))
                        .foregroundColor(Ink.waxBright)
                    Text("Burns every file, rank and commendation")
                        .font(Quill.serif(11))
                        .foregroundColor(Ink.parchmentFaint)
                }
                Spacer(minLength: 0)
            }
            .inkCard(stroke: Ink.waxBright.opacity(0.4))
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var resetOverlay: some View {
        ZStack {
            Color.black.opacity(0.72).edgesIgnoringSafeArea(.all)
            VStack(spacing: 14) {
                WaxSealIcon(size: 44, letter: "!")
                Text("Burn the Casebook?")
                    .font(Quill.serifBold(19))
                    .foregroundColor(Ink.parchment)
                Text("Every solved case, rank and commendation will be destroyed. Sound, haptic and text settings are kept. There is no recovering a burnt file.")
                    .font(Quill.serif(13))
                    .foregroundColor(Ink.parchmentDim)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                Button(action: {
                    store.resetAllProgress()
                    store.failFeedback()
                    confirmReset = false
                }) {
                    Text("Burn It All")
                        .font(Quill.serifBold(15))
                        .foregroundColor(Ink.parchment)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 9, style: .continuous)
                                .fill(Ink.bloodWax)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                                        .stroke(Ink.waxBright.opacity(0.7), lineWidth: 1)
                                )
                        )
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: { confirmReset = false }) {
                    Text("Keep the Files")
                        .font(Quill.serifBold(15))
                        .foregroundColor(Ink.parchment)
                }
                .buttonStyle(LampButtonStyle(prominent: false))
            }
            .padding(22)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Ink.panel)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Ink.waxBright.opacity(0.5), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 28)
            .frame(maxWidth: 480)
        }
    }

    // MARK: About

    private var aboutCard: some View {
        VStack(spacing: 6) {
            GasLampIcon(size: 30, color: Ink.parchmentFaint)
            Text("Gaslight Casebook")
                .font(Quill.serifBold(14))
                .foregroundColor(Ink.parchmentDim)
            Text("Version 1.0 - all investigations are kept on this device only.")
                .font(Quill.serif(11))
                .foregroundColor(Ink.parchmentFaint)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .inkCard(fill: Ink.deep)
    }
}
