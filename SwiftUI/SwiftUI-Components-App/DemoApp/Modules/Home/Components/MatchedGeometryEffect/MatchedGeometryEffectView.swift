import SwiftUI

struct MatchedGeometryEffectView: View {

    @ObservedObject var presenter: MatchedGeometryEffectPresenter
    @Namespace private var animationNamespace

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
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

                    Text("Matched Geometry Effect")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)

                Spacer()

                // Animation Section
                VStack(spacing: 30) {
                    Text("Tap to Animate")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 50)

                    ZStack {
                        RoundedRectangle(cornerRadius: presenter.isExpanded ? 0 : 50) // Dynamic corner radius
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .matchedGeometryEffect(id: "shape", in: animationNamespace)
                            .frame(
                                width: presenter.isExpanded ? 300 : 100,
                                height: presenter.isExpanded ? 200 : 100
                            )
                            .shadow(color: Color.blue.opacity(0.4), radius: 10, x: 0, y: 5)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 1.0)) { // Smooth transition
                                    presenter.toggleView()
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .background(Color(UIColor.systemBackground)) // Dynamic background for light and dark mode
        .edgesIgnoringSafeArea(.bottom)
    }
}
