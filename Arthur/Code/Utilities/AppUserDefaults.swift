import Foundation
import SwiftUI

public class AppUserDefaults: ObservableObject {
    public static let shared = AppUserDefaults()

    @AppStorage("user_id")
    public var userId = ""

    @AppStorage("are_capabilities_shown")
    public var areCapabilitiesShown: Bool = true
}
