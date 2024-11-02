import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [
            .init(
                id: UUID().uuidString,
                userId: "ai",
                date: Date(),
                message: "Welcome! How can I help you today?",
                isError: false
            )
        ]

        @Published var isWaitingForResponse: Bool = false

        init() {
            listenForMessages()
        }

        func registerResponseMessage(_ message: String) {
            messages.append(.init(
                id: UUID().uuidString,
                userId: "ai",
                date: Date(),
                message: message,
                isError: false
            ))

            AVManager.shared.textToSpeech(text: message)
        }

        func registerErrorMessage() {
            messages.append(.init(
                id: UUID().uuidString,
                userId: "ai",
                date: Date(),
                message: "Unexpected error occurred",
                isError: true
            ))
        }

        func sendMessage(_ message: String) {
            let userId = AppUserDefaults.shared.userId
            let messageId = UUID().uuidString

            messages.append(.init(
                id: messageId,
                userId: userId,
                date: Date(),
                message: message,
                isError: false
            ))

            Task { @MainActor in
                do {
                    try await API.shared.sendMessageToChat(.init(id: messageId, userId: userId, message: message))

                    LoggerUtil.common.info("Message sent: \(messageId)")
                } catch {
                    LoggerUtil.common.error("failed to send message: \(error.localizedDescription)")
                }
            }

            AppUserDefaults.shared.lastMessageId = messageId

            listenForMessages()
        }

        func listenForMessages() {
            if AppUserDefaults.shared.lastMessageId.isEmpty {
                return
            }
            Task { @MainActor in
                do {
                    isWaitingForResponse = true

                    try await _listenForMessages(AppUserDefaults.shared.lastMessageId)

                    AppUserDefaults.shared.lastMessageId = ""
                    isWaitingForResponse = false
                } catch {
                    LoggerUtil.common.error("failed to listen for messages: \(error.localizedDescription)")
                }
            }
        }

        func _listenForMessages(_ messageId: String) async throws {
            while true {
                let response = try await API.shared.getMessageResponse(messageId)

                switch response.status {
                case .ready:
                    guard let message = response.message else {
                        return
                    }

                    registerResponseMessage(message)

                    return

                case .pending:
                    continue

                case .failed:
                    registerErrorMessage()

                    return
                }
            }
        }
    }
}
