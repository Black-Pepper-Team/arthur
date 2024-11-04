import AVFoundation
import Foundation

class AVManager {
    static let shared = AVManager()

    func textToSpeech(text: String) {
//        if !AppUserDefaults.shared.isTextToSpeechEnable {
//            return
//        }

        let voice = AVSpeechSynthesisVoice.speechVoices().first { voice in
            voice.quality == .default
        }

        LoggerUtil.common.debug("voice: \(voice)")
        LoggerUtil.common.debug("text: \(text)")

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: voice?.identifier ?? "")

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
