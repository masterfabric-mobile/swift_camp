import Foundation
import SwiftUI

final class FramePresenter: ObservableObject {

    // MARK: - Properties

    private let wireframe: FrameWireframeInterface

    // Frame properties
    @Published var width: CGFloat = 150
    @Published var height: CGFloat = 150

    // MARK: - Lifecycle

    init(wireframe: FrameWireframeInterface) {
        self.wireframe = wireframe
    }

    // MARK: - Navigation

    func goBack() {
        wireframe.goBack()
    }
}
