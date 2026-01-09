//
//  ResetPasswordViewModel.swift
//  Despir
//
//  Created by Yogesh on 1/8/26.
//

import APIManager
internal import Combine
import Foundation

class ResetPasswordViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var showAlertOTP: Bool = false
    @Published var isSuccessOTP: Bool = false
    @Published var verifyOTPResponse: VerifyOTPResponseModel?

    
}
