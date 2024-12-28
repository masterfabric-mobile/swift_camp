func runDeinitializationExamples() {
    // ==================================================
    // HOW DEINITIALIZATION WORKS
    // ==================================================
    class BankAccount {
        let accountNumber: String // Account number property
        var balance: Double // Account balance property
        var accountHolderName: String // Account holder's name property
        var isActive: Bool // Indicates whether the account is active

        init(accountNumber: String, initialDeposit: Double, accountHolderName: String) {
            self.accountNumber = accountNumber // Assign the account number
            self.balance = initialDeposit // Set the initial balance
            self.accountHolderName = accountHolderName // Assign the account holder's name
            self.isActive = true // Account is active by default
            print("Account \(accountNumber) for \(accountHolderName) created with initial balance \(balance)") // Account creation message
        }

        func deposit(amount: Double) {
            guard isActive else {
                print("Cannot deposit. Account \(accountNumber) is inactive.")
                return
            }
            balance += amount // Increase the balance when a deposit is made
            print("Deposited \(amount) into account \(accountNumber). New balance: \(balance)") // Show the updated balance
        }

        func withdraw(amount: Double) {
            guard isActive else {
                print("Cannot withdraw. Account \(accountNumber) is inactive.")
                return
            }
            if amount > balance {
                print("Insufficient funds in account \(accountNumber). Available balance: \(balance)") // Check for insufficient funds
            } else {
                balance -= amount // Decrease the balance when a withdrawal is made
                print("Withdrew \(amount) from account \(accountNumber). New balance: \(balance)") // Show the updated balance
            }
        }

        func deactivateAccount() {
            isActive = false // Deactivate the account
            print("Account \(accountNumber) has been deactivated.") // Deactivation message
        }

        deinit {
            // Deinitializer is called just before the class instance is deallocated
            if isActive {
                print("Warning: Active account \(accountNumber) is being closed.")
            }
            print("Account \(accountNumber) is being closed. Final balance: \(balance).") // Account closure message
        }
    }

    // ==================================================
    // DEINITIALIZERS IN ACTION
    // ==================================================
    print("Creating a bank account...")
    var account: BankAccount? = BankAccount(accountNumber: "12345678", initialDeposit: 500.0, accountHolderName: "John Doe")

    // Performing transactions
    account?.deposit(amount: 300.0) // Deposit money
    account?.withdraw(amount: 100.0) // Withdraw money
    account?.withdraw(amount: 800.0) // Attempt to withdraw more than the balance

    // Deactivating the account and attempting a transaction
    print("\nDeactivating the account...")
    account?.deactivateAccount()
    account?.deposit(amount: 50.0) // Attempt to deposit after deactivation
    account?.withdraw(amount: 50.0) // Attempt to withdraw after deactivation

    // Removing the reference to trigger deinitialization
    print("\nClosing the account...")
    account = nil
}
