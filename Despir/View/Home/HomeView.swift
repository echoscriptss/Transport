//
//  HomeView.swift
//  Despir
//
//  Created by Prabhjot Singh on 05/01/26.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var appRootManager: AppRootManager

    var body: some View {
      VStack {
        Text("Home Screen")
          .font(.system(size: 36.0).bold())
        Spacer()
        Button {
          DataManager.isUserLoggedIn = false
          appRootManager.currentRoot = .login
          
        } label: {
          Text("Logout")
            
        }
        Spacer()
      }
    }
}

#Preview {
    HomeView()
}
