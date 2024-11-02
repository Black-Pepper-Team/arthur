import SwiftUI

struct ChatView: View {
    @State private var isSettingsShown: Bool = false

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            header
            Spacer()
            messages
                .padding(.vertical)
            Divider()
                .padding(.bottom, 10)
            AppTextField(placeholder: "Message...", submitText: "Send", onCommit: viewModel.sendMessage, keyBoardType: .default)
                .frame(width: 350, height: 40)
                .padding(.horizontal)
                .padding(.bottom, 10)
        }
        .sheet(isPresented: $isSettingsShown) {
            SettingsView()
        }
    }

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

    var messages: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
                    MessageView(message: message)
                }
            }
            .defaultScrollAnchor(.bottom)
        }
    }
}

struct MessageView: View {
    let message: Message

    @State private var textSize: CGSize = .zero

    var isSelf: Bool {
        message.userId == AppUserDefaults.shared.userId
    }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.customAppForeground)
                    .frame(width: textSize.width + 10, height: textSize.height + 5)
                    .opacity(isSelf ? 0.3 : 1)
                Text(message.message)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.white)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    textSize = geometry.size
                                }
                        }
                    )
            }
            .align(isSelf ? .trailing : .leading)
        }
    }
}

#Preview {
    ChatView()
}
