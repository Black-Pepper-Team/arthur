import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let userId: String
    let date: Date
    let message: String
}

struct SendableMessage: Codable {
    let userId: String
    let message: String
}

struct MessageResponse: Codable {
    let status: MessageResponseStatus
    let message: String?
}

enum MessageResponseStatus: String, Codable {
    case ready, pending, failed
}
