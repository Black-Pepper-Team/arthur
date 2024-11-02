import SwiftUI

struct CapabilitiesView: View {
    @StateObject private var viewModel = CapabilitiesView.ViewModel()

    var body: some View {
        VStack {
            Text("AI Capabilities")
                .font(.custom(Fonts.interBold, size: 35))
            Spacer()
        }
    }
}

#Preview {
    CapabilitiesView()
}
