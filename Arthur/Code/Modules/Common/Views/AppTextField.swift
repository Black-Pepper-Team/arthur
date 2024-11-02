import SwiftUI

struct AppTextField: View {
    var placeholder: String
    var submitText: String

    let onCommit: (String) -> Void
    var keyBoardType: UIKeyboardType = .numberPad

    @State private var text: String = ""

    var body: some View {
        HStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder)
                        .foregroundStyle(.white)
                }
                .keyboardType(keyBoardType)
                .foregroundStyle(.white)
            AppButton(text: submitText, shouldLockOnAction: false) {
                if text.isEmpty {
                    return
                }

                let textToSubmit = text

                text = ""

                onCommit(textToSubmit)
            }
            .frame(width: 90, height: 50)
        }
    }
}

#Preview {
    AppTextField(placeholder: "Money limit", submitText: "Submit") { _ in }
}
