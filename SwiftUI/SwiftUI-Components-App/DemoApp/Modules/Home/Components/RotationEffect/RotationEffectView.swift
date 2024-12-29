import SwiftUI

struct RotationEffectView: View {
    @ObservedObject var presenter: RotationEffectPresenter
    @State private var rotationAngle: Double = 0.0
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Back button with consistent style
            Button(action: presenter.goBack) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            // Rotatable Text
            Text("Hello SwiftUI!")
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .rotationEffect(.degrees(rotationAngle))
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: rotationAngle)
            
            // Control Buttons
            VStack(spacing: 15) {
                Button("Rotate 90°") {
                    rotationAngle += 90
                }
                .buttonStyle(.bordered)
                
                Button("Rotate -90°") {
                    rotationAngle -= 90
                }
                .buttonStyle(.bordered)
                
                Button("Continuous Rotation") {
                    isAnimating.toggle()
                    if isAnimating {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                            rotationAngle += 360
                        }
                    } else {
                        withAnimation(.none) {
                            rotationAngle = 0
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reset") {
                    isAnimating = false
                    withAnimation {
                        rotationAngle = 0
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
            
            // Current Rotation Display
            Text("Current Rotation: \(Int(rotationAngle.truncatingRemainder(dividingBy: 360)))°")
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
    }
}
