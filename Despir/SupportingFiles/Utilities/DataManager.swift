//
//  DataManager.swift
//  Despir
//
//  Created by Prabhjot Singh on 18/12/25.
//

import Foundation

private enum Defaults: String {
   
    case isUserLoggedIn = "isUserLoggedIn"
    case userToken = "token"
}

final class DataManager {
  
  private static func _set(value: Any?, key: Defaults) {
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }
  
  private static func _get(valueForKay key: Defaults) -> Any? {
    return UserDefaults.standard.value(forKey: key.rawValue)
  }
  
  private static func _delete(valueForKay key: Defaults) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }
  
  static var isUserLoggedIn: Bool? {
      get {
        return _get(valueForKay: .isUserLoggedIn) as? Bool
      }
      set {
          _set(value: newValue, key: .isUserLoggedIn)
      }
  }
  
}
