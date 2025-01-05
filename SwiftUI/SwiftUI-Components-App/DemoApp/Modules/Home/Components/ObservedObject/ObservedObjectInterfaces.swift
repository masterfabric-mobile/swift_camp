import Foundation
import SwiftUICore

// function interfaces

protocol ObservedObjectWireframeInterface {
    func goBack()
}

protocol ObservedObjectInteractorInterface {
    func incrementCounter()
    func getValue() -> Int
}

protocol ObservedObjectPresenterInterface {
    var counterValue: Int { get }
    func isIncrementButtonClicked()
}
