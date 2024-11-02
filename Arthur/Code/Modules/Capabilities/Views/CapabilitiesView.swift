import SwiftUI

struct CapabilitiesView: View {
    @StateObject private var viewModel = CapabilitiesView.ViewModel()

    let onContinue: () -> Void

    var body: some View {
        VStack {
            Text("AI Capabilities")
                .font(.custom(Fonts.interBold, size: 35))
            Spacer()
            capabilitiesView(viewModel.capabilities)
                .isLoading(viewModel.capabilities.isEmpty)
            Spacer()
            AppButton(text: "Continue", action: onContinue)
                .frame(width: 350, height: 50)
        }
        .onAppear(perform: viewModel.requestAICapabilities)
    }

    func capabilitiesView(_ capabilities: [AICapability]) -> some View {
        ScrollView {
            VStack {
                ForEach(capabilities, id: \.id) { capability in
                    CapabilityView(capability: capability) { _, _ in
                    }
                }
            }
        }
    }
}

struct CapabilityView: View {
    let capability: AICapability

    @State private var isEnabled: Bool = false
    @State private var isConfirmed: Bool = false

    let onEnable: (AICapability, String) -> Void

    var height: CGFloat {
        if isEnabled {
            return 100
        } else {
            return 50
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.customAppForeground)
            VStack {
                Toggle(isOn: $isEnabled) {
                    Text(capability.name)
                        .font(.custom(Fonts.interBold, size: 20))
                }
                .padding(.horizontal)
                if isEnabled {
                    AppTextField { _ in
                        isConfirmed = true
                    }
                }
            }
        }
        .frame(width: 350, height: height)
        .disabled(isConfirmed)
    }
}

#Preview {
    CapabilitiesView {}
}