//
//  ContentView.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    private var manager: UserManager = UserManager()
    @State private var navigateToHomeView: Bool = false
    var body: some View {
        VStack {
            if (manager.isUserLoggedIn()) {
                HomeView().navigationBarHidden(true)
            } else {
                NavigationView {
                    OnBoardingView(
                        onRegisterSucess: {
                            navigateToHomeView = true
                        }
                    ).background(
                        NavigationLink(
                            destination: HomeView(),
                            isActive: $navigateToHomeView,
                            label: { EmptyView() }
                        )
                    )
                    .navigationBarHidden(true)
                }
            }
        }.navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
