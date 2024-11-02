import Alamofire
import Foundation

class API {
    static let shared = API()

    let url: URL

    init() {
        url = Config.aiUrl
    }

    func requestAICapabilities() async throws -> AICapabilitiesManifest {
        let requestUrl = url.appendingPathComponent("useragent/resources")

        let response = try await AF.request(requestUrl)
            .serializingDecodable(AICapabilitiesManifest.self)
            .result
            .get()

        return response
    }

    func sendAIPermission(_ permision: AIPermission) async throws {
        let requestUrl = url.appendingPathComponent("permissions")

        _ = try await AF.request(requestUrl, method: .post, parameters: permision, encoder: JSONParameterEncoder.default)
            .serializingData()
            .result
            .get()
    }
}
