import Foundation

class ObservedObjectInteractor: ObservedObjectInteractorInterface {
    private var counter = ObservedObjectEntity()
    
    func incrementCounter() {
        counter.value = counter.value + 1
    }
    
    func getValue() -> Int {
        return counter.value
    }
}
        
