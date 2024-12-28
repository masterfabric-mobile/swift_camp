import SwiftUI

struct LazyHStackView: View {
    @ObservedObject var presenter: LazyHStackPresenter

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(0..<50, id: \.self) { index in // 50 items example
                            Text("# \(index)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 80, height: 40)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
            }
            .padding()

            // Back Button
            Button(action: presenter.goBack) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

