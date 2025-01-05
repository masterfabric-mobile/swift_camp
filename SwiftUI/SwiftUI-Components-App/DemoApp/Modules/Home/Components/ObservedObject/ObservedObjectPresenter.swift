import Foundation

final class ObservedObjectPresenter: ObservableObject, ObservedObjectPresenterInterface {
    private let wireframe: ObservedObjectWireframeInterface
    private let interactor: ObservedObjectInteractorInterface
    
    @Published private(set) var counterValue: Int = 0
    
    init(wireframe: ObservedObjectWireframeInterface, interactor: ObservedObjectInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.counterValue = interactor.getValue()
    }
    
    func isIncrementButtonClicked() {
        interactor.incrementCounter()
        counterValue = interactor.getValue()
    }
    
    func goBack() {
        wireframe.goBack()
    }
}
