//
//  THSRPlusApp.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/6.
//

import SwiftUI
import PartialSheet

@main
struct THSRPlusApp: App {
    @StateObject var userSettings = UserSettings()
    let sheetManager: PartialSheetManager = PartialSheetManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(getTimetable: GetTimetable())
                .environmentObject(sheetManager)
                .environmentObject(userSettings)
        }
    }
}
