import SwiftUI

struct FrameView: View {

    @ObservedObject var presenter: FramePresenter

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header Section (Unchanged)
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

                    Text("Frame Playground")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Spacer()

                // Centered Square Frame with Rectangle
                VStack(spacing: 20) {

                    ZStack {
                        // Fixed square boundary with corner radius
                        RoundedRectangle(cornerRadius: 20) // Added corner radius
                            .strokeBorder(Color.gray, lineWidth: 2)
                            .frame(width: 300, height: 300) // Fixed square frame
                            .overlay(
                                Text("Boundary")
                                    .font(.caption)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )

                        // Resizable rectangle centered in the frame
                        Rectangle()
                            .fill(presenter.color)
                            .frame(
                                width: min(presenter.size, 300), // Ensure size fits within boundary
                                height: min(presenter.size, 300)
                            )
                            .cornerRadius(15)
                            .shadow(color: presenter.color.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                    .frame(width: 300, height: 300) // Centered fixed square frame
                }
                .frame(maxWidth: .infinity) // Center the boundary frame horizontally
                .padding()

                // Controls Section
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Adjust Size")
                            .font(.subheadline)
                            .foregroundColor(.primary)

                        Slider(value: $presenter.size, in: 50...300, step: 1) // Single slider for size
                            .accentColor(.blue)
                    }

                    VStack(alignment: .leading) {
                        Text("Select Color")
                            .font(.subheadline)
                            .foregroundColor(.primary)

                        ColorPicker("", selection: $presenter.color) // Dynamic ColorPicker
                            .labelsHidden()
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
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
