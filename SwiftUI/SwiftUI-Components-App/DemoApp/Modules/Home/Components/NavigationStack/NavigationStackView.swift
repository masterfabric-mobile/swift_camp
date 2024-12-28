import SwiftUI

struct NavigationStackView: View {
    @ObservedObject var presenter: NavigationStackPresenter
    @State private var searchText = ""
    
    // Add filtered categories computed property
    private var filteredCategories: [FoodCategory] {
        let categories = getFoodCategories()
        if searchText.isEmpty {
            return categories
        }
        return categories.filter { category in
            category.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom navigation bar (unchanged)
            HStack {
                Button(action: presenter.goBack) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.blue)
                        .clipShape(Circle())
                }

                Text("Food Categories")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

            // Search bar (unchanged)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search categories...", text: $searchText)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding()

            // Food categories list - Modified to use filteredCategories
            NavigationView {
                List {
                    ForEach(filteredCategories, id: \.name) { category in
                        NavigationLink(
                            destination: FoodListView(category: category)
                        ) {
                            HStack {
                                Image(systemName: category.icon)
                                    .foregroundColor(category.color)
                                    .font(.title2)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(category.name)
                                        .font(.headline)
                                    Text("\(category.itemCount) items")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarHidden(true)
            }
        }
    }

    // Sample data
    private func getFoodCategories() -> [FoodCategory] {
        return [
            FoodCategory(name: "Pizza", icon: "flame.fill", color: .red, itemCount: 12),
            FoodCategory(name: "Burgers", icon: "star.fill", color: .orange, itemCount: 8),
            FoodCategory(name: "Sushi", icon: "leaf.fill", color: .green, itemCount: 15),
            FoodCategory(name: "Desserts", icon: "heart.fill", color: .pink, itemCount: 10),
        ]
    }
}

struct FoodCategory {
    let name: String
    let icon: String
    let color: Color
    let itemCount: Int
}

struct FoodListView: View {
    let category: FoodCategory
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            // Custom navigation bar
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.blue)
                        .clipShape(Circle())
                }

                Text(category.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading, 8)

                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

            // Food items list
            List {
                ForEach(getFoodItems(), id: \.name) { item in
                    HStack {
                        Image(systemName: item.isSpecial ? "star.circle.fill" : "circle.fill")
                            .foregroundColor(category.color)
                            .font(.title3)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name)
                                .font(.headline)
                            Text("$\(String(format: "%.2f", item.price))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        if item.isSpecial {
                            Text("Special")
                                .font(.caption)
                                .padding(6)
                                .background(category.color.opacity(0.2))
                                .foregroundColor(category.color)
                                .cornerRadius(6)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarHidden(true)
    }

    // Sample data based on category
    private func getFoodItems() -> [FoodItem] {
        switch category.name {
        case "Pizza":
            return [
                FoodItem(name: "Margherita", price: 12.99, isSpecial: true),
                FoodItem(name: "Pepperoni", price: 14.99, isSpecial: false),
                FoodItem(name: "BBQ Chicken", price: 15.99, isSpecial: true),
                FoodItem(name: "Vegetarian", price: 13.99, isSpecial: false),
            ]
        case "Burgers":
            return [
                FoodItem(name: "Classic Burger", price: 9.99, isSpecial: true),
                FoodItem(name: "Cheese Burger", price: 11.99, isSpecial: false),
                FoodItem(name: "Bacon Burger", price: 13.99, isSpecial: true),
            ]
        case "Sushi":
            return [
                FoodItem(name: "California Roll", price: 8.99, isSpecial: false),
                FoodItem(name: "Salmon Roll", price: 10.99, isSpecial: true),
                FoodItem(name: "Dragon Roll", price: 15.99, isSpecial: true),
            ]
        default:
            return [
                FoodItem(name: "Ice Cream", price: 5.99, isSpecial: false),
                FoodItem(name: "Chocolate Cake", price: 6.99, isSpecial: true),
                FoodItem(name: "Tiramisu", price: 7.99, isSpecial: false),
            ]
        }
    }
}

struct FoodItem {
    let name: String
    let price: Double
    let isSpecial: Bool
}
