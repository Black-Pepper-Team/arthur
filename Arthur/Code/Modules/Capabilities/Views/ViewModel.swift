import Foundation

extension CapabilitiesView {
    class ViewModel: ObservableObject {
        @Published var capabilities: [AICapability] = []

        func requestAICapabilities() {
            Task { @MainActor in
                do {
                    capabilities = AICapabilitiesManifest.precompiled.capabilities

//                    capabilities = try await API.shared.requestAICapabilities().capabilities
                } catch {
                    LoggerUtil.common.error("Failed to request AI capabilities: \(error)")

                    capabilities = AICapabilitiesManifest.precompiled.capabilities
                }
            }
        }
    }
}
