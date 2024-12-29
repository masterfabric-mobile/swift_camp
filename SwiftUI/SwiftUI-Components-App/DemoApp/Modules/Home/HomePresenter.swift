import Combine
import Foundation

final class HomePresenter: ObservableObject {
    
    // MARK: - Private properties -
    
    private let wireframe: HomeWireframeInterface
    
    // MARK: - Lifecycle -
    
    init(wireframe: HomeWireframeInterface) {
        self.wireframe = wireframe
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
    func showTransaction(){
        wireframe.showTransaction()
    }
    
    /// Navigates to LazyHGridView
    func showLazyHGrid(){
        wireframe.showLazyHGrid()
        }
        
        
        /// Navigates to LazyVStack
        func showLazyVStackView() {
            wireframe.showLazyVStackView()
        }
        
        /// Navigates to MatchedGeometryEffectView
        func showMatchedGeometryEffect(){
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
    func showStepper(){
        wireframe.showStepper()
    }
    
    func showLazyVGridView() {
        wireframe.showLazyVGridView()

    }
    
    /// Navigates to Ellipse
    func showEllipse(){
        wireframe.showEllipse()
    }
    
    /// Navigates to Padding
    func showPadding() {
        wireframe.showPadding()
    }
        
    // Navigates to Picker
    func showPicker() {
            wireframe.showPicker()
    }
}
