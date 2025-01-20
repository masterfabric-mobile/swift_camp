import SwiftUI

// Enum for text type
enum TextType {
    case title
    case subtitle
    case body
    case caption

    var font: Font {
        switch self {
        case .title:
            return .largeTitle
        case .subtitle:
            return .title2
        case .body:
            return .body
        case .caption:
            return .caption
        }
    }
}

// Enum for text color
enum TextColor {
    case white
    case black
    case lightGray
    case darkGray
    case warning
    case success
    case powderBlue
    case custom(Color)
    
    var color: Color {
        switch self {
        case .white:
            return AppColors.white
        case .black:
            return AppColors.black
        case .powderBlue:
            return AppColors.powderBlue
        case .lightGray:
            return AppColors.lightGray
        case .darkGray:
            return AppColors.darkGray
        case .warning:
            return AppColors.warningColor
        case .success:
            return AppColors.successColor
        case .custom(let color):
            return color
        }
    }
}

// Enum for text alignment
enum TextAlignmentType {
    case leading
    case center
    case trailing

    var value: TextAlignment {
        switch self {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}

// Enum for line spacing
enum LineSpacing {
    case none
    case small
    case normal
    case large
    case custom(CGFloat)

    var value: CGFloat {
        switch self {
        case .none:
            return 0
        case .small:
            return 2
        case .normal:
            return 4
        case .large:
            return 8
        case .custom(let spacing):
            return spacing
        }
    }
}

// Enum for padding
enum TextPadding {
    case none
    case small
    case medium
    case large
    case custom(EdgeInsets)

    var value: EdgeInsets {
        switch self {
        case .none:
            return EdgeInsets()
        case .small:
            return EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        case .medium:
            return EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        case .large:
            return EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        case .custom(let insets):
            return insets
        }
    }
}

// Enum for background style
enum BackgroundStyle {
    case none
    case color(Color, cornerRadius: CGFloat = 0)
    
    var color: Color? {
        switch self {
        case .none:
            return nil
        case .color(let color, _):
            return color
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .none:
            return 0
        case .color(_, let radius):
            return radius
        }
    }
}

// Enum for shadow style
enum ShadowStyle {
    case none
    case light
    case medium
    case dark
    case custom(Color, radius: CGFloat)

    var color: Color {
        switch self {
        case .none:
            return .clear
        case .light:
            return .gray
        case .medium:
            return .black.opacity(0.5)
        case .dark:
            return .black
        case .custom(let color, _):
            return color
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .none:
            return 0
        case .light:
            return 2
        case .medium:
            return 4
        case .dark:
            return 6
        case .custom(_, let radius):
            return radius
        }
    }
}

// Enum for regex patterns
enum RegexPattern: String {
    //case email = "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}"
    case phone = "\\b\\d{3}[-.]?\\d{3}[-.]?\\d{4}\\b"
    case url = "https?://[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    case keyword = "\\b(SwiftUI|easy)\\b"
    
    case username = "^[a-zA-Z0-9_]+$"
    case password = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?\":{}|<>])[A-Za-z0-9!@#$%^&*(),.?\":{}|<>]{8,64}$"
    case email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    case name = "^[a-zA-Z ]+$"
    //case phone = "^\\+?[1-9]\\d{1,14}$" // E.164 format
    case numeric = "^\\d+(\\.\\d+)?$"
    
    var pattern: String {
        self.rawValue
    }
}

