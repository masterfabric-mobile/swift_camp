import UIKit
import SwiftUI

final class EnvironmentObjectWireframe: BaseWireframe<LazyHostingViewController<AnyView>> {

    // MARK: - Module setup

    init(sharedData: EnvironmentObjectEntity) {
        let moduleViewController = LazyHostingViewController<AnyView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = EnvironmentObjectPresenter(wireframe: self, sharedData: sharedData)

        moduleViewController.rootView = AnyView(
            EnvironmentObjectView(presenter: presenter)
                .environmentObject(sharedData)
        )
    }
}

// MARK: - Extensions

extension EnvironmentObjectWireframe: EnvironmentObjectWireframeInterface {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
