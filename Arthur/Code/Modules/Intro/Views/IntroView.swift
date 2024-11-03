import SwiftUI

struct IntroView: View {
    static let infoTexts = [
        "• Reliable AI Agent",
        "• User managed AI limitations",
        "• Broad services support"
    ]

    var onContinue: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Image(Images.shield)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .foregroundStyle(.white)
            Text("Arthur")
                .font(.custom(Fonts.interBold, size: 50))
                .bold()
                .foregroundStyle(.white)
                .padding()
            info
                .padding()
            Spacer()
            AppButton(text: "Continue", action: onContinue)
                .frame(width: 350, height: 50)
        }
    }

    var info: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.customAppForeground)
                .opacity(0.5)
            VStack {
                ForEach(Self.infoTexts, id: \.self) { text in
                    Text(text)
                        .font(.custom(Fonts.interRegular, size: 16))
                        .foregroundStyle(.white)
                        .align(.leading)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
            }
        }
        .frame(width: 350, height: 140)
    }
}

#Preview {
    IntroView {}
}
