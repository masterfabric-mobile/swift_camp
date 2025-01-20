enum ToggleState {
    case on
    case off
    
    var label: String {
        switch self {
        case .on:
            return "ON"
        case .off:
            return "OFF"
        }
    }
}
