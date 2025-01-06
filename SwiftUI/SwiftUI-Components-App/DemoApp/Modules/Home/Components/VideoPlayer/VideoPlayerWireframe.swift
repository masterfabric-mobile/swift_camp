final class VideoPlayerWireframe: BaseWireframe<LazyHostingViewController<VideoPlayerView>>, VideoPlayerWireframeInterface {

    // MARK: - Module setup -

    init() {
        let moduleViewController = LazyHostingViewController<VideoPlayerView>(isNavigationBarHidden: true)

        super.init(viewController: moduleViewController)

        let presenter = VideoPlayerPresenter(wireframe: self)

        moduleViewController.rootView = VideoPlayerView(presenter: presenter)
    }
}

extension VideoPlayerWireframe {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

