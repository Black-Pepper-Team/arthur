import Foundation

struct AIPermission: Codable {
    let userId: String
    let id: String
    let moneyLimit: Int
    let contractAddress: String?
    let tokenAddress: String?
    let proof: ZkProof
}
