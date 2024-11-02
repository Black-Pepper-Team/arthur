import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.custom(Fonts.interBold, size: 35))
            Spacer()
            AppButton(text: "Logout", action: clearAppdata)
                .frame(width: 350, height: 50)
        }
    }

    func clearAppdata() {
        AppUserDefaults.shared.userId = ""
        AppUserDefaults.shared.areCapabilitiesShown = false
    }
}

#Preview {
    SettingsView()
}
