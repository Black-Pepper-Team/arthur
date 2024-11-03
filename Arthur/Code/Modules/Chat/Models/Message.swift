import Foundation

struct Message: Codable, Identifiable {
    let id: String
    let userId: String
    let date: Date
    var message: String
    var isError: Bool
    var isPending: Bool
}

struct SendableMessage: Codable {
    let id: String
    let userId: String
    let message: String
}

struct MessageResponse: Codable {
    let id: String
    let status: MessageResponseStatus
    let message: String?
}

enum MessageResponseStatus: String, Codable {
    case ready, pending, failed
}
