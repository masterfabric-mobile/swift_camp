final class FocusStateWireframe: BaseWireframe<LazyHostingViewController<FocusStateView>> {
    
    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<FocusStateView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = FocusStatePresenter(wireframe: self)
        moduleViewController.rootView = FocusStateView(presenter: presenter)
        }
}

// MARK: - Extensions -

extension FocusStateWireframe: FocusStateWireframeInterface{
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}