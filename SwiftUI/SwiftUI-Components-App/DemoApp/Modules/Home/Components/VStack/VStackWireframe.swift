

final class VStackWireframe: BaseWireframe<LazyHostingViewController<VStackView>>, VStackWireframeInterface {
    
    

    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<VStackView>(isNavigationBarHidden: true)

        super.init(viewController: moduleViewController)

        let presenter = VStackPresenter(wireframe: self)

        moduleViewController.rootView = VStackView(presenter: presenter)
    }
    
    

}

extension VStackWireframe {
    func goBack() {
        
        navigationController?.popViewController(animated: true)
    }
}

