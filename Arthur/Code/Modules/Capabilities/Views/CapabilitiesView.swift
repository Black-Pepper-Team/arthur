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
                .disabled(!viewModel.wasAtleastOneCapabilitySelected)
        }
        .onAppear(perform: viewModel.requestAICapabilities)
        .environmentObject(viewModel)
    }

    func capabilitiesView(_ capabilities: [AICapability]) -> some View {
        ScrollView {
            VStack {
                ForEach(capabilities, id: \.id) { capability in
                    CapabilityView(capability: capability, onEnable: viewModel.sendAIPermission)
                }
            }
        }
    }
}

struct CapabilityView: View {
    @EnvironmentObject private var viewModel: CapabilitiesView.ViewModel

    let capability: AICapability

    @State private var isEnabled: Bool = false
    @State private var isConfirmed: Bool = false

    let onEnable: (AICapability, String) -> Void

    var height: CGFloat {
        if isEnabled && isConfirmed {
            return 50
        } else if isEnabled {
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
                if isEnabled && !isConfirmed {
                    AppTextField(placeholder: "Money limit...", submitText: "Submit") { text in
                        isConfirmed = true

                        self.viewModel.wasAtleastOneCapabilitySelected = true

                        onEnable(capability, text)
                    }
                    .frame(width: 300, height: 40)
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
