import Foundation

extension ChatView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = [
            .init(
                id: UUID().uuidString,
                userId: "ai",
                date: Date(),
                message: "Welcome! How can I help you today?",
                isError: false,
                isPending: false
            )
        ]

        @Published var isWaitingForResponse: Bool = false

        init() {
            listenForMessages()
        }

        func registerResponseMessage(_ id: String, _ message: String) {
            if let messageIndex = messages.firstIndex(where: { $0.id == id }) {
                var oldMessage = messages[messageIndex]
                oldMessage.message = message
                oldMessage.isPending = false

                messages[messageIndex] = oldMessage

                return
            }

            messages.append(.init(
                id: UUID().uuidString,
                userId: "ai",
                date: Date(),
                message: message,
                isError: false,
                isPending: false
            ))

            AVManager.shared.textToSpeech(text: message)
        }

        func registerPendingMessage(_ id: String, _ message: String) {
            if let messageIndex = messages.firstIndex(where: { $0.id == id }) {
                var oldMessage = messages[messageIndex]
                oldMessage.message = message

                messages[messageIndex] = oldMessage

                return
            }

            messages.append(.init(
                id: id,
                userId: "ai",
                date: Date(),
                message: message,
                isError: false,
                isPending: true
            ))
        }

        func registerErrorMessage(_ id: String) {
            if let messageIndex = messages.firstIndex(where: { $0.id == id }) {
                var oldMessage = messages[messageIndex]
                oldMessage.message = "Unexpected error occurred"
                oldMessage.isError = true
                oldMessage.isPending = false

                messages[messageIndex] = oldMessage

                return
            }

            messages.append(.init(
                id: id,
                userId: "ai",
                date: Date(),
                message: "Unexpected error occurred",
                isError: true,
                isPending: false
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
                isError: false,
                isPending: false
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

                    registerResponseMessage(response.id, message)

                    return

                case .pending, .processing:
                    guard let message = response.message else {
                        continue
                    }

                    registerPendingMessage(response.id, message)

                    continue

                case .failed:
                    registerErrorMessage(response.id)

                    return
                }
            }
        }
    }
}
