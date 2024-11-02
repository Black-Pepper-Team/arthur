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
            let userId = AppUserDefaults.shared.userId

            messages.append(.init(
                id: UUID().uuidString,
                userId: userId,
                date: Date(),
                message: message
            ))

            Task { @MainActor in
                do {
                    try await API.shared.sendMessageToChat(.init(userId: userId, message: message))
                } catch {
                    LoggerUtil.common.error("failed to send message: \(error.localizedDescription)")
                }
            }
        }
    }
}
