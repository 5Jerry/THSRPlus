//
//  GetTimetable.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/22.
//

import SwiftUI
import Combine

class GetTimetable: ObservableObject {
    @Published private var timetableInfo = THSRTimetable()
    
    // Mark: - Access timetable info between stations
    
    var railODDailyTimetable: [RailODDailyTimetable] {
        timetableInfo.railODDailyTimetable
    }
    
    func getTimetableBetweenStations(originStop: String, destinationStop: String, fullDate: String) {
        timetableInfo.timetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate) { (output) in
            DispatchQueue.main.async {
                self.timetableInfo.railODDailyTimetable = output
            }
        }
    }
    
    // Mark: - Access timetable info for train No.
    
    var railDailyTimetable: [RailDailyTimetable] {
        timetableInfo.railDailyTimetable
    }
    
    func getTrainNoTimetable(trainNo: String, fullDate: String) {
        timetableInfo.trainNoTimetable(trainNo: trainNo, fullDate: fullDate) { (output) in
            DispatchQueue.main.async {
                self.timetableInfo.railDailyTimetable = output
            }
        }
    }
}
