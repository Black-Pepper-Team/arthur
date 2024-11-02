import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appManager: AppManager

    var body: some View {
        VStack {
            Text("Settings")
                .font(.custom(Fonts.interBold, size: 35))
                .padding(.top)
            Spacer()
            AppButton(text: "Logout", action: clearAppdata)
                .frame(width: 350, height: 50)
        }
    }

    func clearAppdata() {
        AppUserDefaults.shared.userId = ""
        AppUserDefaults.shared.areCapabilitiesShown = true

        AppManager.shared.isIntroShown = true
        AppManager.shared.areCapabilitiesShown = true
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppManager.shared)
}
