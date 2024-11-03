import Alamofire
import Foundation

class BeautyContest {
    static let shared = API()

    let url: URL

    init() {
        url = Config.beautyContestUrl
    }

    func participate(_ request: BeautyContestParticipantRequest) async throws {
        let requestUrl = url.appendingPathComponent("participate")

        _ = try await AF.request(requestUrl, method: .post, parameters: request)
            .serializingData()
            .result
            .get()
    }
}

struct BeautyContestParticipantRequest: Codable {
    let proof: ZkProof
    let name: String
    let imageBase64: String
}
