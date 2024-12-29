import SwiftUI

struct HomeView: View {
    // MARK: - HomeView State & ObservedObject
    @ObservedObject var presenter: HomePresenter
    @State private var commitCount = 0
    @State private var closedPRCount = 0
    @State private var branchCount = 0
    @State private var contributors: [Contributor] = []
    @State private var selectedContributor: Contributor?
    @State private var showDialog = false

    struct Contributor: Identifiable, Decodable {
        let id: Int
        let login: String
        let avatar_url: String
        let html_url: String

        var username: String { login }
        var avatarURL: String { avatar_url }
        var profileURL: String { html_url }
    }

    // Button model
    struct ButtonModel: Identifiable {
        let id = UUID()
        let title: String
        let action: () -> Void
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {

                // AppBar with dynamic information
                HStack {
                    VStack(alignment: .leading) {
                        Text("Version: 1.0.0 | Firmware: \(deviceInfo)")
                            .font(.footnote)
                        Text("Screen: \(screenResolution)")
                            .font(.footnote)
                        Text("Environment: \(isSimulator)")
                            .font(.footnote)
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding()

                ScrollView {
                    VStack(alignment: .center, spacing: 20) {

                        // Centered Header
                        Text("Welcome to SwiftUI Components App")
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 5)

                        // Description
                        Text(
                            "This app provides an interactive guide to learning SwiftUI components. Explore, experiment, and enhance your skills through dynamic examples."
                        )
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 20)

                        // Benefits list
                        VStack(alignment: .leading, spacing: 10) {
                            Text("What you'll gain:")
                                .font(.headline)
                                .padding(.bottom, 5)

                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.pink)
                                Text("Understand core SwiftUI concepts.")
                            }
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Learn how to build interactive UIs.")
                            }
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Develop a strong foundation for app design.")
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)

                        // Footer - Repo Info
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("Repo Info")
                                    .font(.headline)
                                    .padding(.top, 20)

                                Spacer()

