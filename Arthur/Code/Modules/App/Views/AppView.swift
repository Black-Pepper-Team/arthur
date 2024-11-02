import SwiftUI

struct AppView: View {
    @EnvironmentObject var proofManager: ProofManager

    @State private var isIntroShown = true

    var body: some View {
        ZStack {
            if isIntroShown {
                IntroView {
                    isIntroShown = false

                    Task { @MainActor in
                        do {
                            let proof = try await proofManager.requestProof(Data(hex: "238744a30ccde4e057864280c37d2abd14dfa2ddd05db7d1eb3a88a31b7eb208")!)

                            LoggerUtil.common.debug("\(proof.json.utf8)")
                        } catch {
                            LoggerUtil.common.error("error: \(error)")
                        }
                    }
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
