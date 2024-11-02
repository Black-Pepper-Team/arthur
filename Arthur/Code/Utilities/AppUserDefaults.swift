import Foundation
import SwiftUI

public class AppUserDefaults: ObservableObject {
    public static let shared = AppUserDefaults()

    @AppStorage("user_id")
    public var userId = ""

    @AppStorage("are_capabilities_shown")
    public var areCapabilitiesShown: Bool = true

    @AppStorage("is_text_to_speech_enable")
    public var isTextToSpeechEnable: Bool = true

    @AppStorage("last_message_id")
    public var lastMessageId: String = ""
}
