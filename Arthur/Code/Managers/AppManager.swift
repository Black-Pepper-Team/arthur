import SwiftUI

class AppManager: ObservableObject {
    static let shared = AppManager()

    @Published var isIntroShown = true
    @Published var areCapabilitiesShown = AppUserDefaults.shared.areCapabilitiesShown
}
