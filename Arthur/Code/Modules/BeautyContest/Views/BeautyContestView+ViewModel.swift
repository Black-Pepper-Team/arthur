import Foundation

extension BeautyContestView {
    class ViewModel: ObservableObject {
        @Published var isParticipatingInBeautyContest = AppUserDefaults.shared.isParticipatingInBeautyContest

        @Published var isLoading: Bool = false

        @Published var participants: [BeautyContestParticipant] = [
            .init(name: "Joe Biden", image: StaticImages.testImageBase64)
        ]

        func loadParticipants() {
            Task { @MainActor in
                do {
                    let participantsState = try await BeautyContest.shared.participants()

                    participants = participantsState.participants
                } catch {
                    LoggerUtil.common.error("error: \(error)")
                }
            }
        }

        func participate(_ name: String) {
            isLoading = true

            Task { @MainActor in
                defer { isLoading = false }

                do {
                    try await _participate(name)

                    isParticipatingInBeautyContest = true
                    AppUserDefaults.shared.isParticipatingInBeautyContest = true

                    LoggerUtil.common.info("User successfully participated in the beauty contest")
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
