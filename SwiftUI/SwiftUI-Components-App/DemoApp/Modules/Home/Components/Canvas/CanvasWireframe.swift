import UIKit

final class CanvasWireframe: BaseWireframe<LazyHostingViewController<CanvasView>> {

    // MARK: - Module setup

    init() {
        let moduleViewController = LazyHostingViewController<CanvasView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = CanvasPresenter(wireframe: self)
        moduleViewController.rootView = CanvasView(presenter: presenter)
    }
}

// MARK: - Extensions

extension CanvasWireframe: CanvasWireframeInterface {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
