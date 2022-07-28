//
//  NanoChallenge2App.swift
//  NanoChallenge2
//
//  Created by anggidast on 25/07/22.
//

import SwiftUI

@main
struct NanoChallenge2App: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
