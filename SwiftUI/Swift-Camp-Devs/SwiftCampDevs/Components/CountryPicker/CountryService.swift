import Foundation

struct APICountry: Codable {
    struct IDD: Codable {
        let root: String?
        let suffixes: [String]?
    }
    
    struct Name: Codable {
        let common: String
    }

    let cca2: String // ISO Alpha-2 country code
    let flag: String
    let idd: IDD
    let name: Name
}

class CountryService {
    func fetchCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "NoData", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }

            do {
                let apiCountries = try JSONDecoder().decode([APICountry].self, from: data)

                let countries = apiCountries.compactMap { apiCountry -> Country? in
                    guard let root = apiCountry.idd.root,
                          let suffix = apiCountry.idd.suffixes?.first else {
                        return nil // Eksik bilgi varsa atla
                    }

                    return Country(
                        id: UUID(),
                        name: apiCountry.name.common,
                        dialCode: root + suffix,
                        flag: apiCountry.flag,
                        code: apiCountry.cca2
                    )
                }

                completion(countries, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
