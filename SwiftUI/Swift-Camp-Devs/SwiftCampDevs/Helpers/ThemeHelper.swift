import UIKit
import SwiftUI

enum ThemeType: String {
    case dark
    case light
    case custom
}

struct CustomTheme: Codable {
    let black: String
    let white: String
    let darkGray: String
    let softGray: String
    let lightGray: String
    let powderBlue: String
    let blue: String
    let successColor: String
    let warningColor: String
}

enum ThemeColor: String {
    case black, white, darkGray, softGray, lightGray, powderBlue, blue
    case successColor, warningColor
}

class ThemeHelper {
    static let shared = ThemeHelper()
    
    @Published private(set) var themeType: ThemeType = .light {
        didSet {
            UserDefaults.standard.set(themeType.rawValue, forKey: "selectedTheme")
        }
    }
    
    @Published var customTheme: CustomTheme?
    
    private init() {
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme"),
           let theme = ThemeType(rawValue: savedTheme) {
            self.themeType = theme
        } else {
            self.themeType = .light
        }
    }
    
    func applyTheme(_ theme: ThemeType) {
        themeType = theme
        switch theme {
        case .dark:
            applyDarkTheme()
        case .light:
            applyLightTheme()
        case .custom:
            loadCustomTheme()
            applyCustomTheme()
        }
    }
    
    private func applyDarkTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    }
    
    private func applyLightTheme() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
    }
    
    private func loadCustomTheme() {
        if let url = Bundle.main.url(forResource: "CustomTheme", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                customTheme = try JSONDecoder().decode(CustomTheme.self, from: data)
            } catch {
                LoggerHelper.shared.error("Failed to load custom theme from JSON: \(error)")
            }
        } else {
            LoggerHelper.shared.error("CustomTheme.json not found in bundle")
        }
    }
    
    private func applyCustomTheme() {
        guard let theme = customTheme else {
            LoggerHelper.shared.error("Custom theme not loaded")
            return
        }
        
        // Convert hex strings to UIColors
        let black = UIColor(hex: theme.black)
        let white = UIColor(hex: theme.white)
        let darkGray = UIColor(hex: theme.darkGray)
        let softGray = UIColor(hex: theme.softGray)
        let lightGray = UIColor(hex: theme.lightGray)
        let powderBlue = UIColor(hex: theme.powderBlue)
        let blue = UIColor(hex: theme.blue)
        let successColor = UIColor(hex: theme.successColor)
        let warningColor = UIColor(hex: theme.warningColor)
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            LoggerHelper.shared.error("No window scene found")
            return
        }
        
        windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = .unspecified
            window.backgroundColor = warningColor
            window.rootViewController?.view.backgroundColor = warningColor

                
                // Navigation Bar
                let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.backgroundColor = white
                navBarAppearance.titleTextAttributes = [.foregroundColor: black]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: black]
                
                UINavigationBar.appearance().standardAppearance = navBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
                UINavigationBar.appearance().compactAppearance = navBarAppearance
                UINavigationBar.appearance().tintColor = blue
                
                // Tab Bar
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = white
                UITabBar.appearance().standardAppearance = tabBarAppearance
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UITabBar.appearance().tintColor = blue
                
                // Controls
                UIButton.appearance().backgroundColor = blue
                UIButton.appearance().tintColor = white
                UIButton.appearance().setTitleColor(warningColor, for: .disabled)
                
                UITextField.appearance().backgroundColor = softGray
                UITextField.appearance().textColor = black
                UITextField.appearance().tintColor = blue
                
                // Global appearances
                UIView.appearance().tintColor = blue
                UILabel.appearance().textColor = black
                UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = black
                UILabel.appearance().backgroundColor = .clear
                
                // Status appearances
                UIActivityIndicatorView.appearance().color = blue
                UIProgressView.appearance().progressTintColor = blue
                UIProgressView.appearance().trackTintColor = powderBlue
                UISlider.appearance().thumbTintColor = blue
                UISwitch.appearance().onTintColor = successColor
                UISwitch.appearance().thumbTintColor = white
                
                // Divider and shadow colors
                UIView.appearance().layer.borderColor = lightGray.cgColor
                UIView.appearance().layer.shadowColor = darkGray.cgColor
            }
    }
    
    
    
    func color(for key: ThemeColor) -> Color {
        if themeType != .custom {
            /// Use AppColors for light and dark themes
            let colorMap: [ThemeColor: Color] = [
                .black: AppColors.black,
                .white: AppColors.white,
                .darkGray: AppColors.darkGray,
                .softGray: AppColors.softGray,
                .lightGray: AppColors.lightGray,
                .powderBlue: AppColors.powderBlue,
                .blue: AppColors.blue,
                .successColor: AppColors.successColor,
                .warningColor: AppColors.warningColor
            ]
            return colorMap[key] ?? Color.black
        }
        
        /// Use custom colors from CustomTheme.json
        guard let customTheme = customTheme else {
            return Color.black
        }
        
        let colorMap: [ThemeColor: String] = [
            .black: customTheme.black,
            .white: customTheme.white,
            .darkGray: customTheme.darkGray,
            .softGray: customTheme.softGray,
            .lightGray: customTheme.lightGray,
            .powderBlue: customTheme.powderBlue,
            .blue: customTheme.blue,
            .successColor: customTheme.successColor,
            .warningColor: customTheme.warningColor
        ]
        
        return Color(UIColor(hex: colorMap[key] ?? "#000000"))
    }
}

// UIColor extension for hex string conversion
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
