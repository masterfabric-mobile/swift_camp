import SwiftUI

struct FocusStateView: View {
    @ObservedObject var presenter: FocusStatePresenter
    @State private var username = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case username
        case password
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Back button with consistent style
                Button(action: presenter.goBack) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
                Text("Login Form")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                        TextField("Username", text: $username)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                              .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(focusedField == .username ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .focused($focusedField, equals: .username)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .password
                            }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        SecureField("Password", text: $password)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(focusedField == .password ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .focused($focusedField, equals: .password)
                            .submitLabel(.done)
                            .onSubmit {
                                focusedField = nil
                            }
                    }
                    .padding(.horizontal)
                }
                
                Button("Clear Fields") {
                    username = ""
                    password = ""
                    focusedField = .username
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Text("Focused Field: \(focusedField == .username ? "Username" : focusedField == .password ? "Password" : "None")")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
        }
    }
}