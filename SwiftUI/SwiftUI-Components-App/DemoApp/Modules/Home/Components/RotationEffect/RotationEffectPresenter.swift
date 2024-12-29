import Foundation

final class RotationEffectPresenter : ObservableObject{
    
    // MARK: - Private properties -

    private let wireframe: RotationEffectWireframeInterface
    
    // MARK: - Lifecycle -
    
    init(wireframe: RotationEffectWireframeInterface) {
        self.wireframe = wireframe
    }
    
    // MARK: - Navigation methods -
    
    /// Navigates back in the navigation stack
        func goBack() {
            wireframe.goBack()
        }
}
