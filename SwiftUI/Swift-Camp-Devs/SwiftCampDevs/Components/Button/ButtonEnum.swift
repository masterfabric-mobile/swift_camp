import SwiftUI

enum ButtonType {
    case normal, text, icon

    var textColor: Color {
        switch self {
        case .normal: return .white
        case .text: return .black
        case .icon: return .black
        }
    }

    var backgroundColor: Color {
        switch self {
        case .normal: return .black
        case .text: return .clear
        case .icon: return .gray
        }
    }

    var iconSize: CGFloat {
        switch self {
        case .icon: return UISizerHelper.IconSize.normal
        default: return 0
        }
    }
}

enum ButtonSize {
    case extraSmall, small, medium, large

    var fontSize: CGFloat {
        switch self {
        case .extraSmall: return UISizerHelper.ButtonSize.extraSmall
        case .small: return UISizerHelper.ButtonSize.small
        case .medium: return UISizerHelper.ButtonSize.medium
        case .large: return UISizerHelper.ButtonSize.large
        }
    }

    var padding: EdgeInsets {
        switch self {
        case .extraSmall: return EdgeInsets(
            top: UISizerHelper.Dimensions.low,
            leading: UISizerHelper.Dimensions.small,
            bottom: UISizerHelper.Dimensions.low,
            trailing: UISizerHelper.Dimensions.small
        )
        case .small: return EdgeInsets(
            top: UISizerHelper.Dimensions.small,
            leading: UISizerHelper.Dimensions.normal,
            bottom: UISizerHelper.Dimensions.small,
            trailing: UISizerHelper.Dimensions.normal
        )
        case .medium: return EdgeInsets(
            top: UISizerHelper.Dimensions.normal,
            leading: UISizerHelper.Dimensions.medium,
            bottom: UISizerHelper.Dimensions.normal,
            trailing: UISizerHelper.Dimensions.medium
        )
        case .large: return EdgeInsets(
            top: UISizerHelper.Dimensions.normal,
            leading: UISizerHelper.Dimensions.high,
            bottom: UISizerHelper.Dimensions.normal,
            trailing: UISizerHelper.Dimensions.high
        )
        }
    }
}
