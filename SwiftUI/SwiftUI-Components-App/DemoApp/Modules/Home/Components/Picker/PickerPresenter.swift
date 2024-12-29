import Foundation

final class PickerPresenter : ObservableObject{
    
    // MARK: - Private properties -

    private let wireframe: PickerWireframeInterface
    
    // MARK: - Lifecycle -
    
    init(wireframe: PickerWireframeInterface) {
        self.wireframe = wireframe
    }
    
    // MARK: - Navigation methods -
    
    /// Navigates back in the navigation stack
        func goBack() {
            wireframe.goBack()
        }
}
