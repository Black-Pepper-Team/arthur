import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [
            .init(
                id: UUID().uuidString,
                userId: "ai",
                date: Date(),
                message: "Welcome! How can I help you today?"
            )
        ]

        func sendMessage(_ message: String) {
            messages.append(.init(
                id: UUID().uuidString,
                userId: AppUserDefaults.shared.userId,
                date: Date(),
                message: message
            ))
        }
    }
}
