import SwiftUI

struct ProgressIndicatorView: View {
    @ObservedObject var presenter: ProgressIndicatorPresenter
    @State private var progressValue: Float = 0.0

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()

                // Circular Progress Indicator with a drawn circle
                VStack {
                    Text("Circular Progress")
                        .font(.headline)

                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                            .frame(width: 100, height: 100)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(progressValue))
                            .stroke(Color.blue, lineWidth: 10)
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 0.1), value: progressValue)
                    }
                }

                // Linear Progress Indicator
                VStack {
                    Text("Linear Progress")
                        .font(.headline)

                    ProgressView(value: progressValue)
                        .progressViewStyle(LinearProgressViewStyle())
                        .padding(.horizontal, 50)
                }

                Spacer()
            }

            // Back Button in the top-left corner
            VStack {
                HStack {
                    Button(action: presenter.goBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 50) // Adjusted padding for better positioning
            .padding(.leading, 10)
        }
        .padding()
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if progressValue < 1.0 {
                    progressValue += 0.01
                    progressValue = min(max(progressValue, 0.0), 1.0) // Ensure it's clamped
                } else {
                    timer.invalidate()
                    progressValue = 1.0 // Explicitly ensure it stops at 1.0
                }
            }
        }
    }
}

