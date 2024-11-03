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
