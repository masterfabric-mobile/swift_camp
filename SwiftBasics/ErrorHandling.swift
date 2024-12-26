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
