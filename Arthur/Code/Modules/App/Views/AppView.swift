import SwiftUI

struct AppView: View {
    @EnvironmentObject var proofManager: ProofManager

    @State private var isIntroShown = true
    @State private var areCapabilitiesShown = AppUserDefaults.shared.areCapabilitiesShown

    var body: some View {
        ZStack {
            if isIntroShown {
                IntroView {
                    isIntroShown = false
                }
            } else if areCapabilitiesShown {
                CapabilitiesView {
                    AppUserDefaults.shared.areCapabilitiesShown = false
                    areCapabilitiesShown = false
                }
            } else {
                ChatView()
            }
        }
        .onOpenURL(perform: handleOpenURL)
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.customAppBackground.ignoresSafeArea()
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }

    func handleOpenURL(_ url: URL) {
        Task { @MainActor in
            do {
                try await proofManager.handleProofResponse(url)
            } catch {
                LoggerUtil.common.debug("failed to handle proof response: \(error)")
            }
        }
    }
}

#Preview {
    AppView()
}
