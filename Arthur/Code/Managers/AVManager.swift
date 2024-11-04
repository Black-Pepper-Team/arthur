import AVFoundation
import Foundation

class AVManager {
    static let shared = AVManager()

    func textToSpeech(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
