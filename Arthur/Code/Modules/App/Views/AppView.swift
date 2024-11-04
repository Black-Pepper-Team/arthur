import SwiftUI

struct AppView: View {
    @EnvironmentObject var proofManager: ProofManager
    @EnvironmentObject var appManager: AppManager

    var body: some View {
        ZStack {
            if appManager.isIntroShown {
                IntroView {
                    appManager.isIntroShown = false
                }
            } else if appManager.areCapabilitiesShown {
                CapabilitiesView {
                    AppUserDefaults.shared.areCapabilitiesShown = false
                    appManager.areCapabilitiesShown = false
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
                LoggerUtil.common.error("failed to handle proof response: \(error)")
            }
        }
    }
}

#Preview {
    AppView()
        .environmentObject(ProofManager.shared)
        .environmentObject(AppManager.shared)
}
