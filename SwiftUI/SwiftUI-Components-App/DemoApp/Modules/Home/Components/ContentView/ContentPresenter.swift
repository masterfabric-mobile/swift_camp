import Foundation
import Combine

final class ContentPresenter: ObservableObject {

    // MARK: - Private properties -

    private let wireframe: ContentWireframeInterface

    // MARK: - Lifecycle -

    init(wireframe: ContentWireframeInterface) {
        self.wireframe = wireframe
    }

    // MARK: - Navigation methods -

    /// Navigates back in the navigation stack
    func goBack() {
        wireframe.goBack()
    }
}
