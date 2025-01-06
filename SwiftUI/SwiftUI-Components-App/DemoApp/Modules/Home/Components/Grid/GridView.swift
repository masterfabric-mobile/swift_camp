import SwiftUI

struct GridView: View {

    @ObservedObject var presenter: GridPresenter

    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 15)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Section
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

                    Text("Dynamic Grid View")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)

                // Grid Section
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(presenter.items, id: \.self) { item in
                        VStack {
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                                .frame(width: 60, height: 60)

                            Text(item)
                                .font(.caption)
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .background(Color(UIColor.systemBackground)) // Dynamic background for light/dark mode
        .edgesIgnoringSafeArea(.bottom)
    }
}
