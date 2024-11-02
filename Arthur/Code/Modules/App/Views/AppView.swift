import SwiftUI

struct AppView: View {
    @EnvironmentObject var proofManager: ProofManager

    @State private var isIntroShown = true

    var body: some View {
        ZStack {
            if isIntroShown {
                IntroView {
                    isIntroShown = false
                }
            } else {
                VStack {}
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
