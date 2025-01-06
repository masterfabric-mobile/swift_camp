import Combine
import Foundation

final class HomePresenter: ObservableObject {
    
    // Published properties
    @Published var repoInfo: GithubRepoInfo?
    @Published var selectedContributor: Contributor?
    @Published var showDialog = false
    @Published var currentTime: String = ""
    
    // MARK: - Private properties -
    private let interactor: HomeInteractorInterface
    private let wireframe: HomeWireframeInterface
    private var timerSubscription: AnyCancellable?
    private func updateTime() {
        currentTime = TimeHelper.shared.getCurrentTime(format: "HH:mm:ss")
    }
    
    // MARK: - Lifecycle -
    
    init(interactor:HomeInteractorInterface,wireframe: HomeWireframeInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func fetchRepoInfo() {
        interactor.fetchRepoInfo { [weak self] info in
            DispatchQueue.main.async {
                self?.repoInfo = info
            }
        }
    }
    
    // MARK: Time
    /// Starts the timer to update the current time every second
    func startUpdatingTime() {
        updateTime() // Initial update
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                // Ensure that the update happens on the main thread
                DispatchQueue.main.async {
                    self?.updateTime()
                }
            }
    }
    
    /// Stops the timer for updating the current time
    func stopUpdatingTime() {
        timerSubscription?.cancel()
    }
    
    /// Navigates to VStackView
    func showVStack() {
        wireframe.showVStack()
    }
    
    /// Navigates to ZStackView
    func showZStack() {
        wireframe.showZStack()
    }
    
    /// Navigates to ContentView
    func showContentView() {
        wireframe.showContentView()
    }
    
    /// Navigates to Text
    func showText() {
        wireframe.showText()
    }
    
    /// Navigates to ColorPickerView
    func showColorPicker() {
        wireframe.showColorPicker()
    }
    
    /// Navigates to RectangleView
    func showRectangle() {
        wireframe.showRectangle()
    }
    
    /// Navigates to SectionView
    func showSection() {
        wireframe.showSection()
    }
    
    /// Navigates to HStackView
    func showHStack() {
        wireframe.showHStack()
    }
    /// Navigates to NavigationStackView
    func showNavigationStack() {
        wireframe.showNavigationStack()
    }
    
    /// Navigates to FrameView
    func showFrame() {
        wireframe.showFrame()
    }
    
    /// Navigates to ScrollView
    func showScrollView() {
        wireframe.showScrollView()
    }
    
    /// Navigates to NavigationView
    func showNavigationView() {
        wireframe.showNavigationView()
    }
    
    /// Navigates to TransactionView
    func showTransaction() {
        wireframe.showTransaction()
    }
    
    /// Navigates to TabView
    func showTabView() {
        wireframe.showTabView()
    }
    
    /// Navigates to AttributedText
    func showAttributedText() {
        wireframe.showAttributedText()
    }
    
    /// Navigates to Button
    func showButton() {
        wireframe.showButton()
    }
    
    /// Navigates to DatePicker
    func showDatePicker() {
        wireframe.showDatePicker()
    }
    
    /// Navigates to SegmentedControl
    func showSegmentedControl() {
        wireframe.showSegmentedControl()
    }
    
    /// Navigates to RoundedRectangle
    func showRaundedRectangle() {
        wireframe.showRoundedRectangle()
    }
    
    /// Navigates to Shadow
    func showShadow() {
        wireframe.showShadow()
    }
    
    /// Navigates to ScaleEffect
    func showScaleEffect() {
        wireframe.showScaleEffect()
    }
    
    /// Navigates to Animation
    func showAnimation() {
        wireframe.showAnimation()
    }
    
    /// Navigates to LazyHGridView
    func showLazyHGrid() {
        wireframe.showLazyHGrid()
    }
    
    /// Navigates to LazyVStack
    func showLazyVStackView() {
        wireframe.showLazyVStackView()
    }
    
    /// Navigates to MatchedGeometryEffectView
    func showMatchedGeometryEffect() {
        wireframe.showMatchedGeometryEffect()
        
    }
    /// Navigates to Image
    func showImage() {
        wireframe.showImage()
    }
    /// Navigates to Image
    func showMenuButton() {
        wireframe.showMenuButton()
    }
    /// Navigates to Circle//
    func showCircle() {
        wireframe.showCircle()
    }
    // Navigates to Opacity//
    func showOpacity() {
        wireframe.showOpacity()
    }
    
