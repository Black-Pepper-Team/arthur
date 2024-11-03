import SwiftUI

struct BeautyContestView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            if viewModel.isParticipatingInBeautyContest {
                VStack {}
            } else {
                BeautyContestParticipatingView()
            }
        }
        .environmentObject(viewModel)
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
            Text("The Veiled Contest of Beauty ")
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
            AppButton(text: "Participant", action: participant)
                .frame(width: 350, height: 50)
        }
    }

    func participant() {
        AppUserDefaults.shared.isParticipatingInBeautyContest = true
        viewModel.isParticipatingInBeautyContest = true
    }
}

#Preview {
    BeautyContestView()
}
