import SwiftUI

@main
struct ArthurApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(ProofManager.shared)
                .environmentObject(AppManager.shared)
        }
    }
}
