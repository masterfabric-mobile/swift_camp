import SwiftUI

struct ContentView: View {

    @ObservedObject var presenter: ContentPresenter

    var body: some View {
        VStack(spacing: 30) {
            // Simple go-back button
            Button(action: presenter.goBack) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Main content
            Spacer()

            VStack(spacing: 20) {
                Image(systemName: "app.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)

                Text("About This App")
                    .font(.title)
                    .fontWeight(.bold)

                Text("""
                     This app demonstrates the use of VIPER architecture in a SwiftUI project. 
                     Each component is designed to showcase SwiftUI's powerful features combined with a well-structured architecture.
                     
                     You can explore different components and view examples.
                     """)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
            }

            Spacer()
        }
        .padding()
    }
}
