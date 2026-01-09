//
//  ChangePasswordView.swift
//  Despir
//
//  Created by Prabhjot Singh on 08/01/26.
//

import SwiftUI

struct ChangePasswordView: View {
  
  @EnvironmentObject var appRootManager: AppRootManager
  @StateObject private var viewModel = ChangePasswordVM()
  
    var body: some View {
      VStack {
        Text("Change Password")
            .font(.system(size: 36.0).bold())
            .padding(.bottom,40)
        
        TextField("Old Password", text: $viewModel.oldPassword)
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        TextField("Password", text: $viewModel.password)
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        TextField("Confirm Password", text: $viewModel.confirmPassword)
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.leading,.trailing],10)
        
        // Submit button
        AsyncActionButton {
            Task {
                await viewModel.callChangePasswordApi()
                if viewModel.changePasswordData != nil && viewModel.changePasswordData?.statusCode == nil {
                   
                }
            }
        } label: {
            Text("Submit")
                .frame(maxWidth: .infinity)
        }
        .frame(height: 44)
        .alert(viewModel.isSuccess ? "Success" : "Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
              if viewModel.isSuccess {
                appRootManager.pop()
              }
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        
      }
    }
}

#Preview {
    ChangePasswordView()
}
