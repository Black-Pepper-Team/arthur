import Foundation
import Identity

extension CapabilitiesView {
    class ViewModel: ObservableObject {
        @Published var capabilities: [AICapability] = []

        func requestAICapabilities() {
            Task { @MainActor in
                do {
                    capabilities = try await API.shared.requestAICapabilities().capabilities
                } catch {
                    LoggerUtil.common.error("Failed to request AI capabilities: \(error)")

                    capabilities = AICapabilitiesManifest.precompiled.capabilities
                }
            }
        }

        func sendAIPermission(_ capability: AICapability, _ moneyLimitStr: String) {
            Task { @MainActor in
                do {
                    try await _sendAIPermission(capability, moneyLimitStr)
                } catch {
                    LoggerUtil.common.error("Failed to send AI permission: \(error)")
                }
            }
        }

        func _sendAIPermission(_ capability: AICapability, _ moneyLimitStr: String) async throws {
            var eventData: Data
            if let contractAddress = capability.contractAddress {
                let encoder = EncoderGoEncoder()

                if let tokenAddress = capability.tokenAddress {
                    eventData = try encoder.getEncodedData(contractAddress, ethValueStr: "0", tokenAddress: tokenAddress, tokenValueStr: moneyLimitStr)
                } else {
                    eventData = try encoder.getEncodedData(contractAddress, ethValueStr: moneyLimitStr, tokenAddress: "", tokenValueStr: "0")
                }
            } else {
                eventData = Data(hex: "2c3661391d3e579e831284041a0769dad216913663b14fa4919de598c6a0747c")!
            }

            let proof = try await ProofManager.shared.requestProof(eventData)

            let moneyLimit = Int(moneyLimitStr) ?? 0

            let userId = proof.pubSignals[0]

            AppUserDefaults.shared.userId = userId

            let aiPermission = AIPermission(
                userId: userId,
                id: capability.id,
                moneyLimit: moneyLimit,
                contractAddress: capability.contractAddress,
                proof: proof
            )

            try await API.shared.sendAIPermission(aiPermission)

            LoggerUtil.common.info("Sent AI permission for capability: \(capability.id)")
        }
    }
}
