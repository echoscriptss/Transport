//
//  LoginView.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import SwiftUI



struct LoginView: View {
    @EnvironmentObject var appRootManager: AppRootManager
    @StateObject private var viewModel = LoginVM()
    @State private var username = "yogeshwh@yopmail.com"
    //    @State private var username = "Prabwh@yopmail.com"
    @State private var password = "Test@1234"
    
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
                        appRootManager.push(.verification)
                    }
                }
            } label: {
                Text("Login Press")
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 44)
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
            if route == .verification {
                VerifyView(viewModel: VerifyVM(temporaryToken: viewModel.loginData?.temporaryToken ?? ""))
            }
            else if route == .ForgotPassword {
                ForgotPassword()
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
