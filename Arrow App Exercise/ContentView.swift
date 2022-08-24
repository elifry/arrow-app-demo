//
//  ContentView.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/17/22.
//

import SwiftUI

struct ContentView: View {
//    @State private var selectedTab = 0
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "heart")
                    Text("Dashboard")
                }
         
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
