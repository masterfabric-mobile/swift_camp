import SwiftUI

struct FrameView: View {

    @ObservedObject var presenter: FramePresenter

    var body: some View {
        VStack(spacing: 20) {
            // Go back button
            Button(action: presenter.goBack) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            // Rectangle with frame modifier
            Rectangle()
                .fill(Color.blue)
                .frame(width: presenter.width, height: presenter.height)
                .cornerRadius(10)
                .shadow(radius: 5)

            // Sliders to adjust frame
            VStack(spacing: 20) {
                Text("Adjust Width")
                Slider(value: $presenter.width, in: 50...300, step: 1)
                    .padding()

                Text("Adjust Height")
                Slider(value: $presenter.height, in: 50...300, step: 1)
                    .padding()
            }

            Spacer()
        }
        .padding()
    }
}
