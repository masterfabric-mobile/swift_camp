import SwiftUI


struct SCPopupComponent: View {
    let title: String
    let message: String
    let actions: [PopupAction]

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)
                    .padding()

                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)

                HStack {
                    ForEach(actions, id: \.id) { action in
                        AppButton(
                            type: .normal,
                            size: .medium,
                            text: action.title,
                            action: action.handler
                        )
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(40)
        }
    }
}
