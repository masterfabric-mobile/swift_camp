import UIKit
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import OneSignalFramework
import Mixpanel
import FacebookCore
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppWindowHandler {

    private let oneSignalAppID = EnvironmentHelper.shared.oneSignalAppID
    private let mixPanelToken = EnvironmentHelper.shared.mixPanelToken
    
    // MARK: - Public properties -
    var window: UIWindow?
    var initializers: [Initializable] = [] {
        didSet { initializers.forEach { $0.initialize() } }
    }
    
    // MARK: - Lifecycle -
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        ThemeHelper.shared.applyTheme(ThemeHelper.shared.themeType)
            
        // Facebook SDK initialization
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        // Firebase Initialization
        FirebaseApp.configure()
        
        LoggerHelper.shared.info("Initializing OneSignal with App ID.")
        OneSignal.initialize(oneSignalAppID, withLaunchOptions: launchOptions)
        
        setupGoogleSignIn()
        LocalStorageHelper.shared.initializeDatabase()
        setupAppDatabase()
        storeAppInformation()
        logDatabaseRecords()
        startObservingAppStateChanges()
        Mixpanel.initialize(token: mixPanelToken, trackAutomaticEvents: false)
        
        OneSignal.Notifications.requestPermission({ accepted in
            LoggerHelper.shared.info("User accepted notifications: \(accepted)")
            self.updateAppPermissions(notificationAllowed: accepted)
        }, fallbackToSettings: true)
        
        LoggerHelper.shared.info("Application did finish launching.")
        
        initializers = StartupInitializationBuilder()
            .setAppDelegate(self)
            .build(with: launchOptions)
        
        // NetworkHelper initializers
         _ = NetworkHelper.shared
        
        return true
    }
    
    // MARK: - URL Handling for Facebook, Google, and Apple Sign-In
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // Handle Facebook login
        if ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        ) {
            return true
        }
        
        // Handle Google Sign-In
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }
        
        return false
    }

    // MARK: - Apple Sign-In Credential State Kontrolü
    func checkAppleSignInState(for userID: String) {
        Task {
            do {
                let credentialState = try await ASAuthorizationAppleIDProvider().credentialState(forUserID: userID)
                switch credentialState {
                case .authorized:
                    print("Apple ID is authorized.")
                case .revoked:
                    print("Apple ID credentials have been revoked.")
                case .notFound:
                    print("No Apple ID credentials found.")
                default:
                    break
                }
            } catch {
                print("Error while checking Apple ID credential state: \(error)")
            }
        }
    }

    private func setupGoogleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("CLIENT_ID not found in GoogleService-Info.plist")
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
    }
    
    private func startObservingAppStateChanges() {
        WorkManagerHelper.shared.$currentState
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .firstLaunch:
                    LoggerHelper.shared.info("🚀 First launch detected.")
                case .foreground:
                    LoggerHelper.shared.info("🌞 App entered foreground.")
                    MetaFacebookEventHelper.shared.logEvent(.appForeground, parameters: [:])
                case .background:
                    LoggerHelper.shared.info("🌙 App entered background.")
                    MetaFacebookEventHelper.shared.logEvent(.appBackground, parameters: [:])
                }
            }
            .store(in: &AppStateManager.cancellables)
    }
    
    private func setupAppDatabase() {
        LoggerHelper.shared.debug("Setting up the app database.")
        LocalStorageHelper.shared.createTable(
            tableName: "AppInfo",
            columns: [
                "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
                "subID": "TEXT",
                "deviceModel": "TEXT",
                "osVersion": "TEXT",
                "installDate": "TEXT",
                "notificationAllowed": "BOOLEAN"
            ]
        )
    }
    
    private func storeAppInformation() {
        LoggerHelper.shared.debug("Storing app information in local database.")
        
        let deviceModel = UIDevice.current.model
        let osVersion = UIDevice.current.systemVersion
        let installDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        let subID = "unknown"
        
        let records = LocalStorageHelper.shared.fetchData(tableName: "AppInfo")
        
        if records.count > 1 {
            LoggerHelper.shared.warning("Multiple records found. Deleting all.")
            LocalStorageHelper.shared.deleteData(tableName: "AppInfo")
        }
        
        if records.isEmpty || records.count > 1 {
            LocalStorageHelper.shared.insertEncryptedData(
                tableName: "AppInfo",
                data: [
                    "subID": subID,
                    "deviceModel": deviceModel,
                    "osVersion": osVersion,
                    "installDate": installDate,
                    "notificationAllowed": false
                ]
            )
        } else {
            LocalStorageHelper.shared.updateData(
                tableName: "AppInfo",
                data: [
                    "subID": subID,
                    "deviceModel": deviceModel,
                    "osVersion": osVersion,
                    "installDate": installDate,
                    "notificationAllowed": false
                ],
                condition: "id = 1"
            )
        }
        
        LoggerHelper.shared.info("App information stored or updated successfully.")
    }
    
    private func updateAppPermissions(notificationAllowed: Bool) {
        LoggerHelper.shared.debug("Updating app permissions in local database.")
        
        LocalStorageHelper.shared.updateData(
            tableName: "AppInfo",
            data: ["notificationAllowed": notificationAllowed],
            condition: "id = 1"
        )
        
        LoggerHelper.shared.info("App permissions updated successfully.")
    }
    
    private func logDatabaseRecords() {
        LoggerHelper.shared.debug("Fetching all records from the AppInfo table.")
        
        let records = LocalStorageHelper.shared.fetchData(tableName: "AppInfo")
        
        if records.isEmpty {
            LoggerHelper.shared.info("The AppInfo table is empty.")
        } else {
            LoggerHelper.shared.info("Fetched \(records.count) records from the AppInfo table:")
            for (index, record) in records.enumerated() {
                LoggerHelper.shared.info("Record \(index + 1): \(record)")
            }
        }
    }
    
    private enum AppStateManager {
        static var cancellables: Set<AnyCancellable> = []
    }
}
