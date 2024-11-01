import SwiftUI

struct AppView: View {
    @State private var isIntroShown = true

    var body: some View {
        ZStack {
            if isIntroShown {
                IntroView {
                    isIntroShown = false
                }
            } else {
                VStack {}
            }
        }
        .preferredColorScheme(.dark)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.customAppBackground.ignoresSafeArea()
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
}

#Preview {
    AppView()
}
