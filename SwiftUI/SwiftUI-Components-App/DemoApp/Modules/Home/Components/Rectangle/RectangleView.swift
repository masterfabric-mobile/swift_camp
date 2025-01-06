import SwiftUI

struct RectangleView: View {

    @ObservedObject var presenter: RectanglePresenter

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

                    Text("Rectangle Playground")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                Spacer()

                // Rectangle Display Section with Boundary
                VStack(spacing: 20) {
                    ZStack {
                        // Fixed rectangular boundary with corner radius
                        RoundedRectangle(cornerRadius: 10) // Added corner radius
                            .strokeBorder(Color.gray, lineWidth: 2) // Border for the boundary
                            .frame(width: 300, height: 150) // Fixed rectangle frame
                            .overlay(
                                Text("Boundary")
                                    .font(.caption)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )

                        // Resizable rectangle centered in the boundary
                        Rectangle()
                            .fill(presenter.color)
                            .frame(
                                width: min(presenter.size, 300), // Ensure width fits within boundary
                                height: min(presenter.size / 2, 150) // Ensure height fits within boundary
                            )
                            .cornerRadius(10)
                            .shadow(color: presenter.color.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                    .frame(width: 300, height: 150) // Centered fixed rectangle boundary
                }
                .frame(maxWidth: .infinity) // Center the boundary frame horizontally
                .padding()

                // Single Slider Section
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Adjust Size")
                            .font(.subheadline)
                            .foregroundColor(.primary)

                        Slider(
                            value: $presenter.size,
                            in: 50...300,
                            step: 1
                        )
                        .accentColor(.blue)
                    }

                    VStack(alignment: .leading) {
                        Text("Select Color")
                            .font(.subheadline)
                            .foregroundColor(.primary)

                        ColorPicker("", selection: $presenter.color)
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
