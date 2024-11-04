import SwiftUI

struct BeautyContestView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            if viewModel.isParticipatingInBeautyContest {
                BeautyContestParticipatsView()
            } else {
                BeautyContestParticipatingView()
            }
        }
        .environmentObject(viewModel)
    }
}

struct BeautyContestParticipatsView: View {
    @EnvironmentObject private var viewModel: BeautyContestView.ViewModel

    var body: some View {
        VStack {
            Text("Participants")
                .font(.custom(Fonts.interBold, size: 35))
                .padding(.vertical)
            Spacer()
            participantsView
                .isLoading(viewModel.participants.isEmpty)
            Spacer()
        }
        .onAppear(perform: viewModel.loadParticipants)
    }

    var participantsView: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.participants, id: \.name) { participant in
                    PartificipantView(participant: participant)
                        .padding(.bottom)
                }
            }
        }
    }
}

struct PartificipantView: View {
    @EnvironmentObject private var viewModel: BeautyContestView.ViewModel

    let participant: BeautyContestParticipant

    var isWinner: Bool { participant.name == viewModel.winner }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 350)
                    .foregroundStyle(isWinner ? .gold : .customAppForeground)
                    .opacity(isWinner ? 1 : 0.5)
                VStack {
                    if let uiimage = participant.uiimage {
                        Image(uiImage: uiimage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .padding(.vertical, 5)
                    } else {
                        Image(systemName: "photo")
                            .padding(.vertical, 5)
                    }

                    (Text(participant.name) + Text(isWinner ? "🥇" : ""))
                        .font(.custom(Fonts.interBold, size: 20))
                        .foregroundStyle(isWinner ? .customAppBackground : .white)
                        .lineLimit(1)
                    Text("\(String(format: "%.1f", participant.percentage))%")
                        .font(.custom(Fonts.interBold, size: 20))
                        .foregroundStyle(isWinner ? .customAppBackground : .white)
                        .padding(.horizontal)
                        .padding(.top, 5)
                }
                .padding(.vertical)
            }
            Divider()
        }
    }
}

struct BeautyContestParticipatingView: View {
    @EnvironmentObject private var viewModel: BeautyContestView.ViewModel

    var body: some View {
        VStack {
            Spacer()
            Image(.goddess)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
                .foregroundStyle(.white)
            Text("The Veiled Contest of Beauty")
                .font(.custom(Fonts.interBold, size: 25))
                .multilineTextAlignment(.center)
                .frame(width: 250)
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.customAppForeground)
                    .opacity(0.5)
                Text("Enter this contest of beauty without fear, for even Aphrodite shall not see your true form. Cloaked in secrecy, only your beauty is judged, while your true self remains hidden—safe from divine envy. Compete boldly, gaining admiration without the risk of being revealed")
                    .font(.custom(Fonts.interRegular, size: 16))
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)
                    .padding(.horizontal, 10)
            }
            .frame(width: 350, height: 170)
            .padding(.bottom)
            Spacer()
            if viewModel.isLoading {
                ProgressView()
            } else {
                AppTextField(placeholder: "Name...", submitText: "Commit", onCommit: viewModel.participate, keyBoardType: .default)
                    .padding(25)
            }
        }
    }
}

#Preview {
    BeautyContestView()
}
