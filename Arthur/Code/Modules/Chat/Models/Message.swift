import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let userId: String
    let date: Date
    let message: String
}
