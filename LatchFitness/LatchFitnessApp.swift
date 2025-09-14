// SwiftUI App entry point that shows RootTabView, light mode default
//  LatchFitnessApp.swift
//  LatchFitness
//
//  Created by Proxy on 9/14/25.
//

import SwiftUI

@main
struct LatchFitnessApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .preferredColorScheme(.light)
        }
    }
}
