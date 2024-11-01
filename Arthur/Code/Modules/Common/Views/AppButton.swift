import SwiftUI

struct AppButton: View {
    let text: String
    let action: () -> Void

    let shouldLockOnAction: Bool = false

    @State private var isLocked: Bool = false

    var body: some View {
        Button(
            action: {
                isLocked = true

                action()
            }
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.customAppForeground)
                Text(text)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.white)
            }
            .frame(width: 350, height: 50)
        }
        .buttonStyle(.plain)
        .disabled(isLocked)
    }
}

#Preview {
    AppButton(text: "Continue") {}
}
