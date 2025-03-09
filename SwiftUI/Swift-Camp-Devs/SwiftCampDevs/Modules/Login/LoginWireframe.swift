import UIKit

final class LoginWireframe: BaseWireframe<LazyHostingViewController<LoginView>> {

    // MARK: - Module setup -
    init() {
        let moduleViewController = LazyHostingViewController<LoginView>(isNavigationBarHidden: true)

        super.init(viewController: moduleViewController)

        let presenter = LoginPresenter(wireframe: self)
        moduleViewController.rootView = LoginView(presenter: presenter)
    }
}

// MARK: - Extensions -

extension LoginWireframe: LoginWireframeInterface {

    func goBack() {
        navigationController?.popViewController(animated: true)
    }

    func navigateToHome() {
        
        let homeWireframe = HomeWireframe()
        navigationController?.pushWireframe(homeWireframe)
    }
}
