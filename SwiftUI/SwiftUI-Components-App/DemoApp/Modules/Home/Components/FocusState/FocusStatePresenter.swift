import Foundation
import SwiftUI

final class FocusStatePresenter: ObservableObject {
    
    // MARK: - Properties
    
    private let wireframe: FocusStateWireframeInterface

    // MARK: - Lifecycle

    init(wireframe: FocusStateWireframeInterface) {
        self.wireframe = wireframe
    }

    // MARK: - Navigation

    func goBack() {
        wireframe.goBack()
    }
}