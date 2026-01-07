//
//  EndPoint.swift
//  Despir
//
//  Created by Prabhjot Singh on 22/12/25.
//

import Foundation

enum EndPoint: Equatable {
  
  case login
  case verifyMfa
  case resendOtpMfa
  
  var endpoint: String {
    switch self {
    case .login:
      return "/auth/login"
    case .verifyMfa:
      return "/auth/verify-mfa"
    case .resendOtpMfa:
      return "/auth/resend-otp"
    }
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .login:
      return .POST
    case .verifyMfa:
      return .POST
    case .resendOtpMfa:
      return .POST
    }
  }
  
  var route: String {
    let baseURL = "https://eyeonitbackend-gybfe4hvc9djerbe.centralus-01.azurewebsites.net" //DEV URL
    return baseURL + endpoint
  }
  
  var url: URL? {
    guard let url = URL(string: route) else {
      return nil
    }
    return url
  }
  
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
