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
            return UISizerHelper.LineSpacing.none
        case .small:
            return UISizerHelper.LineSpacing.small
        case .normal:
            return UISizerHelper.LineSpacing.normal
        case .large:
            return UISizerHelper.LineSpacing.large
        case .custom(let spacing):
            return UISizerHelper.LineSpacing.custom(spacing)
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
            return EdgeInsets(
                top: UISizerHelper.Dimensions.low,
                leading: UISizerHelper.Dimensions.low,
                bottom: UISizerHelper.Dimensions.low,
                trailing: UISizerHelper.Dimensions.low
            )
        case .medium:
            return EdgeInsets(
                top: UISizerHelper.Dimensions.normal,
                leading: UISizerHelper.Dimensions.normal,
                bottom: UISizerHelper.Dimensions.normal,
                trailing: UISizerHelper.Dimensions.normal
            )
        case .large:
            return EdgeInsets(
                top: UISizerHelper.Dimensions.medium,
                leading: UISizerHelper.Dimensions.medium,
                bottom: UISizerHelper.Dimensions.medium,
                trailing: UISizerHelper.Dimensions.medium
            )
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
            return UISizerHelper.TextRadius.none
        case .light:
            return UISizerHelper.TextRadius.light
        case .medium:
            return UISizerHelper.TextRadius.medium
        case .dark:
            return UISizerHelper.TextRadius.dark
        case .custom(_, let radius):
            return UISizerHelper.TextRadius.custom(radius)
        }
    }
}

// Enum for regex patterns
enum RegexPattern: String {

    // Matches valid URLs
    case url = #"^[a-zA-Z][a-zA-Z0-9+.-]*:\/\/(?:[a-zA-Z0-9-]+\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\/[^\s]*)?(?:\?[^\s]*)?(?:#.*)?$"#

    // Matches specific keywords "SwiftUI" or "easy" as whole words
    case keyword = "\\b(SwiftUI|easy)\\b"
    
    // Matches usernames with only letters, numbers, and underscores
    case username = "^[a-zA-Z0-9_]+$"
    
    // Matches passwords requiring at least one uppercase, one lowercase, one number, and one special character
    case password = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?\":{}|<>])[A-Za-z0-9!@#$%^&*(),.?\":{}|<>]+$"

    // Matches emails (case-insensitive)
    case email = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9]+(?:[.-][A-Za-z0-9]+)*\\.[A-Za-z]{2,}$"

	    // Matches names containing only letters and spaces
    case fullName = "^[a-zA-Z]+( [a-zA-Z]+)*$"

    // Matches E.164 phone numbers with an optional '+' prefix
    case phone = "^\\+?[1-9]\\d{1,14}$"

    // Matches numeric values, including decimals
    case numeric = "^\\d+(\\.\\d+)?$"
        
    var pattern: String {
        self.rawValue
    }
    
    // Description Strings for Regex Patterns
    var description: String {
        switch self {
        case .url:
            return "Matches valid URLs (e.g., https://www.example.com or http://example.com/path)."
        case .keyword:
            return "Matches specific keywords, such as 'SwiftUI' or 'easy', as whole words."
        case .username:
            return "Username can only contain letters, numbers, and underscores."
        case .password:
            return "Password must include uppercase, lowercase, a digit, and a special character."
        case .email:
            return "Invalid email format. Example: user@example.com"
        case .fullName:
            return "Full Name can only contain letters and spaces."
        case .phone:
            return "Invalid phone number format. Use international format (e.g., +123456789)."
        case .numeric:
            return "Value must be numeric. Example: 123 or 123.45"
        }
    }
    
    // 
    func matches(_ value: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", self.rawValue).evaluate(with: value)
    }
}
