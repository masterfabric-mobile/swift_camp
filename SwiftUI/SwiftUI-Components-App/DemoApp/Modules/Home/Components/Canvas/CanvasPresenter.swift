import Foundation
import SwiftUI

final class CanvasPresenter: ObservableObject {

    // MARK: - Properties

    private let wireframe: CanvasWireframeInterface

    // State properties for dynamic rendering
    @Published var color: Color = .blue

    // MARK: - Lifecycle

    init(wireframe: CanvasWireframeInterface) {
        self.wireframe = wireframe
    }

    // MARK: - Navigation

    func goBack() {
        wireframe.goBack()
    }

    // MARK: - Actions

    func changeColor(to color: Color) {
        self.color = color
    }
}
