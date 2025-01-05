import Foundation

final class ObservedObjectWireframe: BaseWireframe<LazyHostingViewController<ObservedObjectView>>, ObservedObjectWireframeInterface {
    
    init() {
        let moduleViewController = LazyHostingViewController<ObservedObjectView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)
        
        let interactor = ObservedObjectInteractor()
        let presenter = ObservedObjectPresenter(wireframe: self, interactor: interactor)
        moduleViewController.rootView = ObservedObjectView(presenter: presenter)
    }
}

extension ObservedObjectWireframe {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
