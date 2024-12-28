import SwiftUI

struct VStackView: View {
    @ObservedObject var presenter: VStackPresenter

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Geri butonu
            Button(action: presenter.goBack) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Back")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
            // Liste
            VStack(alignment: .leading, spacing: 15) {
                ForEach(1...5, id: \.self) { index in
                    Text("Item \(index)")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding()
    }
}

