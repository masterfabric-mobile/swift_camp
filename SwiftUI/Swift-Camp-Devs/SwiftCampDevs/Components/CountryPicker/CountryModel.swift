import Foundation

struct Country: Identifiable, Equatable {
    let id: UUID
    let name: String
    let dialCode: String
    let flag: String
    let code: String // ISO Alpha-2 country code

    init(id: UUID = UUID(), name: String, dialCode: String, flag: String, code: String) {
        self.id = id
        self.name = name
        self.dialCode = dialCode
        self.flag = flag
        self.code = code
    }

    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
}
