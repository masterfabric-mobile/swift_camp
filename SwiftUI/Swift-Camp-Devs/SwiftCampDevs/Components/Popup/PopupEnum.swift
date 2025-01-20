import Foundation
import SwiftUI

enum PopupType {
    case info
    case error
    case confirmation
    case custom(icon: String, color: Color)

    var titleColor: Color {
        switch self {
        case .info:
            return .blue
        case .error:
            return .red
        case .confirmation:
            return .green
        case .custom(_, let color):
            return color
        }
    }

    var icon: String? {
        switch self {
        case .info:
            return "info.circle"
        case .error:
            return "xmark.octagon"
        case .confirmation:
            return "checkmark.circle"
        case .custom(let icon, _):
            return icon
        }
    }
}

enum PopupDimensions {
    case small
    case medium
    case large
    case full

    var size: CGSize {
        let screenWidth = UISizerHelper.Screen.width
        let screenHeight = UISizerHelper.Screen.height
        switch self {
        case .small:
            return CGSize(width: screenWidth * 0.4, height: screenHeight * 0.2)
        case .medium:
            return CGSize(width: screenWidth * 0.6, height: screenHeight * 0.4)
        case .large:
            return CGSize(width: screenWidth * 0.8, height: screenHeight * 0.6)
        case .full:
            return CGSize(width: screenWidth, height: screenHeight)
        }
    }

    var cornerRadius: CGFloat {
        switch self {
        case .small:
            return UISizerHelper.Radius.low
        case .medium:
            return UISizerHelper.Radius.normal
        case .large:
            return UISizerHelper.Radius.medium
        case .full:
            return UISizerHelper.Radius.none
        }
    }
}

struct PopupAction: Identifiable {
    let id = UUID()
    let title: String
    let handler: () -> Void
    let isDestructive: Bool

    init(title: String, isDestructive: Bool = false, handler: @escaping () -> Void) {
        self.title = title
        self.isDestructive = isDestructive
        self.handler = handler
    }

    var textColor: Color {
        isDestructive ? .red : .primary
    }
}


