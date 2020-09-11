//
//  THSRPlusApp.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/6.
//

import SwiftUI

@main
struct THSRPlusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(getTimetable: GetTimetable(originStop: "", destinationStop: "", fullDate: "2020-10-10 10:10"))
        }
    }
}
