import Foundation

struct AICapabilitiesManifest: Codable {
    let capabilities: [AICapability]
}

struct AICapability: Codable {
    let id: String
    let name: String
    let type: String
    let dependsOnId: String?
}

extension AICapabilitiesManifest {
    static let precompiled = AICapabilitiesManifest(
        capabilities: [
            .init(id: "airlines_tickets", name: "Airlines Tickets", type: "bool", dependsOnId: nil),
            .init(id: "airlines_tickets_money_limit", name: "Airlines Tickets Money Limit", type: "integer", dependsOnId: "airlines_tickets"),
            .init(id: "nft_marketplace", name: "NFT Marketplace", type: "bool", dependsOnId: nil),
            .init(id: "nft_marketplace_money_limit", name: "NFT Marketplace Money Limit", type: "integer", dependsOnId: "nft_marketplace"),
            .init(id: "restauranes_booking", name: "Restaurants Booking", type: "bool", dependsOnId: nil),
            .init(id: "restauranes_booking_money_limit", name: "Restaurants Booking Money Limit", type: "integer", dependsOnId: "restauranes_booking"),
        ]
    )
}
