import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack {
            Spacer()
            AppTextField(placeholder: "Message...", submitText: "Send", onCommit: onSend, keyBoardType: .default)
                .frame(width: 350, height: 40)
                .padding(.horizontal)
                .padding(.bottom, 10)
        }
    }

    func onSend(_ message: String) {}
}

#Preview {
    ChatView()
}
