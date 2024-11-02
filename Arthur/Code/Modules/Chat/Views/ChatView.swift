import SwiftUI

struct ChatView: View {
    @State private var isSettingsShown: Bool = false

    var body: some View {
        VStack {
            header
            Spacer()
            AppTextField(placeholder: "Message...", submitText: "Send", onCommit: onSend, keyBoardType: .default)
                .frame(width: 350, height: 40)
                .padding(.horizontal)
                .padding(.bottom, 10)
        }
        .sheet(isPresented: $isSettingsShown) {
            VStack {}
        }
    }

    func onSend(_ message: String) {}

    var header: some View {
        ZStack {
            HStack {
                HStack {
                    Image(Images.shield)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 25)
                    Text("Arthur")
                        .font(.custom(Fonts.interBold, size: 20))
                }
            }
            Image(systemName: "gearshape")
                .align(.trailing)
                .padding(.trailing)
                .onTapGesture(perform: { isSettingsShown = true })
        }
    }
}

#Preview {
    ChatView()
}
