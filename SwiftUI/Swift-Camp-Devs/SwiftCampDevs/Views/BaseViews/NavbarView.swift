import SwiftUI

struct NavbarView: View {
    var body: some View {
        VStack {
            Spacer()

            // Custom Navbar
            ZStack {
                // Tab Bar Background
                HStack(spacing: 0) {
                    Spacer()
                    ForEach(TabItem.allCases, id: \.self) { item in
                        if item == .addButton {
                            Spacer(minLength: 32) // Space for "+" button
                        } else {
                            TabBarButton(iconName: item.iconName, label: item.label)
                            Spacer()
                        }
                    }
                }
                .frame(height: 64)
                .background(Color.black)
                .cornerRadius(5)
                .shadow(radius: 10)

                // Central "+" Button with Border
                Circle()
                    .foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 1) // Black border
                    )
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(Color.black)
                            .font(.largeTitle)
                    )
                    .offset(y: -20)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Tab items for easy customization and reuse
enum TabItem: CaseIterable {
    case home, explore, addButton, portfolio, profile

    var iconName: String {
        switch self {
        case .home: return "house"
        case .explore: return "magnifyingglass"
        case .portfolio: return "phone"
        case .profile: return "person"
        case .addButton: return ""
        }
    }

    var label: String {
        switch self {
        case .home: return "Home"
        case .explore: return "Explore"
        case .portfolio: return "Portfolio"
        case .profile: return "Profile"
        case .addButton: return ""
        }
    }
}

// A reusable component for each tab button in the navbar
struct TabBarButton: View {
    let iconName: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView()
    }
}
