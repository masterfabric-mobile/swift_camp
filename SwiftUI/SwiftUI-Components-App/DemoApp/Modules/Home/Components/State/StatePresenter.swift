import Foundation
import SwiftUI

final class StatePresenter: ObservableObject {

    // MARK: - Private properties
    private let wireframe: StateWireframeInterface

    // MARK: - Lifecycle
    init(wireframe: StateWireframeInterface) {
        self.wireframe = wireframe
    }

    // MARK: - Navigation
    func goBack() {
        wireframe.goBack()
    }
}
