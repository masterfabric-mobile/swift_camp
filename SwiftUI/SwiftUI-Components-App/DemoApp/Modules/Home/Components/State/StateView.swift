import SwiftUI

struct StateView: View {

    @ObservedObject var presenter: StatePresenter
    @EnvironmentObject var sharedData: EnvironmentObjectEntity
    @Environment(\.colorScheme) private var colorScheme  // Get current theme
    @State private var isDarkModeEnabled = false  // Only for this screen (not persistent)

    var body: some View {
        VStack(spacing: 30) {
            // Header Section
            HStack {
                Button(action: presenter.goBack) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding()
                        .background(Color.primary.opacity(0.2))
                        .clipShape(Circle())
                }

                Spacer()

                VStack {
                    // Counter Label
                    Text("Global Counter")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    // Live Counter from EnvironmentObject
                    Text("🔢 \(sharedData.counter)")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)

            Spacer()

            // Explanation Section
            VStack(spacing: 10) {
                Text("🔗 What is @State?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("""
                    `@State` is used for **temporary state** within a view.
                    The theme toggle below will change **only this view**.
                    Exiting the view will reset it.
                    """)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Theme Toggle Example (Only for this screen)
            VStack(spacing: 20) {
                Text("Current Theme: \(isDarkModeEnabled ? "Dark" : "Light")")
                    .font(.headline)
                    .foregroundColor(.primary)

                Toggle("Enable Dark Mode", isOn: $isDarkModeEnabled)
                    .padding()
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(10)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .onChange(of: isDarkModeEnabled) { _ in
                        updateColorScheme()
                    }
            }
            .padding()

            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onDisappear {
            resetColorScheme() // Reset theme when exiting the screen
        }
    }

    /// Function to update the color scheme dynamically (only for this view)
    private func updateColorScheme() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return
        }
        window.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
    }

    /// Function to reset the color scheme when leaving the view
    private func resetColorScheme() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return
        }
        window.overrideUserInterfaceStyle = .unspecified // Reset to system default
    }
}
