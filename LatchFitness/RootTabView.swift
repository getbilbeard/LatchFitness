//
//  RootTabView.swift
//  LatchFitness
//
//  Created by Proxy on 9/14/25.
//


//
//  RootTabView.swift
//  LatchFitness
//
//  Created by Proxy on 9/14/25.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            DualFeedTimerView()
                .tabItem {
                    Label("Pump", systemImage: "clock.fill")
                }

            DiaperLogView()
                .tabItem {
                    Label("Diapers", systemImage: "drop.fill")
                }

            MonthCalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}

// Placeholder views so the project compiles. Replace with real screens later.
struct HomeView: View { var body: some View { Text("Home Screen") } }
struct DualFeedTimerView: View { var body: some View { Text("Pump Timer") } }
struct DiaperLogView: View { var body: some View { Text("Diaper Log") } }
struct MonthCalendarView: View { var body: some View { Text("Calendar") } }
struct ProfileView: View { var body: some View { Text("Profile") } }
