//
//  AppRootManager.swift
//  Despir
//
//  Created by Prabhjot Singh on 17/12/25.
//

import Foundation
internal import Combine
import SwiftUI

final class AppRootManager: ObservableObject {
  @Published var path = NavigationPath()
  @Published var currentRoot: eAppRoots = .splash
  // For setting rootview.
    enum eAppRoots {
        case splash
        case login
        case mainView
    }

     func push(_ route: Route) {
         path.append(route)
     }

     func pop() {
         path.removeLast()
     }

     func reset() {
         path = NavigationPath()
     }
}
// For push.
enum Route: Hashable {

    case verification
    case ForgotPassword
    case changePassword
    case ResetPassword
    case settings
}
