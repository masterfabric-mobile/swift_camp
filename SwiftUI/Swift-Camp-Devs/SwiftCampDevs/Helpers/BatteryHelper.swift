import SwiftUI
import Combine

final class BatteryHelper: ObservableObject {
    // MARK: - Singleton Instance
    static let shared = BatteryHelper()

    // MARK: - Published Properties to Notify SwiftUI
    @Published var batteryLevel: Int = 0
    @Published var batteryStateDescription: String = "Unknown"
    @Published var batteryColor: Color = .gray

    // MARK: - Private Properties
    private var simulatedBatteryLevel: Int = Int.random(in: 0...100)  // Random initial value
    private var simulatedBatteryState: UIDevice.BatteryState = .unplugged
    private var timer: Timer?
    private var isSimulating: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    private var lastUpdateTime: Date = Date()

    // MARK: - Initialization
    private init() {
        LoggerHelper.shared.info("🔋🪫 Battery Monitoring Initialized")
        UIDevice.current.isBatteryMonitoringEnabled = true // Enable battery monitoring
        updateBatteryInfo()
        startSimulationIfNeeded()
        startBatteryUpdateTimer()
    }

    // MARK: - Public Methods

    /// Updates the battery information and publishes changes
    func updateBatteryInfo() {
        if isSimulating {
            batteryLevel = simulatedBatteryLevel
            batteryStateDescription = simulatedBatteryState.description
            batteryColor = simulatedBatteryStateColor()
        } else {
            batteryLevel = max(0, Int(UIDevice.current.batteryLevel * 100))
            batteryStateDescription = UIDevice.current.batteryState.description
            batteryColor = getBatteryStateColor()
        }

        LoggerHelper.shared.info("🔋 Battery Info Updated: Level: \(batteryLevel)% | State: \(batteryStateDescription)")
    }

    // MARK: - Timer Methods

    /// Start battery update timer
    private func startBatteryUpdateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.updateBatteryInfo()
            let elapsedTime = TimeHelper.shared.getElapsedTime(from: self?.lastUpdateTime ?? Date())
            LoggerHelper.shared.debug("Battery updated after \(elapsedTime)")
            self?.lastUpdateTime = Date()
        }
    }

    // MARK: - Private Simulation Methods

    /// Starts battery simulation for the simulator
    private func startSimulationIfNeeded() {
        guard isSimulating else { return }
        LoggerHelper.shared.info("🔧 Starting battery simulation.")
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.updateSimulatedBatteryLevel()
            self?.updateBatteryInfo()
        }
    }

    /// Stops the simulation timer
    func stopSimulation() {
        timer?.invalidate()
        timer = nil
        LoggerHelper.shared.info("🔧 Stopped battery simulation.")
    }

    /// Updates simulated battery values over time
    private func updateSimulatedBatteryLevel() {
        let previousLevel = simulatedBatteryLevel
        let previousState = simulatedBatteryState

        // Randomly increase or decrease battery level
        let change = Int.random(in: -20...10)
        simulatedBatteryLevel = max(0, min(100, simulatedBatteryLevel + change))

        // Update the simulated battery state based on the new level
        if simulatedBatteryLevel == 100 {
            simulatedBatteryState = .full
        } else if change > 0 {
            simulatedBatteryState = .charging
        } else if simulatedBatteryLevel < 20 {
            simulatedBatteryState = .unplugged
            LoggerHelper.shared.warning("⚠️ Low Battery Warning! Current level: \(simulatedBatteryLevel)%")
        } else {
            simulatedBatteryState = .unplugged
        }

        // Log changes
        if simulatedBatteryLevel != previousLevel {
            LoggerHelper.shared.info("🔋 Battery Level changed: \(previousLevel)% → \(simulatedBatteryLevel)%")
        }
        if simulatedBatteryState != previousState {
            LoggerHelper.shared.info("⚡ Battery State changed: \(previousState.description) → \(simulatedBatteryState.description)")
        }
    }

    // MARK: - Battery State Color Methods

    /// Gets the color for the current battery state
    private func getBatteryStateColor() -> Color {
        if batteryLevel < 10 {
            return .red // Change color to red when battery level is less than 10
        } else if batteryLevel <= 20 {
            return .blue // Change color to blue when battery level is between 10 and 20
        }

        switch UIDevice.current.batteryState {
        case .unplugged:
            return .yellow
        case .charging:
            return .green
        case .full:
            return .blue
        case .unknown:
            return .gray
        @unknown default:
            return .gray
        }
    }

    /// Gets the color for the simulated battery state
    private func simulatedBatteryStateColor() -> Color {
        if simulatedBatteryLevel < 10 {
            return .red
        } else if simulatedBatteryLevel <= 20 {
            return .blue
        }
        switch simulatedBatteryState {
        case .unplugged:
            return .yellow
        case .charging:
            return .green
        case .full:
            return .blue
        case .unknown:
            return .gray
        @unknown default:
            return .gray
        }
    }
}

extension UIDevice.BatteryState {
    // MARK: - Battery State Description
    /// Provide a string description for the battery state
    var description: String {
        switch self {
        case .unplugged: return "Unplugged"
        case .charging: return "Charging"
        case .full: return "Full"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown"
        }
    }
}
