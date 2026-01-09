//
//  LoginView.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import SwiftUI
import APIManager
import ValidationManager

struct LoginView: View {
    @EnvironmentObject var appRootManager: AppRootManager
    @StateObject private var viewModel = LoginVM()
    @State private var isEmailValid = true
    @State private var username = "yogeshwh@yopmail.com"
    //    @State private var username = "Prabwh@yopmail.com"
    @State private var password = "Test@1234"
    let emailValidator = EmailValidator()


    var body: some View {
        VStack {
            Text("Login")
                .font(.system(size: 36.0).bold())
                .contextMenu {
                    Button("Dev") {
                        save(.Dev)
                    }
                    Button("UAT") {
                        save(.UAT)
                    }
                    Button("Prod") {
                        save(.Prod)
                    }
                }
            Spacer()
            TextField("Username", text: $username)
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading,.trailing],10)
                .onChange(of: username) { _, newValue in
                    isEmailValid = newValue.isEmpty
                        ? true
                        : emailValidator.isValid(email: newValue)
                }
            if !isEmailValid {
                Text("Please enter a valid email address")
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.leading, 10)
            }
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.leading,.trailing],10)
            
            // Login button
            AsyncActionButton {
                Task {
                    await viewModel.callLoginApi(email: username, password: password)
                    if viewModel.loginData != nil && viewModel.loginData?.statusCode == nil {
                        appRootManager.push(.Verification)
                    }
                }
            } label: {
                Text("Login Press")
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 44)
            .disabled(!isEmailValid || username.isEmpty)
            .opacity(isEmailValid && !username.isEmpty ? 1 : 0.5)
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            
            // Forgot password
            AsyncActionButton {
                appRootManager.push(.ForgotPassword)
            } label: {
                Text("Forgot Password")
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 44)
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            
            Spacer()
        }
        .navigationDestination(for: Route.self) { route in
            if route == .Verification {
                VerifyView(viewModel: VerifyVM(temporaryToken: viewModel.loginData?.temporaryToken ?? ""))
            }
            else if route == .ForgotPassword {
                ForgotPassword()
            }
            else if route == .ResetPassword {
                ResetPasswordView()
            }
        }
    }
    
    func save(_ type: UserType) {
        DefaultStore.save(type)
    }
    
    
}




#Preview {
    LoginView()
}
