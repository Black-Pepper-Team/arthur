import Alamofire
import Foundation
import SwiftUI

class BeautyContest {
    static let shared = BeautyContest()

    let url: URL

    init() {
        url = Config.beautyContestUrl
    }

    func participate(_ request: BeautyContestParticipantRequest) async throws {
        let requestUrl = url.appendingPathComponent("/integrations/face-extractor-svc/contest/register")

        let headers: HTTPHeaders = [
            .init(name: "Content-Type", value: "application/json")
        ]

        _ = try await AF.request(requestUrl, method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
            .serializingData()
            .result
            .get()
    }

    func participants() async throws -> BeautyContestStats {
        let requestUrl = url.appendingPathComponent("/integrations/face-extractor-svc/contest/winner")

        let response = try await AF.request(requestUrl)
            .serializingDecodable(BeautyContestStats.self)
            .result
            .get()

        return response
    }
}

struct BeautyContestParticipantRequest: Codable {
    let proof: ZkProof
    let name: String
    let imageBase64: String
}

struct BeautyContestStats: Codable {
    let winner: String?
    let winningPool: Int
    let participants: [BeautyContestParticipant]
}

struct BeautyContestParticipant: Codable {
    let name: String
    let image: String
    let percentage: Double

    var uiimage: UIImage? {
        if let data = Data(base64Encoded: image, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
