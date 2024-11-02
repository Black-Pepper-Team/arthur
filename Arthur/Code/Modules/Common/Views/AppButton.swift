import SwiftUI

struct AppButton: View {
    let text: String

    let shouldLockOnAction: Bool

    let action: () -> Void

    init(text: String, shouldLockOnAction: Bool = false, action: @escaping () -> Void) {
        self.text = text
        self.shouldLockOnAction = shouldLockOnAction
        self.action = action
    }

    @State private var isLocked: Bool = false

    var body: some View {
        Button(
            action: {
                if shouldLockOnAction {
                    isLocked = true
                }

                action()
            }
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.customAppForeground)
                Text(text)
                    .font(.custom(Fonts.interBold, size: 16))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
        .disabled(isLocked)
    }
}

#Preview {
    AppButton(text: "Continue") {}
        .frame(width: 350, height: 50)
}
