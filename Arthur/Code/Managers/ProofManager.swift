import SwiftUI

class ProofManager: ObservableObject {
    static let shared = ProofManager()

    var lastResponse: ZkProof? = nil

    func requestProof(_ eventData: Data) async throws -> ZkProof {
        defer {
            lastResponse = nil
        }

        let url = URL(string: "rarime://crossapps?event_data=\(eventData.fullHex)&response_url=arthur://response")!

        await UIApplication.shared.open(url, options: [:], completionHandler: nil)

        while lastResponse == nil {
            try await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)

            if let lastResponse {
                return lastResponse
            }
        }

        fatalError("unreachable")
    }

    func handleProofResponse(_ url: URL) async throws {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let params = components.queryItems
        else {
            throw "invalid url"
        }

        guard let proofHex = params.first(where: { $0.name == "proof" })?.value else {
            throw "missing proof"
        }

        guard let data = Data(hex: String(proofHex.dropFirst(2))) else {
            throw "invalid proof"
        }

        let proof = try JSONDecoder().decode(ZkProof.self, from: data)

        lastResponse = proof
    }
}
