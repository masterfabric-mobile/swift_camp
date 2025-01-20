import Foundation

// 1. Define Error Types
enum TransactionError: Error {
    case insufficientFunds(amountRequired: Double)
    case invalidAccount
    case networkError
    case transactionLimitExceeded(limit: Double)
    case unknownError
}

// 2. Throwing Errors
func processTransaction(
    amount: Double, accountValid: Bool, hasFunds: Bool, transactionLimit: Double
) throws {
    if !accountValid {
        throw TransactionError.invalidAccount
    }

    if !hasFunds {
        throw TransactionError.insufficientFunds(amountRequired: amount)
    }

    if amount > transactionLimit {
        throw TransactionError.transactionLimitExceeded(limit: transactionLimit)
    }

    // Simulate a network error
    if amount > 1000 {
        throw TransactionError.networkError
    }

    print("Transaction of \(amount) processed successfully.")
}

// 3. Error Handling with Do-Catch Blocks
func makeTransaction(amount: Double, accountValid: Bool, hasFunds: Bool, transactionLimit: Double) {
    do {
        try processTransaction(
            amount: amount, accountValid: accountValid, hasFunds: hasFunds,
            transactionLimit: transactionLimit)
    } catch TransactionError.invalidAccount {
        print("Error: Invalid account.")
    } catch TransactionError.insufficientFunds(let amountRequired) {
        print("Error: Insufficient funds. You need \(amountRequired) more.")
    } catch TransactionError.transactionLimitExceeded(let limit) {
        print("Error: Transaction limit exceeded. The limit is \(limit).")
    } catch TransactionError.networkError {
        print("Error: Network error. Please try again later.")
    } catch {
        print("An unknown error occurred.")
    }
}

// 4. Example Usage
makeTransaction(amount: 500, accountValid: true, hasFunds: true, transactionLimit: 1000)
// Output: Transaction of 500 processed successfully.

makeTransaction(amount: 500, accountValid: false, hasFunds: true, transactionLimit: 1000)
// Output: Error: Invalid account.

makeTransaction(amount: 500, accountValid: true, hasFunds: false, transactionLimit: 1000)
// Output: Error: Insufficient funds. You need 500.0 more.

makeTransaction(amount: 1500, accountValid: true, hasFunds: true, transactionLimit: 1000)
// Output: Error: Transaction limit exceeded. The limit is 1000.0.

makeTransaction(amount: 1500, accountValid: true, hasFunds: true, transactionLimit: 2000)
// Output: Error: Network error. Please try again later.

// 5. Throwing Errors from a Function
func fetchTransactionData(transactionId: Int) throws -> String {
    if transactionId == 0 {
        throw TransactionError.networkError
    }
    return "Transaction data for transaction \(transactionId)"
}

// 6. Failable Error Handling with Do-Catch
func retrieveData(transactionId: Int) {
    do {
        let data = try fetchTransactionData(transactionId: transactionId)
        print("Fetched data: \(data)")
    } catch {
        print("Failed to fetch data due to an error: \(error)")
    }
}

retrieveData(transactionId: 123)  // Output: Fetched data: Transaction data for transaction 123
retrieveData(transactionId: 0)  // Output: Failed to fetch data due to an error: networkError


// 7. Optional Binding
let firstPossibleInput : String? = "Hello, World!"
if let unwrappedInput = firstPossibleInput {    // if given input is not nil, unwrap it
    print(unwrappedInput)
} else {
    print("firstPossibleInput is nil")
}

let secondPossibleInput : String? = nil
if let unwrappedInput = secondPossibleInput {   // if given input is nil, print the message
    print(unwrappedInput)
} else {
    print("secondPossibleInput is nil")
}


// 8. Try, Try?, Try!

enum FileError: Error {
    case fileNotFound
    case insufficientPermissions
}

    // function to read file
    // returns file contents if file is found
    // throws error if file is not found or if permissions are insufficient
func readFile(at path: String) throws -> String {
    if path.isEmpty {
        throw FileError.fileNotFound
    }else if path == "restricted" {
        throw FileError.insufficientPermissions
    }
    return "File contents"
}

    // 8.1 Try
do {
    let content = try readFile(at: "example.txt")
    print("File content: \(content)")
} catch FileError.fileNotFound {
    print("Error: File not found.")
} catch FileError.insufficientPermissions {
    print("Error: Insufficient permissions.")
} catch {
    print("Error: \(error)")
}

    // 8.2 Try?
let optionalContent = try? readFile(at: "") // Empty path returns nil
if let content = optionalContent {
    print("File content: \(content)")
} else {
    print("Error: Unable to read file.")
}

    // 8.3 Try!
let guaranteedContent = try! readFile(at: "validPath.txt")  // Force unwrapping
print ("File content: \(guaranteedContent)")    // Be careful! If error occurs, app will crash