    /// Navigates to Secure Field
    func showSecureField() {
        wireframe.showSecureField()
    }
    
    /// Navigates to ContextMenu View
    func showContextMenu() {
        wireframe.showContextMenu()
    }
    
    /// Navigates to ContextMenu View
    func showBinding() {
        wireframe.showBinding()
    }
    
    /// Navigates to Stepper
    func showStepper() {
        wireframe.showStepper()
    }
    
    func showLazyVGridView() {
        wireframe.showLazyVGridView()
        
    }
    
    /// Navigates to Ellipse
    func showEllipse() {
        wireframe.showEllipse()
    }
    
    /// Navigates to Padding
    func showPadding() {
        wireframe.showPadding()
    }
    
    func showCanvas() {
        wireframe.showCanvas()
    }
    
    /// Navigate to LazyHStack
    func showLazyHStack() {
        wireframe.showLazyHStack()
    }
    
    /// Navigates to RaundedRectagle
    func showRaundedRectagle() {
        wireframe.showRoundedRectangle()
    }
    
    /// Navigates to Alert
    func showAlert() {
        wireframe.showAlert()
    }
    
    func showRotationEffect() {
        wireframe.showRotationEffect()
    }
    
    /// Navigates to WithAnimation
    func showWithAnimation() {
        wireframe.showWithAnimation()
    }
    
    // Navigate to TextFieldView
    func showTextField() {
        wireframe.showTextField()
    }
    
    // Navigate to Progress View
    func showProgressView() {
        wireframe.showProgressView()
    }
    
    func showGrid() {
        wireframe.showGrid()
    }
    
    // Navigate to Slider View
    
    func showSlider() {
        wireframe.showSlider()
    }
    
    func showLabel() {
        wireframe.showLabel()
    }
    
    // Navigate to LongPressGesture
    func showLongPressGesture() {
        wireframe.showLongPressGesture()
    }
    
    func showCapsuleView() {
        wireframe.showCapsuleView()
        
    }
    
    /// Navigates to Divider
    func showDivider() {
        wireframe.showDivider()
    }
    
    /// Navigates to DragGesture
    func showDragGesture() {
        wireframe.showDragGesture()
    }
    
    func showBackground() {
        wireframe.showBackground()
    }
    
    /// Navigates to Picker
    func showPicker() {
        wireframe.showPicker()
    }
    
    func showCornerRadius() {
        wireframe.showCornerRadius()
    }
    
    
    
    
    
    /// Navigates to Offset
    func showOffset() {
        wireframe.showOffset()
    }
    
    /// Navigates to List
    func showList() {
        wireframe.showList()
    }
    
    
    
    
    /// Navigates to ActionSheet
    func showActionSheet() {
        wireframe.showActionSheet()
        
    }
    
    
    func showTransition() {
        wireframe.showTransition()
        
    }
    
    
    func timeLineView() {
        wireframe.showTimeLineView()
        
    }
    
    /// Navigates to Map
    func showMap() {
        wireframe.showMap()
    }
    
    /// Clean up the timer to avoid memory leaks
    deinit {
        stopUpdatingTime()
    }
    
    /// Navigates to Link
    func showLink() {
        wireframe.showLink()
        
    }
    
    /// Navigates to Path
    func showPath() {
        wireframe.showPath()
    }
    
    /// Navigates to TapGesture
    func showTapGesture() {
        wireframe.showTapGesture()
    }

    /// Navigates to Group
    func showGroup() {
        wireframe.showGroup()
    }

    
    func showRotationGesture() {
        wireframe.showRotationGesture()
    }


    func showMagnificationGesture() {
        wireframe.showMagnificationGesture()
    }
 
    /// Navigates to ForegroundColor
    func showForegroundColor() {
        wireframe.showForegroundColor()

    }
    
        func showCustomShape() {
            wireframe.showCustomShape()
        }
        
        func showGeometryReader() {
            wireframe.showGeometryReader()
        }
    
    func showEnvironmentObject() {
        wireframe.showEnvironmentObject()
    }

    func showPopover() {
        wireframe.showPopover()
    }
    
    func showStateView() {
        wireframe.showStateView()
    func showStateView() {
        wireframe.showStateView()

    
    func showProgressIndicator() {
        wireframe.showProgressIndicator()
    }
  
  
    func showObservedObject() {
        wireframe.showObservedObject()

    }
    
    
    func showVideoPlayer() {
            wireframe.showVideoPlayer()
    }

    func showFocusState() {
        wireframe.showFocusState()
    }
}
