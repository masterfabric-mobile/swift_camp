import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    Text("Welcome to SwiftUI Components App")
                        .bold()
                        .padding(.bottom, 10)
                    
                    Text("Go to Detail View")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Button("Go to VStackView") {
                        presenter.showVStack()
                    }
                    
                    // New Button to navigate to ContentView
                    Button("Go to ContentView") {
                        presenter.showContentView()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}
