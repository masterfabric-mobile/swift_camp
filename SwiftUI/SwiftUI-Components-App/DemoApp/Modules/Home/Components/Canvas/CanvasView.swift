import SwiftUI

struct CanvasView: View {

    @ObservedObject var presenter: CanvasPresenter

    // Enum for different shapes
    enum ShapeType: String, CaseIterable, Identifiable {
        case circle = "Circle"
        case rectangle = "Rectangle"
        case ellipse = "Ellipse"
        case capsule = "Capsule"

        var id: String { rawValue }
    }

    @State private var selectedShape: ShapeType = .circle

    var body: some View {
        VStack {
            // Header Section
            VStack(spacing: 10) {
                // Go back button
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
                .padding(.horizontal)

                Text("Canvas Playground")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                Text("Experiment with shapes and colors dynamically.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()

            Spacer()

            // Canvas Section
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 300)
                    .overlay(
                        Canvas { context, size in
                            let shapePath: Path
                            switch selectedShape {
                            case .circle:
                                shapePath = Path(ellipseIn: CGRect(x: size.width / 3, y: size.height / 4, width: size.width / 3, height: size.width / 3))
                            case .rectangle:
                                shapePath = Path(CGRect(x: size.width / 4, y: size.height / 4, width: size.width / 2, height: size.height / 2))
                            case .ellipse:
                                shapePath = Path(ellipseIn: CGRect(x: size.width / 4, y: size.height / 4, width: size.width / 2, height: size.height / 3))
                            case .capsule:
                                shapePath = Path(CGRect(x: size.width / 4, y: size.height / 3, width: size.width / 2, height: size.height / 4))
                            }

                            // Draw the selected shape
                            context.fill(shapePath, with: .color(presenter.color))

                            // Add a title
                            context.draw(Text(selectedShape.rawValue)
                                            .font(.headline)
                                            .foregroundColor(.black),
                                         at: CGPoint(x: size.width / 2, y: size.height / 8))
                        }
                    )
                    .shadow(radius: 5)

                Text("Interactive Drawing Area")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 320)
            }

            Spacer()

            // Shape Picker Section
            VStack(spacing: 20) {
                Text("Choose a Shape")
                    .font(.headline)
                    .foregroundColor(.blue)

                Picker("Select Shape", selection: $selectedShape) {
                    ForEach(ShapeType.allCases) { shape in
                        Text(shape.rawValue).tag(shape)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Color Picker Section
                Text("Customize Shape Color")
                    .font(.headline)
                    .foregroundColor(.blue)

                ColorPicker("Select a Color", selection: $presenter.color)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
    }
}
