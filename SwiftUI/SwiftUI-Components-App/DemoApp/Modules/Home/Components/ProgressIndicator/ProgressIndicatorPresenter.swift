import UIKit
import Foundation
import Combine

final class ProgressIndicatorPresenter: ObservableObject {
    
    private let wireframe: ProgressIndicatorWireframeInterface
    
    init(wireframe: ProgressIndicatorWireframeInterface) {
        self.wireframe = wireframe
    }
    
    func goBack() {
        wireframe.goBack()
    }
}

