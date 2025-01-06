import UIKit
import SwiftUI

final class StateWireframe: BaseWireframe<LazyHostingViewController<AnyView>> {

    // MARK: - Module setup
    init(sharedData: EnvironmentObjectEntity) {  // Take shared data as a parameter
        let moduleViewController = LazyHostingViewController<AnyView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = StatePresenter(wireframe: self)

        // Assign the EnvironmentObject properly
        moduleViewController.rootView = AnyView(
            StateView(presenter: presenter)
                .environmentObject(sharedData)  // Provide EnvironmentObject
        )
    }
}

// MARK: - Extensions
extension StateWireframe: StateWireframeInterface {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
