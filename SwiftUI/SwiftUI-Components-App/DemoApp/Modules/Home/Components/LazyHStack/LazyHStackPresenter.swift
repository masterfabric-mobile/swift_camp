import Foundation
import Combine


final class LazyHStackPresenter: ObservableObject {
    
    private let wireframe: LazyHStackWireframeInterface
    
    init(wireframe: LazyHStackWireframeInterface) {
        self.wireframe = wireframe
    }
    
    func goBack() {
        wireframe.goBack()
    }
}

