import SwiftUI

struct EnvironmentObjectView: View {

    @ObservedObject var presenter: EnvironmentObjectPresenter
    @EnvironmentObject var sharedData: EnvironmentObjectEntity

    @Environment(\.colorScheme) var colorScheme

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
            }
            .padding(.horizontal)

            Spacer()

            // Explanation Section
            VStack(spacing: 10) {
                Text("🔗 What is EnvironmentObject?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("""
                    `EnvironmentObject` allows data to be shared across multiple views **without manual passing**.
                    
                    The counter below is globally accessible and updates in all views that use it.
                    """)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Counter Display
            Text("\(sharedData.counter)")
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .foregroundColor(.blue)

            Text("Shared Counter Value")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Counter Controls
            HStack(spacing: 40) {
                Button(action: {
                    presenter.decrementCounter()
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                        .shadow(radius: colorScheme == .dark ? 0 : 3)
                }

                Button(action: {
                    presenter.incrementCounter()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.green)
                        .shadow(radius: colorScheme == .dark ? 0 : 3)
                }
            }

            // Reset Button
            Button(action: {
                sharedData.counter = 0
            }) {
                Text("Reset Counter")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: colorScheme == .dark ? 0 : 3)
            }
            .padding(.horizontal, 40)

            // Navigation Hint
            Text("To see the counter update globally, navigate to the **StateView**.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
    }
}
