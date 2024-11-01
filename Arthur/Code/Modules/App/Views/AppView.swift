import SwiftUI
import UIKit

struct AppView: View {
    var body: some View {
        ZStack {
            IntroView()
        }
        .preferredColorScheme(.dark)
        .onAppear {
            UIApplication.sharedApplication().idleTimerDisabled = true
        }
    }
}

#Preview {
    AppView()
}
