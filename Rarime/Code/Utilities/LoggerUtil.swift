import Foundation
import OSLog

class LoggerUtil {
    static let subsystem = Bundle.main.bundleIdentifier ?? "Undefined"

    static let common = Logger(subsystem: subsystem, category: "Common")
}
