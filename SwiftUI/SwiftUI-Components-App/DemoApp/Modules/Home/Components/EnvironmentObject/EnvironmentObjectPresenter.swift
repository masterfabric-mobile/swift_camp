import Foundation
import SwiftUI

final class EnvironmentObjectPresenter: ObservableObject {

    // MARK: - Properties

    private let wireframe: EnvironmentObjectWireframeInterface
    let sharedData: EnvironmentObjectEntity

    // MARK: - Lifecycle

    init(wireframe: EnvironmentObjectWireframeInterface, sharedData: EnvironmentObjectEntity) {
        self.wireframe = wireframe
        self.sharedData = sharedData
    }

    // MARK: - Navigation

    func goBack() {
        wireframe.goBack()
    }

    // MARK: - Actions

    func incrementCounter() {
        sharedData.counter += 1
    }

    func decrementCounter() {
        sharedData.counter -= 1
    }
}
