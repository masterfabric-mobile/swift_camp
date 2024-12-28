import Foundation

final class NavigationStackPresenter: ObservableObject {
    
    // MARK: - Private properties -

    private let wireframe: NavigationStackWireframeInterface

    // MARK: - Lifecycle -

    init(wireframe: NavigationStackWireframeInterface) {
        self.wireframe = wireframe
    }

    // MARK: - Navigation methods -

    /// Navigates back in the navigation stack
    func goBack() {
        wireframe.goBack()
    }
    
    }
