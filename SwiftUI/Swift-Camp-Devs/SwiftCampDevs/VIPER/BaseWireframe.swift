import UIKit

protocol WireframeInterface: Progressable {
    func showSnackbar(type: SnackbarHelper.SnackbarType, title: String, description: String?)
    func showToast(title: String, type: ToastType)
    
}

class BaseWireframe<ViewController> where ViewController: UIViewController {
    
    private unowned var _viewController: ViewController
    
    // We need it in order to retain view controller reference upon first access
    private var temporaryStoredViewController: ViewController?
    
    
    init(viewController: ViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
        
        // Configure theme if view controller is LazyHostingViewController
        if let hostingVC = viewController as? (any UIViewController & HostingNavigationConfigurable) {
            switch ThemeHelper.shared.themeType {
            case .dark:
                hostingVC.overrideUserInterfaceStyle = .dark
            case .light:
                hostingVC.overrideUserInterfaceStyle = .light
            case .custom:
                hostingVC.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
    
}

extension BaseWireframe {
    
    var viewController: ViewController {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    // This method is needed to fix frame issues on the root view after
    // a modal is being presented on top of it. The issue occurs only on iOS 16
    // and can be fixed by modal view not being fully expanded.
    @available(iOS 16.0, *)
    func setupModalDetent(on navigationController: UINavigationController) {
        let modalDetentId = UISheetPresentationController.Detent.Identifier(UUID().uuidString)
        let modalDetent = UISheetPresentationController.Detent.custom(identifier: modalDetentId) { context in
            context.maximumDetentValue * 0.99
        }
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [modalDetent]
        }
    }
    
}

extension UIViewController {
    
    func presentWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

extension UINavigationController {
    
    func pushWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }
    
}

extension BaseWireframe: WireframeInterface {
    func showToast(title: String, type: ToastType) {
        guard let topViewController = navigationController?.topViewController else {
            return
        }
        
        ToastHelper.shared.showToast(
            in: topViewController.view,
            title: title,
            type: type,
            duration: 3.0
        )
    }
    
    func showSnackbar(type: SnackbarHelper.SnackbarType, title: String, description: String?) {
        guard let topViewController = navigationController?.topViewController else {
            return
        }
        
        SnackbarHelper.shared.showSnackbar(
            in: topViewController,
            type: type,
            title: title,
            description: description
        )
    }
    
    func showLoading(status: String? = nil) {
    }
    
    func hideLoading() {
    }
    
    func show(error: Error) {
    }
    
}
