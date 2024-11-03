import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ViewModel()

    @State private var isSettingsShown: Bool = false
    @State private var isBeautyContestShown: Bool = false

    var body: some View {
        VStack {
            header
            Spacer()
            messages
                .padding(.vertical)
            if viewModel.isWaitingForResponse {
                ProgressView()
                    .controlSize(.small)
                    .align(.leading)
                    .padding(.bottom, 5)
                    .padding(.leading, 15)
            }
            Divider()
                .padding(.bottom, 5)
            AppTextField(placeholder: "Message...", submitText: "Send", onCommit: viewModel.sendMessage, keyBoardType: .default)
                .frame(width: 350, height: 40)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .disabled(viewModel.isWaitingForResponse)
        }
        .sheet(isPresented: $isSettingsShown) {
            SettingsView()
        }
        .sheet(isPresented: $isBeautyContestShown) {
            BeautyContestView()
        }
        .onAppear {
            AVManager.shared.textToSpeech(text: viewModel.messages.first?.message ?? "")
        }
    }

    var header: some View {
        ZStack {
            HStack {
                HStack {
                    Image(Images.shield)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text("Arthur")
                        .font(.custom(Fonts.interBold, size: 20))
                }
            }
            HStack {
                Image(systemName: "medal")
                    .onTapGesture(perform: { isBeautyContestShown = true })
                Spacer()
                Image(systemName: "gearshape")
                    .onTapGesture(perform: { isSettingsShown = true })
            }
            .padding(.horizontal)
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

    var backgroundColor: Color {
        if message.isError {
            return .error
        } else if message.isError {
            return .yellow
        } else {
            return .customAppForeground
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(backgroundColor)
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
        .padding(.horizontal, 10)
    }
}

#Preview {
    ChatView()
}
