import SwiftUI

struct HomeView: View {
    // MARK: - HomeView State & ObservedObject
    @ObservedObject var presenter: HomePresenter

    var body: some View {
        let repoInfo = presenter.repoInfo ?? GithubRepoInfo(
            commitCount: 0,
            closedPRCount: 0,
            branchCount: 0,
            contributors: []
        )

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
                    
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 5) {                        // Date Icon and Label
                            HStack(spacing: 5) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                Text(TimeHelper.shared.getCurrentDate(format: "yyyy-MM-dd"))
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }

                            // Time Icon and Label
                            HStack(spacing: 5) {
                                Image(systemName: "clock")
                                    .foregroundColor(.blue)
                                Text(presenter.currentTime)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                        }
                    }
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
                                    Text("Commits:")
                                        .font(.headline)
                                        .bold()
                                    Text("\(repoInfo.commitCount)")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                    
                                    Text("Closed PRs:")
                                        .font(.headline)
                                        .bold()
                                    Text("\(repoInfo.closedPRCount)")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                    
                                    Text("Branches:")
                                        .font(.headline)
                                        .bold()
                                    Text("\(repoInfo.branchCount)")
                                        .font(.body)
                                        .foregroundColor(.gray)
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
                                Text("\(repoInfo.contributors.count) Contributors")
                                    .font(.caption)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(repoInfo.contributors) { contributor in
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
                                                presenter.selectedContributor = contributor
                                                presenter.showDialog = true
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
                        // Footer - Environment Info
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("Environment Info")
                                    .font(.headline)
                                    .padding(.top, 20)
                                
                                Spacer()
                            }
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Environment:")
                                        .font(.headline)
                                        .bold()
                                    Text(EnvironmentHelper.shared.environment.rawValue)
                                        .font(.body)
                                        .foregroundColor(.gray)

                                    Text("API Base URL:")
                                        .font(.headline)
                                        .bold()
                                    Text(EnvironmentHelper.shared.apiBaseUrl)
                                        .font(.body)
                                        .foregroundColor(.gray)

                                    Text("API Key:")
                                        .font(.headline)
                                        .bold()
                                    Text(EnvironmentHelper.shared.apiKey)
                                        .font(.body)
                                        .foregroundColor(.gray)

                                    if EnvironmentHelper.shared.environment == .dev {
                                        Text("OneSignal App ID:")
                                            .font(.headline)
                                            .bold()
                                        Text(EnvironmentHelper.shared.oneSignalAppID)
                                            .font(.body)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            // App Version Info
                            HStack {
                                Text("Components")
                                    .font(.headline)
                                
                                Spacer()
                            }
                            .padding(.top, 10)
                        }
                        .padding(.horizontal)
                        
                        // Dynamic Buttons
                        let buttons : [ButtonModel] = [
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
                                title: "Go to Text", action: { presenter.showText() }),
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
                                title: "Go to TabView",
                                action: {
                                    presenter.showTabView()
                                }),
                            ButtonModel(title: "Go to AttributedText", action: {
                                presenter.showAttributedText()
                            }),
                            ButtonModel(title: "Go to Button", action: {
                                presenter.showButton()
                            }),
                            ButtonModel(title: "Go to DatePicker", action: {
                                presenter.showDatePicker()
                            }),
                            ButtonModel(title: "Go to SegmentedControl", action: {
                                presenter.showSegmentedControl()
                            }),
                            ButtonModel(title: "Go to RoundedRectagle", action: { presenter.showRaundedRectagle()}),
                            ButtonModel(title:"Go to Shadow", action: { presenter.showShadow()}),
                            ButtonModel(title: "Go to ScaleView", action: { presenter.showScaleEffect()}),
                            ButtonModel(title: "Go to Animation", action: { presenter.showAnimation()} ),
                            ButtonModel(title: "Go to LazyHGrid", action: { presenter.showLazyHGrid()} ),
                            ButtonModel(title: "Go to LazyVStack", action: { presenter.showLazyVStackView()} ),
                            ButtonModel(title: "Go to MatchedGeometryEffect", action: {presenter.showMatchedGeometryEffect()}),
                            ButtonModel(
                                title: "Go to Image",
                                action: { presenter.showImage() }),
                            ButtonModel(
                                title: "Go to Menu Button",
                                action: { presenter.showMenuButton() }),
                            ButtonModel(
                                title: "Go to Circle",
                                action: { presenter.showCircle() }),
                            ButtonModel(
                                title: "Go to Opacity",
                                action: { presenter.showOpacity() }),
                            ButtonModel(title: "Go to Secure Field", action: { presenter.showSecureField() }),
                            ButtonModel(title: "Go to ContextMenu", action: { presenter.showContextMenu()}),
                            ButtonModel(title: "Go to Binding", action: { presenter.showBinding()}),
                            ButtonModel(title: "Go to Stepper", action: { presenter.showStepper() }),
                            ButtonModel(title: "Go to LazyVGrid", action: { presenter.showLazyVGridView()}),
                            ButtonModel(title: "Go to LazyVGrid", action: { presenter.showLazyVGridView() }),
                            ButtonModel(title: "Go to Canvas", action: { presenter.showCanvas()}),
                            ButtonModel(title: "Go to Ellipse", action: { presenter.showEllipse() }),
                            ButtonModel(title: "Go to Padding", action: { presenter.showPadding() }),
                            ButtonModel(title: "Go to LazyHStack", action: { presenter.showLazyHStack()}),
                            ButtonModel(title: "Go to Alert", action: { presenter.showAlert() }),
                            ButtonModel(title: "Go to RotationEffect", action: { presenter.showRotationEffect()}),
                            ButtonModel(title: "Go to WithAnimation", action: { presenter.showWithAnimation() }),
                            ButtonModel(title: "Go to TextField", action: { presenter.showTextField()}),
                            ButtonModel(title: "Go to LongPressGesture", action:{presenter.showLongPressGesture()
                            }),
                            ButtonModel(title: "Go to Progress View", action:{ presenter.showProgressView()}),
                            ButtonModel(title: "Go to Grid", action: { presenter.showGrid()}),
                            ButtonModel(title: "Go to Slider", action: { presenter.showSlider()}),
                            ButtonModel(title: "Go to TextField", action: { presenter.showTextField()}),
                            ButtonModel(title: "Go to Label", action: { presenter.showLabel()}),
                            ButtonModel(title: "Go To Capsule", action: {presenter.showCapsuleView()}),
                            ButtonModel(title: "Go to Divider", action: { presenter.showDivider() }),
                            ButtonModel(title: "Go to DragGesture", action: { presenter.showDragGesture()}),
                            ButtonModel(title: "Go to Background", action: {presenter.showBackground()}),
                            ButtonModel(title: "Go to Picker", action: { presenter.showPicker() }),
                            ButtonModel(title: "Go to Corner Radius", action: {presenter.showCornerRadius()}),
                            ButtonModel(title: "Go to Offset", action: { presenter.showOffset()}),
                            ButtonModel(title: "Go to List", action: { presenter.showList()}),

                            ButtonModel(title: "Go to ActionSheet", action: { presenter.showActionSheet()}),
                            ButtonModel(title: "Go to Transition", action: { presenter.showTransition() }),
                            ButtonModel(title: "Go to TimeLineView", action: { presenter.timeLineView() }),
                            ButtonModel(title: "Go to Map", action: { presenter.showMap()}),
                            ButtonModel(title: "Go to Link", action: { presenter.showLink()}),
                            ButtonModel(title: "Go to Path", action: { presenter.showPath()}),
                            ButtonModel(title: "Go to TapGesture", action: {presenter.showTapGesture()}),



                            ButtonModel(title: "Go to Group", action: {presenter.showGroup()}),

                            ButtonModel(title: "Go to MagnificationGesture", action: {presenter.showMagnificationGesture()}),




                            ButtonModel(title: "Go to RotationGesture", action: {presenter.showRotationGesture()}),

                            ButtonModel(title: "Go to MagnificationGesture", action: {presenter.showMagnificationGesture()}),



                            
                            ButtonModel(title: "Go to CustomShape", action: { presenter.showCustomShape()}),
                            ButtonModel(title: "Go to ForegroundColor", action: {presenter.showForegroundColor()}),
                            
                            ButtonModel(title: "Go to Geometry Reader", action: {presenter.showGeometryReader()}),
                            ButtonModel(title:"Go to Popover", action: {presenter.showPopover()}),
                            ButtonModel(title: "Go to FocusState", action: {presenter.showFocusState()}),
                            

                            ButtonModel(title: "Go to ProgressIndicator", action: { presenter.showProgressIndicator()}),

                            ButtonModel(title: "Go to Observed Object", action: {presenter.showObservedObject()})



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
                            presenter.fetchRepoInfo()
                            presenter.startUpdatingTime()
            }.onDisappear {
            }
        }.alert(isPresented: $presenter.showDialog) {
            if let contributor = presenter.selectedContributor {
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
    
}
