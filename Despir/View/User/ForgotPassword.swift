//
//  ForgotPassword.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//

import SwiftUI

struct ForgotPassword: View {
    @State private var email = "yogeshwh@yopmail.com"
    @State private var otp = ""
    @ObservedObject var forgotPasswordViewModel = ForgotPasswordViewModel()
    @EnvironmentObject var appRootManager: AppRootManager

    var body: some View {
        VStack {
            Text(forgotPasswordViewModel.forgotPasswordData == nil ? "Forgot Password" : "Verify OTP")
                .font(.system(size: 36.0).bold())
                .padding(.bottom,40)
            TextField("Please Enter Email", text: $email)
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding([.bottom],10)
                .padding([.leading,.trailing],10)
            
            if forgotPasswordViewModel.forgotPasswordData != nil {
                TextField("Please Enter OTP", text: $otp)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding([.bottom],10)
                    .padding([.leading,.trailing],10)
                Button {
                    //appRootManager.push()
                } label: {
                    Text("Verify OTP")
                }
                
                
            } else {
                Button {
                    Task {
                        await forgotPasswordViewModel.callForgotPasswordApi(email: email)
                        if forgotPasswordViewModel.forgotPasswordData != nil && forgotPasswordViewModel.forgotPasswordData?.statusCode == nil {
                            // navigate here
                        }
                    }
                } label: {
                    Text("Send Verification Code")
                }
                .alert(forgotPasswordViewModel.isSuccess ? "Success" : "Error", isPresented: $forgotPasswordViewModel.showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    
                    Text(forgotPasswordViewModel.isSuccess ? "\(forgotPasswordViewModel.successMessage ?? "")" : "\(forgotPasswordViewModel.errorMessage ?? "")")
                }
        }

            Spacer()
            // add button

        }

    }
}

#Preview {
    ForgotPassword()
}
