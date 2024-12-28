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

    /// Navigates to LazyHStackView
    func showLazyHStack() {
        wireframe.showLazyHStack()
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
    
    /// Navigates to LazyVStack
    func showLazyVStackView() {
        wireframe.showLazyVStackView()
    }
    
    /// Navigates to MatchedGeometryEffectView
    func showMatchedGeometryEffect() {
        wireframe.showMatchedGeometryEffect()
    }
}

