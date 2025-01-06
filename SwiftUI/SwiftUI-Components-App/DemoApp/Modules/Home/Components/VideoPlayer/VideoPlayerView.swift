import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let embedURL = "https://www.youtube.com/embed/\(videoID)?rel=0&controls=1&autoplay=1"
        let request = URLRequest(url: URL(string: embedURL)!)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct VideoPlayerView: View {
    @ObservedObject var presenter: VideoPlayerPresenter

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                // YouTube Video Player
                YouTubePlayerView(videoID: "q1lPAaIveGk")
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()

                Spacer()
            }

            // Back Button in the top-left corner
            VStack {
                HStack {
                    Button(action: presenter.goBack) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 10)
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }
}

