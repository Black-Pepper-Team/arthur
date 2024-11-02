import SwiftUI

struct AppTextField: View {
    let onCommit: (String) -> Void
    var keyBoardType: UIKeyboardType = .numberPad

    @State private var text: String = ""

    var body: some View {
        HStack {
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text("Money limit")
                        .foregroundStyle(.white)
                }
                .keyboardType(.numberPad)
                .foregroundStyle(.white)
            AppButton(text: "Submit") {
                onCommit(text)
            }
            .frame(width: 100, height: 50)
        }
        .frame(width: 300, height: 40)
    }
}

#Preview {
    AppTextField { _ in }
}
