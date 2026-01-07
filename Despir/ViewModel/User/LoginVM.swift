//
//  LoginVM.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import Foundation
internal import Combine
import APIManager

class LoginVM: ObservableObject {
  
  // MARK: - Variables
  
  @Published var userEmail: String = String()
  @Published var userPassword: String = String()
  @Published var errorMessage: String?
  @Published var showAlert: Bool = false
  @Published var loginData: LoginResponseModel?
  

  
  func callLoginApi() async {
    
    let inputData = LoginInputModel(email: "prabwh@yopmail.com", password: "Test@1234")
        do {
          loginData = try await APIManager.shared.request(url: EndPoint.login.url, methodType: EndPoint.login.httpMethod.rawValue, body: inputData, responseType: LoginResponseModel.self)
          if loginData?.statusCode != nil {
            errorMessage = loginData?.message
            showAlert = true
          }
          print(loginData ?? "")
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
  
}

