import SwiftUI

struct SCCountryPicker: View {
    @Binding var selectedCountry: Country?
    @State private var searchText = ""
    @State private var countries: [Country] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    @Environment(\.dismiss) private var dismiss
    
    let type: CountryPickerType
    let customContent: ((Country) -> AnyView)?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Country", text: $searchText)
                    .padding()
                    .background(AppColors.softGray)
                    .cornerRadius(UISizerHelper.Radius.low)
                    .padding(.horizontal)
                
                if isLoading {
                    ProgressView("Loading countries...")
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(AppColors.warningColor)
                } else {
                    List(filteredCountries) { country in
                        Button(action: {
                            selectedCountry = country
                            dismiss()
                        }) {
                            content(for: country)
                        }
                    }
                }
            }
            .navigationTitle("Select Country")
            .onAppear {
                loadCountries()
            }
        }
    }
    
    @ViewBuilder
    private func content(for country: Country) -> some View {
        switch type {
        case .flagOnly:
            Text(country.flag)
                .font(.largeTitle)
        case .flagWithCountryName:
            HStack {
                Text(country.flag)
                    .font(.largeTitle)
                Text(country.name)
                    .font(.headline)
            }
        case .flagWithDialCode:
            HStack {
                Text(country.flag)
                    .font(.largeTitle)
                Text(country.dialCode)
                    .font(.headline)
            }
        case .flagWithCountryNameAndDialCode:
            HStack {
                Text(country.flag)
                    .font(.largeTitle)
                Text(country.name)
                    .font(.headline)
                Text(country.dialCode)
                    .font(.subheadline)
                    .foregroundColor(AppColors.darkGray)
            }
        case .custom:
            if let customContent = customContent {
                customContent(country)
            }
        }
    }
    
    private var filteredCountries: [Country] {
        let sortedCountries = countries.sorted { $0.name < $1.name }
        if searchText.isEmpty {
            return sortedCountries
        } else {
            return sortedCountries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    private func loadCountries() {
        let service = CountryService()
        service.fetchCountries { fetchedCountries, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                } else if let fetchedCountries = fetchedCountries {
                    countries = fetchedCountries
                }
                isLoading = false
            }
        }
    }
}

struct CountryPicker_Previews: PreviewProvider {
    static var previews: some View {
        SCCountryPicker(
            selectedCountry: .constant(Country(
                id: UUID(),
                name: "Turkey",
                dialCode: "+90",
                flag: "🇹🇷",
                code: "TR"
            )),
            type: .flagWithCountryNameAndDialCode,
            customContent: nil
        )
    }
}
