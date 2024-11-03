import Foundation

extension BeautyContestView {
    class ViewModel: ObservableObject {
        @Published var isParticipatingInBeautyContest = AppUserDefaults.shared.isParticipatingInBeautyContest
    }
}
