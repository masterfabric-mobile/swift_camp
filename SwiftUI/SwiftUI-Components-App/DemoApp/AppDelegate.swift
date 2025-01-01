import UIKit
import OneSignalFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppWindowHandler {
    
    private let oneSignalAppID = EnvironmentHelper.shared.oneSignalAppID

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
        
        // OneSignal initialization
        LoggerHelper.shared.info("Initializing OneSignal with App ID.")
        OneSignal.initialize(oneSignalAppID, withLaunchOptions: launchOptions)
        
        OneSignal.Notifications.requestPermission({ accepted in
            LoggerHelper.shared.info("User accepted notifications: \(accepted)")
            self.updateAppPermissions(notificationAllowed: accepted)
        }, fallbackToSettings: true)
        
        // LocalStorageHelper initialization
        LoggerHelper.shared.debug("Initializing local storage database.")
        LocalStorageHelper.shared.initializeDatabase()
        
        // Configure app database
        setupAppDatabase()
        
        // Store app information
        storeAppInformation()
        
        logDatabaseRecords()
        
        // Configure initializers
        LoggerHelper.shared.debug("Setting up app initializers.")
        initializers = StartupInitializationBuilder()
            .setAppDelegate(self)
            .build(with: launchOptions)
        
        LoggerHelper.shared.info("Application did finish launching.")
        return true
    }
    
    // MARK: - App Database Setup
    
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
        let installDate = DateFormatter.localizedString(
            from: Date(),
            dateStyle: .medium,
            timeStyle: .short
        )
        
        // Fetch OneSignal Subscriber ID
        let subID = "unknown" // TODO: Replace with actual fetching logic

        // Fetch existing records
        let records = LocalStorageHelper.shared.fetchData(tableName: "AppInfo")
        
        if records.count > 1 {
            // Delete all existing records if there are more than 1
            LoggerHelper.shared.warning("Multiple records found in AppInfo table. Deleting all records.")
            LocalStorageHelper.shared.deleteData(tableName: "AppInfo")
        }

        if records.isEmpty || records.count > 1 {
            // Insert a new record if the table is empty or all records were deleted
            LoggerHelper.shared.debug("No valid record found. Inserting a new AppInfo record.")
            LocalStorageHelper.shared.insertEncryptedData(
                tableName: "AppInfo",
                data: [
                    "subID": subID,
                    "deviceModel": deviceModel,
                    "osVersion": osVersion,
                    "installDate": installDate,
                    "notificationAllowed": false // Default to false initially
                ]
            )
        } else {
            // Update the existing record
            LoggerHelper.shared.debug("Single record found. Updating the AppInfo record.")
            LocalStorageHelper.shared.updateData(
                tableName: "AppInfo",
                data: [
                    "subID": subID,
                    "deviceModel": deviceModel,
                    "osVersion": osVersion,
                    "installDate": installDate,
                    "notificationAllowed": false
                ],
                condition: "id = 1" // Assuming the first record has id = 1
            )
        }
        
        LoggerHelper.shared.info("App information stored or updated successfully.")
    }
    
    // MARK: - App Permissions
    
    private func updateAppPermissions(notificationAllowed: Bool) {
        LoggerHelper.shared.debug("Updating app permissions in local database.")
        
        LocalStorageHelper.shared.updateData(
            tableName: "AppInfo",
            data: ["notificationAllowed": notificationAllowed],
            condition: "id = 1" // Assuming single entry for simplicity
        )
        
        LoggerHelper.shared.info("App permissions updated successfully.")
    }
}

// MARK: - Log Database Records

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
