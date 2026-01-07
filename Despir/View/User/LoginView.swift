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
  
  var body: some View {
    VStack {
      Text("Login")
        .font(.system(size: 36.0).bold())
      Spacer()
      Button {
          Task {
            await viewModel.callLoginApi()
            if viewModel.loginData != nil && viewModel.loginData?.statusCode == nil {
              appRootManager.push(.verification)
            }
          }
      } label: {
        Text("Login Press")
      }
      .frame(height: 20)
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
    }
  }
}

#Preview {
    LoginView()
}
