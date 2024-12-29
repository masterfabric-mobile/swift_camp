import UIKit

final class HomeWireframe: BaseWireframe<LazyHostingViewController<HomeView>> {

    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<HomeView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)

        let presenter = HomePresenter(wireframe: self)
        moduleViewController.rootView = HomeView(presenter: presenter)
    }
}

// MARK: - Extensions -

extension HomeWireframe: HomeWireframeInterface {

    func showVStack() {
        let vStackWireframe = VStackWireframe()
        navigationController?.pushWireframe(vStackWireframe)
    }

    func showZStack() {
        let zStackWireframe = ZStackWireframe()
        navigationController?.pushWireframe(zStackWireframe)
    }

    func showContentView() {
        let contentWireframe = ContentWireframe()
        navigationController?.pushWireframe(contentWireframe)
    }

    func showColorPicker() {
        let colorPickerWireframe = ColorPickerWireframe()
        navigationController?.pushWireframe(colorPickerWireframe)
    }

    func showRectangle() {
        let rectangleWireframe = RectangleWireframe()
        navigationController?.pushWireframe(rectangleWireframe)
    }
    func showSection() {
        let sectionWireframe = SectionWireframe()
        navigationController?.pushWireframe(sectionWireframe)
    }

    func showHStack() {
        let hStackWireframe = HStackWireframe()
        navigationController?.pushWireframe(hStackWireframe)
    }
    func showNavigationStack() {
        let navigationStackWireframe = NavigationStackWireframe()
        navigationController?.pushWireframe(navigationStackWireframe)
    }

    func showFrame() {
        let frameWireframe = FrameWireframe()
        navigationController?.pushWireframe(frameWireframe)
    }

    func showScrollView() {
        let scrollViewWireframe = ScrollViewWireframe()
        navigationController?.pushWireframe(scrollViewWireframe)
    }

    func showNavigationView() {
        let navigationWireframe = NavigationWireframe()
        navigationController?.pushWireframe(navigationWireframe)
    }

    func showTransaction() {
        let transactionWireframe = TransactionWireframe()
        navigationController?.pushWireframe(transactionWireframe)
    }

    func showLazyHGrid() {
        let lazyHGridWireframe = LazyHGridWireframe()
        navigationController?.pushWireframe(lazyHGridWireframe)
    }

    func showLazyVStackView() {
        let lazyVStackViewWireframe = LazyVStackWireframe()
        navigationController?.pushWireframe(lazyVStackViewWireframe)
    }

    func showMatchedGeometryEffect() {
        let matchedGeometryEffectWireframe = MatchedGeometryEffectWireframe()
        navigationController?.pushWireframe(matchedGeometryEffectWireframe)
    }
    func showImage() {
        let imageWireframe = ImageWireframe()
        navigationController?.pushWireframe(imageWireframe)
    }

    func showMenuButton() {
        let menuButtonWireframe = MenuButtonWireframe()
        navigationController?.pushWireframe(menuButtonWireframe)
    }
    func showCircle() {
        let circleWireframe = CircleWireframe()
        navigationController?.pushWireframe(circleWireframe)
    }
    func showOpacity() {
        let opacityWireframe = OpacityWireframe()
        navigationController?.pushWireframe(opacityWireframe)
    }

    func showSecureField() {
        let secureFieldWireframe = SecureFieldWireframe()
        navigationController?.pushWireframe(secureFieldWireframe)
    }

    func showContextMenu() {
        let contextMenuWireframe = ContextMenuWireframe()
        navigationController?.pushWireframe(contextMenuWireframe)
        let contextMenuWireframe = ContextMenuWireframe()
        navigationController?.pushWireframe(contextMenuWireframe)
    }

    func showBinding() {
        let bindingWireframe = BindingWireframe()
        navigationController?.pushWireframe(bindingWireframe)
    }

    func showStepper() {
        let stepperWireframe = StepperWireframe()
        navigationController?.pushWireframe(stepperWireframe)
    }

    func showLazyVGridView() {
        let lazyVGridViewWireframe = LazyVGridWireframe()
        navigationController?.pushWireframe(lazyVGridViewWireframe)

    }

    func showEllipse() {
        let ellipseWireframe = EllipseWireframe()
        navigationController?.pushWireframe(ellipseWireframe)
    }

    func showPadding() {
        let paddingWireframe = PaddingWireframe()
        navigationController?.pushWireframe(paddingWireframe)
    }

    func showPicker() {
        let pickerWireframe = PickerWireframe()
        navigationController?.pushWireframe(pickerWireframe)
    }
}
