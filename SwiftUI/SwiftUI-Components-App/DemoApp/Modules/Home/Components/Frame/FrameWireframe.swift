import UIKit

final class FrameWireframe: BaseWireframe<LazyHostingViewController<FrameView>> {

    // MARK: - Module setup

    init() {
        let moduleViewController = LazyHostingViewController<FrameView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = FramePresenter(wireframe: self)
        moduleViewController.rootView = FrameView(presenter: presenter)
    }
}

// MARK: - Extensions

extension FrameWireframe: FrameWireframeInterface {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
