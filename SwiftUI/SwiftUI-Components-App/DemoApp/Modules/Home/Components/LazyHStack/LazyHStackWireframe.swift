

final class LazyHStackWireframe: BaseWireframe<LazyHostingViewController<LazyHStackView>>, LazyHStackWireframeInterface {
    
    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<LazyHStackView>(isNavigationBarHidden: true)

        super.init(viewController: moduleViewController)

        let presenter = LazyHStackPresenter(wireframe: self)

        moduleViewController.rootView = LazyHStackView(presenter: presenter)
    }
}

extension LazyHStackWireframe {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

