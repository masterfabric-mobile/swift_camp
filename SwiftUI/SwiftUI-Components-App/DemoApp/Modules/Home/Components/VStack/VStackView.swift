import SwiftUI


struct VStackView: View {
    @ObservedObject var presenter: VStackPresenter
    var body: some View {
        Button(action: presenter.goBack) {
            Image(systemName: "chevron.left")
        }
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            ForEach(
                1...10,
                id: \.self
            ) {
                Text("Item \($0)")
            }
        }
        
    }
}




