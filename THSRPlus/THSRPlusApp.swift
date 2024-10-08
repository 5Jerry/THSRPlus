//
//  THSRPlusApp.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/6.
//

import SwiftUI

@main
struct THSRPlusApp: App {
    @StateObject var userSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView(getTimetable: GetTimetable())
                .environmentObject(userSettings)
        }
    }
}
