import Foundation

struct AIPermission: Codable {
    let id: String
    let moneyLimit: Int
    let contractAddress: String?
    let proof: Proof

    enum CodingKeys: String, CodingKey {
        case id
        case moneyLimit = "money_limit"
        case contractAddress = "contract_address"
        case proof
    }
}
