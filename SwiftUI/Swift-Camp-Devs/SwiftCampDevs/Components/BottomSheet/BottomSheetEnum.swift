import SwiftUI

enum BottomSheet {
    case text(String, heightPercentage: CGFloat)
    case image(Image, heightPercentage: CGFloat)
    case customView(AnyView, heightPercentage: CGFloat)
    
    var heightPercentage: CGFloat {
        switch self {
        case .text(_, let heightPercentage),
                .image(_, let heightPercentage),
                .customView(_, let heightPercentage):
            return heightPercentage
        }
    }
}
