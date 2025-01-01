import Foundation
import SQLite
import CommonCrypto

// MARK: - LocalStorageHelper
class LocalStorageHelper {
    // MARK: - Properties
    private var db: Connection?
    private let dbName = "LocalStorage.sqlite3"
    private let dbFilePath: String

    // Singleton Instance
    static let shared = LocalStorageHelper()

    // Access the encryption key from EnvironmentHelper
    private let encryptionKey = EnvironmentHelper.shared.encryptionKey

    // MARK: - Initialization
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let fileUrl = documentDirectory.appendingPathComponent(dbName)
            dbFilePath = fileUrl.path
            setupDatabase()
        } catch {
            LoggerHelper.shared.error("❌ Error determining database path: \(error.localizedDescription)")
            dbFilePath = ""
        }
    }
    
    // MARK: - Public Methods

    /// Initializes the database. Call this method during application launch.
    func initializeDatabase() {
        LoggerHelper.shared.info("🚀 Initializing database...")
        setupDatabase()
    }
    
    func fetchDecryptedData(tableName: String) -> [[String: Any]] {
        guard let db = db else { return [] }

        var results = [[String: Any]]()
        do {
            let fetchQuery = "SELECT * FROM \(tableName)"
            let statement = try db.prepare(fetchQuery)

            for row in statement {
                var rowData = [String: Any]()
                for (index, name) in statement.columnNames.enumerated() {
                    if let value = row[index] as? String {
                        do {
                            rowData[name] = try decrypt(value) // Decrypt value
                        } catch {
                            LoggerHelper.shared.error("❌ Error decrypting value for column '\(name)': \(error.localizedDescription)")
                            rowData[name] = "Decryption Failed"
                        }
                    } else {
                        rowData[name] = row[index]
                    }
                }
                results.append(rowData)
            }
            LoggerHelper.shared.info("✅ Data fetched and decrypted from \(tableName).")
        } catch {
            LoggerHelper.shared.error("❌ Error fetching data from \(tableName): \(error.localizedDescription)")
        }
        return results
    }

    /// Fetches decrypted app permissions from the database.
    func fetchAppPermissions() -> [String: Any]? {
        guard let record = fetchData(tableName: "AppInfo").first else { return nil }
        return record
    }
    
    /// Creates a table with specified columns dynamically.
    func createTable(tableName: String, columns: [String: String]) {
        guard let db = db else { return }

        do {
            let columnDefinitions = columns.map { "\($0.key) \($0.value)" }.joined(separator: ", ")
            let createTableQuery = "CREATE TABLE IF NOT EXISTS \(tableName) (\(columnDefinitions));"
            try db.run(createTableQuery)
            LoggerHelper.shared.info("✅ Table '\(tableName)' created with columns: \(columns.keys.joined(separator: ", "))")
        } catch {
            LoggerHelper.shared.error("❌ Error creating table '\(tableName)': \(error.localizedDescription)")
        }
    }

    /// Inserts encrypted data into the specified table.
    func insertEncryptedData(tableName: String, data: [String: Any]) {
        guard let db = db else { return }

        do {
            let keys = data.keys.joined(separator: ", ")
            let encryptedValues = try data.values.map {
                try encrypt(String(describing: $0))
            }
            let values = encryptedValues.map { "'\($0)'" }.joined(separator: ", ")
            let insertQuery = "INSERT INTO \(tableName) (\(keys)) VALUES (\(values));"
            try db.run(insertQuery)
            LoggerHelper.shared.info("✅ Encrypted data inserted into \(tableName).")
        } catch {
            LoggerHelper.shared.error("❌ Error inserting encrypted data into \(tableName): \(error.localizedDescription)")
        }
    }

    /// Updates a specific set of fields in the specified table with a condition.
    func updateData(tableName: String, data: [String: Any], condition: String) {
        guard let db = db else { return }

        do {
            let updates = data.map { "\($0.key) = '\($0.value)'" }.joined(separator: ", ")
            let updateQuery = "UPDATE \(tableName) SET \(updates) WHERE \(condition);"
            try db.run(updateQuery)
            LoggerHelper.shared.info("✅ Data updated in \(tableName) where \(condition).")
        } catch {
            LoggerHelper.shared.error("❌ Error updating data in \(tableName): \(error.localizedDescription)")
        }
    }

    /// Fetches decrypted data from the specified table based on the optional condition.
    func fetchData(tableName: String, columns: [String]? = nil, condition: String? = nil) -> [[String: Any]] {
        guard let db = db else { return [] }

        var results = [[String: Any]]()
        do {
            let columnsToSelect = columns?.joined(separator: ", ") ?? "*"
            var fetchQuery = "SELECT \(columnsToSelect) FROM \(tableName)"
            if let condition = condition {
                fetchQuery += " WHERE \(condition)"
            }
            let statement = try db.prepare(fetchQuery)
            for row in statement {
                var rowData = [String: Any]()
                for (index, name) in statement.columnNames.enumerated() {
                    if let value = row[index] as? String {
                        do {
                            rowData[name] = try decrypt(value)
                        } catch {
                            LoggerHelper.shared.error("❌ Error decrypting value for column '\(name)': \(error.localizedDescription)")
                            rowData[name] = "Decryption Failed"
                        }
                    } else {
                        rowData[name] = row[index]
                    }
                }
                results.append(rowData)
            }
            LoggerHelper.shared.info("✅ Data fetched and decrypted from \(tableName).")
        } catch {
            LoggerHelper.shared.error("❌ Error fetching data from \(tableName): \(error.localizedDescription)")
        }
        return results
    }
    
    /// Deletes records from the specified table, with an optional condition.
    func deleteData(tableName: String, condition: String? = nil) {
        guard let db = db else {
            LoggerHelper.shared.error("❌ Database connection is not initialized.")
            return
        }
        
        do {
            var deleteQuery = "DELETE FROM \(tableName)"
            if let condition = condition {
                deleteQuery += " WHERE \(condition)"
            }
            try db.run(deleteQuery)
            LoggerHelper.shared.info("Deleted records from \(tableName) \(condition != nil ? "with condition: \(condition!)" : "").")
        } catch {
            LoggerHelper.shared.error("❌ Error deleting records from \(tableName): \(error.localizedDescription)")
        }
    }

    // MARK: - Private Methods

    /// Sets up the SQLite database connection.
    private func setupDatabase() {
        guard !dbFilePath.isEmpty else { return }
        
        do {
            db = try Connection(dbFilePath)
            LoggerHelper.shared.info("📁 Database initialized at: \(dbFilePath)")
        } catch {
            LoggerHelper.shared.error("❌ Error initializing database: \(error.localizedDescription)")
        }
    }

    // MARK: - Encryption and Decryption Helpers
    private func encrypt(_ string: String) throws -> String {
        guard let data = string.data(using: .utf8) else { throw EncryptionError.invalidInput }
        guard let keyData = encryptionKey.data(using: .utf8) else { throw EncryptionError.invalidKey }

        let bufferSize = kCCBlockSizeAES128 + data.count + kCCBlockSizeAES128
        var buffer = Data(count: bufferSize)

        var numBytesEncrypted = 0
        let cryptStatus = buffer.withUnsafeMutableBytes { bufferBytes in
            data.withUnsafeBytes { dataBytes in
                keyData.withUnsafeBytes { keyBytes in
                    CCCrypt(
                        CCOperation(kCCEncrypt),
                        CCAlgorithm(kCCAlgorithmAES),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, kCCKeySizeAES128,
                        nil,
                        dataBytes.baseAddress, data.count,
                        bufferBytes.baseAddress, bufferSize,
                        &numBytesEncrypted
                    )
                }
            }
        }

        guard cryptStatus == kCCSuccess else { throw EncryptionError.encryptionFailed }
        buffer.count = numBytesEncrypted
        return buffer.base64EncodedString()
    }

    private func decrypt(_ string: String) throws -> String {
        guard let data = Data(base64Encoded: string) else { throw EncryptionError.invalidInput }
        guard let keyData = encryptionKey.data(using: .utf8) else { throw EncryptionError.invalidKey }

        let bufferSize = data.count + kCCBlockSizeAES128
        var buffer = Data(count: bufferSize)

        var numBytesDecrypted = 0
        let cryptStatus = buffer.withUnsafeMutableBytes { bufferBytes in
            data.withUnsafeBytes { dataBytes in
                keyData.withUnsafeBytes { keyBytes in
                    CCCrypt(
                        CCOperation(kCCDecrypt),
                        CCAlgorithm(kCCAlgorithmAES),
                        CCOptions(kCCOptionPKCS7Padding),
                        keyBytes.baseAddress, kCCKeySizeAES128,
                        nil,
                        dataBytes.baseAddress, data.count,
                        bufferBytes.baseAddress, bufferSize,
                        &numBytesDecrypted
                    )
                }
            }
        }

        guard cryptStatus == kCCSuccess else { throw EncryptionError.decryptionFailed }
        buffer.count = numBytesDecrypted
        return String(data: buffer, encoding: .utf8) ?? ""
    }
}

// MARK: - Encryption Error
enum EncryptionError: Error {
    case invalidInput
    case invalidKey
    case encryptionFailed
    case decryptionFailed
}
