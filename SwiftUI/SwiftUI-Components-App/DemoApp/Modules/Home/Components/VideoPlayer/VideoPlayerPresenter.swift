import UIKit
import Foundation
import Combine

final class VideoPlayerPresenter: ObservableObject {
    
    private let wireframe: VideoPlayerWireframeInterface
    
    init(wireframe: VideoPlayerWireframeInterface) {
        self.wireframe = wireframe
    }
    
    func goBack() {
        wireframe.goBack()
    }
}

