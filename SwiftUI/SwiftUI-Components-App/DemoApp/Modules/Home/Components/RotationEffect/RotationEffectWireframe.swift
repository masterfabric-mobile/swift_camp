import UIKit

final class RotationEffectWireframe:BaseWireframe<LazyHostingViewController<RotationEffectView>> {
    
    // MARK: - Module setup -
    
    init() {
        let moduleViewController = LazyHostingViewController<RotationEffectView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = RotationEffectPresenter(wireframe: self)
        
        moduleViewController.rootView =  RotationEffectView(presenter: presenter)
    }
}

// MARK: - Extensions -

extension RotationEffectWireframe:RotationEffectWireframeInterface{
   
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

