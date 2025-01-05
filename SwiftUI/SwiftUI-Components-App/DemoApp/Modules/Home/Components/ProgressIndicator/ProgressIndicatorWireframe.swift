final class ProgressIndicatorWireframe: BaseWireframe<LazyHostingViewController<ProgressIndicatorView>>, ProgressIndicatorWireframeInterface {

    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<ProgressIndicatorView>(isNavigationBarHidden: true)

        super.init(viewController: moduleViewController)

        let presenter = ProgressIndicatorPresenter(wireframe: self)

        moduleViewController.rootView = ProgressIndicatorView(presenter: presenter)
    }
}

extension ProgressIndicatorWireframe {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

