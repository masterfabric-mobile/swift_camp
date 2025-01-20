import SwiftUI

struct SCBottomSheet: View {
    let content: BottomSheet
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            if isVisible {
                VStack {
                    contentBody
                        .padding()
                        .frame(height: UIScreen.main.bounds.height * content.heightPercentage)
                        .background(Color.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .shadow(radius: 10)
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isVisible)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Group {
                if isVisible {
                    ZStack {
                        Color.black.opacity(0.5)
                            .onTapGesture {
                                withAnimation { isVisible = false }
                            }
                    }
                } else {
                    Color.clear
                }
            }
        )
    }
    
    @ViewBuilder
    private var contentBody: some View {
        switch content {
        case .text(let message, _):
            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
        case .image(let image, _):
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
        case .customView(let customView, _):
            customView
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
