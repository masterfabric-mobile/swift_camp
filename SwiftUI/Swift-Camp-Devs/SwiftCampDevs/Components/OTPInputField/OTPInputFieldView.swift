import SwiftUI

struct OTPInputFieldView: View {
    @State private var otp: [String] = Array(repeating: "", count: 4)
    @State private var isError: Bool = false
    @FocusState private var focusedField: Int?
    @State private var errorMessage: String = ""
    var correctOTP: String = "1234"
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(0..<4, id: \.self) { index in
                    TextField("", text: $otp[index])
                        .frame(width: 50, height: 50)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isError ? Color.red : Color.gray, lineWidth: 1)
                        )
                        .focused($focusedField, equals: index)
                        .disabled(!canEditField(at: index))
                        .onChange(of: otp[index]) { newValue in
                            handleInputChange(newValue, at: index)
                        }
                }
            }
            .padding()
            if isError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 5)
            }
        }
        .onAppear {
            focusedField = 0
        }
    }
    
    private func handleInputChange(_ newValue: String, at index: Int) {
        otp[index] = String(newValue.prefix(1))
        if newValue.isEmpty {
            // Silme işlemi
            if index > 0 {
                focusedField = index - 1
                otp[index - 1] = ""
            }
        } else if newValue.count == 1 {
            if index < otp.count - 1 {
                focusedField = index + 1
            } else if index == otp.count - 1 {
                validateOTP()
            }
        }
    }
    
    private func canEditField(at index: Int) -> Bool {
        for i in 0..<index {
            if otp[i].isEmpty {
                return false
            }
        }
        return true
    }
    
    private func validateOTP() {
        let enteredOTP = otp.joined()
        if enteredOTP == correctOTP {
            isError = false
            errorMessage = ""
            print("Correct OTP")
        } else {
            isError = true
            errorMessage = "Incorrect OTP. Please try again."
            resetFields()
        }
    }
    
    private func resetFields() {
        otp = Array(repeating: "", count: 4)
        focusedField = 0
    }
}
#Preview {
    OTPInputFieldView()
}
