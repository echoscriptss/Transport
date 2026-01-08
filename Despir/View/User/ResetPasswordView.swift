//
//  ResetPasswordView.swift
//  Despir
//
//  Created by Yogesh on 1/7/26.
//
import SwiftUI

struct ResetPasswordView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        
        Text("Reset Password")
            .font(.system(size: 36.0).bold())
            .padding(.bottom,40)
        
        TextField("Please Enter Password", text: $password)
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.bottom],10)
            .padding([.leading,.trailing],10)

        TextField("Confirm Password", text: $confirmPassword)
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding([.bottom],10)
            .padding([.leading,.trailing],10)

    }
}
