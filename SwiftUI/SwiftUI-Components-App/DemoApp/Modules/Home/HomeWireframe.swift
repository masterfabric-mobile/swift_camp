import UIKit

final class HomeWireframe: BaseWireframe<LazyHostingViewController<HomeView>> {

    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<HomeView>(isNavigationBarHidden: true)
        super.init(viewController: moduleViewController)
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor, wireframe: self)
        moduleViewController.rootView = HomeView(presenter: presenter)
    }
}

// MARK: - Extensions -

extension HomeWireframe: HomeWireframeInterface {
    
    
    func showGrid() {
        let gridWireframe = GridWireframe()
        navigationController?.pushWireframe(gridWireframe)
    }
    
    
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
    
    func showText() {
        let textWireframe = TextWireframe()
        navigationController?.pushWireframe(textWireframe)
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
    
    func showTabView()
    {
        let tabViewWireframe = TabWireframe()
        navigationController?.pushWireframe(tabViewWireframe)
    }
    
    func showAttributedText() {
        let attributedTextWireframe = AttributedTextWireframe()
        navigationController?.pushWireframe(attributedTextWireframe)
    }
    
    func showButton() {
        let buttonWireframe = ButtonWireframe()
        navigationController?.pushWireframe(buttonWireframe)
    }
    
    func showDatePicker() {
        let datePickerWireframe = DatePickerWireframe()
        navigationController?.pushWireframe(datePickerWireframe)
    }
    
    func showSegmentedControl() {
        let segmentedControlWireframe = SegmentedControlWireframe()
        navigationController?.pushWireframe(segmentedControlWireframe)
    }
    
    func showRoundedRectangle() {
        let roundedRectangleWireframe = RoundedRectangleWireframe()
        navigationController?.pushWireframe(roundedRectangleWireframe)
    }
    
    func showShadow() {
        let shadowWireframe = ShadowWireframe()
        navigationController?.pushWireframe(shadowWireframe)
    }
    
    func showScaleEffect() {
        let scaleEffectWireframe = ScaleEffectWireframe()
        navigationController?.pushWireframe(scaleEffectWireframe)
    }
    
    func showAnimation() {
        let animationWireframe = AnimationWireframe()
        navigationController?.pushWireframe(animationWireframe)
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
    
    func showCanvas() {
        let canvasWireframe = CanvasWireframe()
        navigationController?.pushWireframe(canvasWireframe)
    }
    
    func showLazyHStack() {
        let lazyHStackWireframe = LazyHStackWireframe()
        navigationController?.pushWireframe(lazyHStackWireframe)
    }
    
    
    func showAlert() {
        let alertWireframe = AlertWireframe()
        navigationController?.pushWireframe(alertWireframe)
    }
    
    
    
    func showRotationEffect() {
        let rotationEffectWireframe = RotationEffectWireframe()
        navigationController?.pushWireframe(rotationEffectWireframe)
    }
    
    func showWithAnimation() {
        let withAnimationWireframe = WithAnimationWireframe()
        navigationController?.pushWireframe(withAnimationWireframe)
    }
    
    func showTextField() {
        let textFieldWireframe = TextFieldWireframe()
        navigationController?.pushWireframe(textFieldWireframe)
    }
    
    
    func showLongPressGesture() {
        let longPressGestureWireframe = LongPressGestureWireframe()
        navigationController?.pushWireframe(longPressGestureWireframe)
    }
    
    
    func showProgressView() {
        let progressWireframe = ProgressWireframe()
        navigationController?.pushWireframe(progressWireframe)
    }
    
    
    func showSlider() {
        let sliderWireframe = SliderWireframe()
        navigationController?.pushWireframe(sliderWireframe)
    }
    
    
    
    func showLabel() {
        let labelWireframe = LabelWireframe()
        navigationController?.pushWireframe(labelWireframe)
    }
    
    
    func showCapsuleView() {
        let capsuleViewWireframe = CapsuleWireframe()
        navigationController?.pushWireframe(capsuleViewWireframe)
    }
    
    func showDivider() {
        let dividerWireframe = DividerWireframe()
        navigationController?.pushWireframe(dividerWireframe)
        
    }
    
    func showDragGesture() {
        let dragGestureWireframe = DragGestureWireframe()
        navigationController?.pushWireframe(dragGestureWireframe)
    }
    
    func showBackground() {
        let showBackgroundWireframe = BackgroundWireframe()
        navigationController?.pushWireframe(showBackgroundWireframe)
    }
    
    func showPicker() {
        let pickerWireframe = PickerWireframe()
        navigationController?.pushWireframe(pickerWireframe)
    }
    
    func showCornerRadius() {
        let cornerRadiusWireframe = CornerRadiusWireframe()
        navigationController?.pushWireframe(cornerRadiusWireframe)
    }
    
    
    func showOffset() {
        let offsetWireframe = OffsetWireframe()
        navigationController?.pushWireframe(offsetWireframe)
    }
    
    
    func showList() {
        let listWireframe = ListWireframe()
        navigationController?.pushWireframe(listWireframe)
    }
    
    
    func showActionSheet() {
        let actionSheetWireframe = ActionSheetWireframe()
        navigationController?.pushWireframe(actionSheetWireframe)
    }
    
    
    func showTransition() {
        let transitionWireframe = TransitionWireframe()
        navigationController?.pushWireframe(transitionWireframe)
    }
    
    
    
    func showTimeLineView() {
        let timelineViewWireframe = TimeLineViewWireframe()
        navigationController?.pushWireframe(timelineViewWireframe)
        
    }
    
    func showMap() {
        let mapWireframe = MapWireframe()
        navigationController?.pushWireframe(mapWireframe)
    }
    
    func showLink() {
        let linkWireframe = LinkWireframe()
        navigationController?.pushWireframe(linkWireframe)
    }
    
    func showPath() {
        let pathWireframe = PathWireframe()
        navigationController?.pushWireframe(pathWireframe)
    }
    
    func showTapGesture() {
        let tapGestureWireframe = TapGestureWireframe()
        navigationController?.pushWireframe(tapGestureWireframe)
    }

    func showGroup() {
        let groupWireframe = GroupWireframe()
        navigationController?.pushWireframe(groupWireframe)
    }
    
    
    func showRotationGesture() {
        let rotationGestureWireframe = RotationGestureWireframe()
        navigationController?.pushWireframe(rotationGestureWireframe)
        
    }
    
    func showMagnificationGesture() {
        let magnificationGestureWireframe = MagnificationGestureWireframe()
        navigationController?.pushWireframe(magnificationGestureWireframe)
        
    }
    
    
    func showCustomShape() {
        let customShapeWireframe = CustomShapeWireframe()
        navigationController?.pushWireframe(customShapeWireframe)
    }
    
    
    func showForegroundColor() {
        let foregroundColorWireframe = ForegroundColorWireframe()
        navigationController?.pushWireframe(foregroundColorWireframe)
    }
    
    func showGeometryReader() {
        let geometryReaderWireframe = GeometryReaderWireframe()
        navigationController?.pushWireframe(geometryReaderWireframe)
    }
    
    func showPopover() {
        let popoverWireframe = PopoverWireframe()
        navigationController?.pushWireframe(popoverWireframe)
    }
    func showEnvironmentObject() {
        let sharedData = EnvironmentObjectEntity()
        let environmentObjectWireframe = EnvironmentObjectWireframe(sharedData: sharedData)
        navigationController?.pushWireframe(environmentObjectWireframe)
    }
    
    func showStateView() {
        let sharedData = EnvironmentObjectEntity() // Get shared EnvironmentObject
        let stateWireframe = StateWireframe(sharedData: sharedData)
        navigationController?.pushWireframe(stateWireframe)
    }
    
    func showEnvironmentObject() {
        let sharedData = EnvironmentObjectEntity()
        let environmentObjectWireframe = EnvironmentObjectWireframe(sharedData: sharedData)
        navigationController?.pushWireframe(environmentObjectWireframe)
    }
    
    func showStateView() {
        let sharedData = EnvironmentObjectEntity() // Get shared EnvironmentObject
        let stateWireframe = StateWireframe(sharedData: sharedData)
        navigationController?.pushWireframe(stateWireframe)
    }
    
    

    
    func showProgressIndicator() {
        let progressIndicatorWireframe = ProgressIndicatorWireframe()
        navigationController?.pushWireframe(progressIndicatorWireframe)
    }
      
    func showObservedObject() {
        let observedObjectWireframe = ObservedObjectWireframe()
        navigationController?.pushWireframe(observedObjectWireframe)
    }
    
    
    func showVideoPlayer() {
            let videoPlayerWireframe = VideoPlayerWireframe()
            navigationController?.pushWireframe(videoPlayerWireframe)
    }


    func showFocusState() {
        let focusStateWireframe = FocusStateWireframe()
        navigationController?.pushWireframe(focusStateWireframe)
    }
}
