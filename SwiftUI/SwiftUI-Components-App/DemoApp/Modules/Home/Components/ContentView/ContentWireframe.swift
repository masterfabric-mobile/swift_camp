import UIKit

final class ContentWireframe: BaseWireframe<LazyHostingViewController<ContentView>> {

    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<ContentView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = ContentPresenter(wireframe: self)
        moduleViewController.rootView = ContentView(presenter: presenter)
    }
}

// MARK: - Extensions -

extension ContentWireframe: ContentWireframeInterface {

    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
