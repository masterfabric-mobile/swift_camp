import SwiftUI

struct TransactionView: View {

    @ObservedObject var presenter: TransactionPresenter
    @Namespace private var animationNamespace

    var body: some View {
        ScrollView {
            VStack(spacing: 40) { // Increased spacing for better alignment
                // Header Section
                HStack {
                    Button(action: presenter.goBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }

                    Spacer()

                    Text("Transaction Animation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)

                Spacer()

                // Animation Section (Now placed lower in the screen)
                VStack(spacing: 30) {
                    Text("Tap to Animate")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Spacer(minLength: 50) // Push animation further down

                    ZStack {
                        RoundedRectangle(cornerRadius: presenter.isExpanded ? 15 : 50) // Dynamic corner radius transition
                            .fill(LinearGradient(
                                gradient: Gradient(colors: presenter.isExpanded ? [Color.red, Color.orange] : [Color.blue, Color.cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .matchedGeometryEffect(id: "shape", in: animationNamespace)
                            .frame(
                                width: presenter.isExpanded ? 300 : 50,  // Starts narrow, expands horizontally
                                height: presenter.isExpanded ? 150 : 250 // Starts tall, shrinks vertically
                            )
                            .rotationEffect(.degrees(presenter.isExpanded ? 0 : 90)) // Rotates during transition
                            .shadow(color: Color.red.opacity(0.4), radius: presenter.isExpanded ? 10 : 5, x: 0, y: 5)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.2)) { // Creates a bouncy effect
                                    presenter.toggleExpansion()
                                }
                            }
                    }

                    Spacer(minLength: 100) // Additional spacing for better layout
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground)) // Adapts to light/dark mode
        .edgesIgnoringSafeArea(.bottom)
    }
}
