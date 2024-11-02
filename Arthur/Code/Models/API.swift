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
        let requestUrl = url.appendingPathComponent("useragent/resources")

        _ = try await AF.request(requestUrl, method: .post, parameters: permision, encoder: JSONParameterEncoder.default)
            .serializingData()
            .result
            .get()
    }

    func sendMessageToChat(_ messsage: SendableMessage) async throws {
        let requestUrl = url.appendingPathComponent("/useragent/message")

        _ = try await AF.request(requestUrl, method: .post, parameters: messsage, encoder: JSONParameterEncoder.default)
            .serializingData()
            .result
            .get()
    }

    func getMessageResponse(_ id: String) async throws -> MessageResponse {
        let requestUrl = url.appendingPathComponent("/useragent/message/\(id)")

        let response = try await AF.request(requestUrl)
            .serializingDecodable(MessageResponse.self)
            .result
            .get()

        return response
    }
}
