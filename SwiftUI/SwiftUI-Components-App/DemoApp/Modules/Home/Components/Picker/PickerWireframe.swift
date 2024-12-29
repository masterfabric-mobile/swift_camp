import UIKit

final class PickerWireframe:BaseWireframe<LazyHostingViewController<PickerView>> {
    
    // MARK: - Module setup -
    
    init() {
        let moduleViewController = LazyHostingViewController<PickerView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = PickerPresenter(wireframe: self)
        
        moduleViewController.rootView =  PickerView(presenter: presenter)
    }
}

// MARK: - Extensions -

extension PickerWireframe:PickerWireframeInterface{
   
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

