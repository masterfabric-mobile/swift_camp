import UIKit

final class NavigationStackWireframe:BaseWireframe<LazyHostingViewController<NavigationStackView>> {
    
    // MARK: - Module setup -
    
    init() {
        let moduleViewController = LazyHostingViewController<NavigationStackView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = NavigationStackPresenter(wireframe: self)
        
        moduleViewController.rootView =  NavigationStackView(presenter: presenter)
    }
}

// MARK: - Extensions -

extension NavigationStackWireframe:NavigationStackWireframeInterface{
   
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
