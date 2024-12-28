import Foundation
import Combine

final class VStackPresenter: ObservableObject {
    
    private let wireframe: VStackWireframeInterface
    
    init(wireframe: VStackWireframeInterface) {
        self.wireframe = wireframe
    }
    
    func goBack() {
        wireframe.goBack()
    }
}