                                Button(action: {
                                    if let url = URL(
                                        string: "https://github.com/masterfabric-mobile/swift_camp")
                                    {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    Text("Star Repo")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }

                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Commits: \(commitCount)")
                                    Text("Closed PRs: \(closedPRCount)")
                                    Text("Branches: \(branchCount)")
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)

                            // Contributors
                            HStack {
                                Text("Contributors")
                                    .font(.headline)

                                Spacer()

                                // Chip with contributors count
                                Text("\(contributors.count) Contributors")
                                    .font(.caption)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                    .clipShape(Capsule())
                            }

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(contributors) { contributor in
                                        VStack {
                                            AsyncImage(url: URL(string: contributor.avatarURL)) {
                                                image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())

                                            Text(contributor.username)
                                                .font(.caption)

                                            Button(action: {
                                                selectedContributor = contributor
                                                showDialog = true
                                            }) {
                                                Text("View Profile")
                                                    .font(.caption2)
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        .padding(5)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        // Dynamic Buttons
                        let buttons = [
                            ButtonModel(
                                title: "Go to VStackView", action: { presenter.showVStack() }),
                            ButtonModel(
                                title: "Go to HStackView", action: { presenter.showHStack() }),
                            ButtonModel(
                                title: "Go to ZStackView", action: { presenter.showZStack() }),
                            ButtonModel(
                                title: "Go to ContentView", action: { presenter.showContentView() }),
                            ButtonModel(
                                title: "Go to ColorPicker", action: { presenter.showColorPicker() }),
                            ButtonModel(
                                title: "Go to Rectangle", action: { presenter.showRectangle() }),
                            ButtonModel(
                                title: "Go to Section", action: { presenter.showSection() }),
                            ButtonModel(title: "Go to Frame", action: { presenter.showFrame() }),
                            ButtonModel(
                                title: "Go to NavigationStack",
                                action: { presenter.showNavigationStack() }),
                            ButtonModel(
                                title: "Go to ScrollView", action: { presenter.showScrollView() }),
                            ButtonModel(
                                title: "Go to NavigationView",
                                action: { presenter.showNavigationView() }),
                            ButtonModel(
                                title: "Go to Transaction",
                                action: {
                                    presenter.showTransaction()
                                }),
                            ButtonModel(

                                title: "Go to LazyHGrid",
                                action: {
                                    presenter.showLazyHGrid()
                                }),

                            ButtonModel(
                                title: "Go to LazyVStack",
                                action: {
                                    presenter.showLazyVStackView()
                                }),

                            ButtonModel(
                                title: "Go to MatchedGeometryEffect",
                                action: {
                                    presenter.showMatchedGeometryEffect()
                                }),

                            ButtonModel(
                                title: "Go to Image",
                                action: { presenter.showImage() }),
                            ButtonModel(
                                title: "Go to Menu Button",
                                action: { presenter.showMenuButton() }),

                            ButtonModel(title: "Go to Secure Field", action: { presenter.showSecureField() }),
                            ButtonModel(title: "Go to ContextMenu", action: { presenter.showContextMenu()}),
                            ButtonModel(title: "Go to Stepper", action: { presenter.showStepper() }),
                            ButtonModel(title: "Go to LazyVGrid", action: { presenter.showLazyVGridView() }),
                            ButtonModel(title: "Go to Canvas", action: { presenter.showCanvas()}),
                            ButtonModel(title: "Go to Ellipse", action: { presenter.showEllipse() }),
                            ButtonModel(title: "Go to Padding", action: { presenter.showPadding() }),
                            ButtonModel(title: "Go to Picker", action: { presenter.showPicker() }),
                        ]

                        ForEach(buttons) { button in
                            Button(button.title) {
                                button.action()
                            }
                            .frame(maxWidth: .infinity)  // Make buttons wide
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)  // Add horizontal padding
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .background(Color(UIColor.systemBackground))  // Adapts to light/dark mode
            .onAppear {
                fetchRepoInfo()
            }
        }.alert(isPresented: $showDialog) {
            if let contributor = selectedContributor {
                return Alert(
                    title: Text(contributor.username),
                    message: Text("View GitHub profile or close this dialog."),
                    primaryButton: .default(Text("Go to Profile")) {
                        if let url = URL(string: contributor.profileURL) {
                            UIApplication.shared.open(url)
                        }
                    },
                    secondaryButton: .cancel()
                )
            } else {
                return Alert(
                    title: Text("Error"), message: Text("No contributor selected."),
                    dismissButton: .cancel())
            }
        }
    }

    // MARK: - Device Info Helpers
    var deviceInfo: String {
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        return "\(systemName) \(systemVersion)"
    }

    var screenResolution: String {
        let screen = UIScreen.main.bounds
        return "\(Int(screen.width)) x \(Int(screen.height))"
    }

    var isSimulator: String {
        #if targetEnvironment(simulator)
            return "Simulator"
        #else
            return "Real Device"
        #endif
    }

    // MARK: - GitHub API Integration
    func fetchRepoInfo() {
        let baseURL = "https://api.github.com/repos/masterfabric-mobile/swift_camp"

        // Generic pagination fetch function
        func fetchPaginatedData<T: Decodable>(
            endpoint: String,
            perPage: Int = 100,
            collection: [T] = [],
            page: Int = 1,
            completion: @escaping ([T]) -> Void
        ) {
            // For pull requests, we need to include the state parameter if we want to fetch closed PRs
            let url =
                if endpoint == "pulls" {
                    "\(baseURL)/\(endpoint)?state=closed&per_page=\(perPage)&page=\(page)"
                } else {
                    "\(baseURL)/\(endpoint)?per_page=\(perPage)&page=\(page)"
                }

            fetchGenericData(from: url) { (items: [T]) in
                var updatedCollection = collection
                updatedCollection.append(contentsOf: items)

                if items.count == perPage {
                    fetchPaginatedData(
                        endpoint: endpoint,
                        perPage: perPage,
                        collection: updatedCollection,
                        page: page + 1,
                        completion: completion
                    )
                } else {
                    completion(updatedCollection)
                }
            }
        }

        // Fetch commits
        fetchPaginatedData(endpoint: "commits", collection: [Commit]()) { commits in
            DispatchQueue.main.async {
                self.commitCount = commits.count
                print("Total commits: \(commits.count)")
            }
        }

        // Fetch closed PRs
        fetchPaginatedData(endpoint: "pulls", collection: [PullRequest]()) { pulls in
            DispatchQueue.main.async {
                self.closedPRCount = pulls.count
                print("Total closed PRs: \(pulls.count)")
            }
        }

        // Fetch branches
        fetchGenericData(from: "\(baseURL)/branches") { (branches: [Branch]) in
            DispatchQueue.main.async {
                self.branchCount = branches.count
            }
        }

        // Fetch contributors
        fetchGenericData(from: "\(baseURL)/contributors") { (contributors: [Contributor]) in
            DispatchQueue.main.async {
                self.contributors = contributors
            }
        }
    }

    private func fetchGenericData<T: Decodable>(
        from urlString: String, completion: @escaping (T) -> Void
    ) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData)
            } catch {
                print("Failed to decode data from \(urlString): \(error)")
            }
        }.resume()
    }

    struct Commit: Decodable {}
    struct PullRequest: Decodable {}
    struct Branch: Decodable {}
}
