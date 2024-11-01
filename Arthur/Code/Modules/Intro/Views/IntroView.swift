import SwiftUI

struct IntroView: View {
    static let infoTexts = [
        "• Reliable AI Agent",
        "• User managed AI limitations",
        "• Broad services suport"
    ]

    var onContinue: () -> Void

    var body: some View {
        VStack {
            Image(Images.shield)
                .resizable()
                .renderingMode(.template)
                .frame(width: 100, height: 125)
                .foregroundStyle(.white)
            Text("Arthur")
                .font(.system(size: 50))
                .bold()
                .foregroundStyle(.white)
                .padding()
            info
                .padding()
        }
    }

    var info: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.customAppForeground)
            VStack {
                ForEach(Self.infoTexts, id: \.self) { text in
                    Text(text)
                        .font(.system(size: 18))
                        .bold()
                        .foregroundStyle(.white)
                        .align(.leading)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
            }
        }
        .frame(width: 350, height: 150)
    }
}

#Preview {
    IntroView {}
}
