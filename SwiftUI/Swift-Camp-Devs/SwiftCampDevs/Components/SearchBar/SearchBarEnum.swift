import Foundation


// Search matching behaviors
public enum SearchType {
    
    // Search matches if the data contains the search text
    case contains
    
    // Search matches if the data begins with the search text
    case beginsWith
    
    // Search matches if the data ends with the search text
    case endsWith
    
}
