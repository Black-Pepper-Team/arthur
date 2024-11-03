import Foundation

extension BeautyContestView {
    class ViewModel: ObservableObject {
        @Published var isParticipatingInBeautyContest = AppUserDefaults.shared.isParticipatingInBeautyContest

        @Published var isLoading: Bool = false

        func participate(_ name: String) {
            isLoading = true

            Task { @MainActor in
                defer { isLoading = false }

                do {
                    try await _participate(name)

                    isParticipatingInBeautyContest = true
                    AppUserDefaults.shared.isParticipatingInBeautyContest = true
                } catch {
                    LoggerUtil.common.error("error: \(error)")

                    isParticipatingInBeautyContest = true
                }
            }
        }

        func _participate(_ name: String) async throws {
            let (proof, image) = try await ProofManager.shared.requestProtoProof()

            let participateRequest = BeautyContestParticipantRequest(
                proof: proof,
                name: name,
                imageBase64: image
            )

            try await BeautyContest.shared.participate(participateRequest)
        }
    }
}
