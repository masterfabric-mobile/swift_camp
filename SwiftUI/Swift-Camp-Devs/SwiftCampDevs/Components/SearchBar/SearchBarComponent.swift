import Foundation


public class SearchBarComponent <T> {
    
    // Data source
    private var data: [T]
    
    private let searchKey: (T) -> String
    
    // Search matching behavior
    public var searchType: SearchType
    
    // Minimum number of characters required to perform filtering
    private var minimumSearchLength: Int?
    
    
    public init(data: [T], searchType: SearchType = .contains, searchKey: @escaping (T) -> String) {
        
        self.data = data
        
        self.searchType = searchType
        
        self.searchKey = searchKey
        
        self.minimumSearchLength = TextFieldType.search.minLength
        
    }
    
    // Updates data source with new data
    public func updateData(_ data: [T]) {
        
        self.data = data
    }
    
    public func filter (with searchText: String) -> [T] {
        
        // If size of the search text is less than minimum search length data, returns empty set
        // If there is an error retrieving the minimum search length data, default value is 2
        if searchText.count < minimumSearchLength ?? 2 {
            
            return []
        }
        
        let lowercasedSearchText = searchText.lowercased()
        
        return data.filter { item in
            
            let itemText = searchKey(item).lowercased()
            
            switch searchType {
            case .contains:
                return itemText.contains(lowercasedSearchText)
            case .beginsWith:
                return itemText.hasPrefix(lowercasedSearchText)
            case .endsWith:
                return itemText.hasSuffix(lowercasedSearchText)
            }
            
        }
    }
    
}
