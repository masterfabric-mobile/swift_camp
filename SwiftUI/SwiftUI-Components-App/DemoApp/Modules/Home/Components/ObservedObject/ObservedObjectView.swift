import SwiftUI

struct ObservedObjectView: View {
    @ObservedObject var presenter: ObservedObjectPresenter
    private let backButtonIcon: String = "chevron.left"
    var body: some View {
        //back button to navigate home
        VStack(spacing: 30) {
            Button(action: presenter.goBack) {
                Image(systemName: backButtonIcon)
                    .font(.title2)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            VStack {
                // simple text component to show how many times button clicked
                Text("Button clicked \(presenter.counterValue) times")
                    .font(.title)
                    .padding()
                // when this button clicked the value increase by 1
                Button(action: {
                    presenter.isIncrementButtonClicked()
                })
                {
                    Text("Click here to increment")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            Spacer()
        }
    }
}


