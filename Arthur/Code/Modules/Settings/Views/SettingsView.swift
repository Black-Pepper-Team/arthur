import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appManager: AppManager

    @State private var isTextToSpeechEnabled: Bool = AppUserDefaults.shared.isTextToSpeechEnable

    var body: some View {
        VStack {
            Text("Settings")
                .font(.custom(Fonts.interBold, size: 35))
                .padding(.top)
            Toggle(isOn: $isTextToSpeechEnabled) {
                Text("Enable Text-to-Speech")
            }
            .frame(width: 350)
            .padding(.vertical)
            Divider()
            Spacer()
            AppButton(text: "Logout", action: clearAppdata)
                .frame(width: 350, height: 50)
        }
        .onChange(of: isTextToSpeechEnabled) { _, newValue in
            AppUserDefaults.shared.isTextToSpeechEnable = newValue
        }
    }

    func clearAppdata() {
        AppUserDefaults.shared.userId = ""
        AppUserDefaults.shared.areCapabilitiesShown = true
        AppUserDefaults.shared.lastMessageId = ""
        AppUserDefaults.shared.isParticipatingInBeautyContest = false

        AppManager.shared.isIntroShown = true
        AppManager.shared.areCapabilitiesShown = true
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppManager.shared)
}
