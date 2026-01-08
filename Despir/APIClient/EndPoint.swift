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
    case forgotPassword
    case getRoles // Temp for get par in httpmethod
    
    var endpoint: String {
        switch self {
        case .login:
            return "/auth/login"
        case .verifyMfa:
            return "/auth/verify-mfa"
        case .resendOtpMfa:
            return "/auth/resend-otp"
        case .forgotPassword:
            return "/user/forgot_password"
        case .getRoles:
            return "/user/all_roles"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .verifyMfa, .resendOtpMfa, .forgotPassword :
            return .POST
        case .getRoles:
            return .GET
        }
    }
    
    var route: String {
        let baseURL = DefaultStore.load()?.rawValue ?? UserType.Dev.rawValue //DEV URL
        return baseURL + endpoint
    }
    
    var url: URL? {
        guard let url = URL(string: route) else {
            return nil
        }
        return url
    }
}

enum UserType: String, CaseIterable {
    case Dev = "https://eyeonitbackend-gybfe4hvc9djerbe.centralus-01.azurewebsites.net"
    case UAT = "https://eye-on-it-uat-asargaf4b7cqeaf2.centralus-01.azurewebsites.net"
//    case Prod = "https://eyeonit-production-a7g9cmd2deasf2e6.centralus-01.azurewebsites.net"
    case Prod = ""
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
