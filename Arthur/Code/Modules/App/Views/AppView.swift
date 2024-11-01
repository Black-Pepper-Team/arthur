import SwiftUI

struct AppView: View {
    var body: some View {
        ZStack {
            IntroView()
        }
        .preferredColorScheme(.dark)
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
}

#Preview {
    AppView()
}
