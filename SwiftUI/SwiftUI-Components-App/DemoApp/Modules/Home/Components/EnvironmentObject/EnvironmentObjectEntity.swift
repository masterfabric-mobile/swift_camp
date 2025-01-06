import SwiftUI

final class EnvironmentObjectEntity: ObservableObject {

    // Key for UserDefaults
    private let counterKey = "environmentObjectCounter"

    @Published var counter: Int {
        didSet {
            // Save counter to UserDefaults whenever it changes
            UserDefaults.standard.set(counter, forKey: counterKey)
        }
    }

    init() {
        // Load counter from UserDefaults if it exists, otherwise set to 0
        self.counter = UserDefaults.standard.object(forKey: counterKey) as? Int ?? 0
    }
}
