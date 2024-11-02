import Foundation

struct AICapabilitiesManifest: Codable {
    let capabilities: [AICapability]
}

struct AICapability: Codable {
    let id: String
    let name: String
    let hasMoneyLimit: Bool
    let contractAddress: String?
    let tokenAddress: String?
}

extension AICapabilitiesManifest {
    static let precompiled = AICapabilitiesManifest(
        capabilities: [
            .init(id: "airlines_tickets", name: "Airlines Tickets", hasMoneyLimit: true, contractAddress: nil, tokenAddress: nil),
            .init(id: "nft_marketplace", name: "NFT Marketplace", hasMoneyLimit: true, contractAddress: "0xc1534912902BBe8C54626e2D69288C76a843bc0E", tokenAddress: "0xc1534912902BBe8C54626e2D69288C76a843bc0E"),
            .init(id: "restauranes_booking", name: "Restaurants Booking", hasMoneyLimit: true, contractAddress: nil, tokenAddress: nil),
        ]
    )
}
