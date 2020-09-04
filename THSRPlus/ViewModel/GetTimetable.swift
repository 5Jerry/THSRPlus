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
    
    var timetableInfoError: TimetableInfoError {
        timetableInfo.timetableInfoError
    }
    
    var isLoading: Bool {
        timetableInfo.isLoading
    }
    
    // Mark: - Access timetable info between stations
    
    var railODDailyTimetable: [RailODDailyTimetable] {
        timetableInfo.railODDailyTimetable
    }
    
    func getTimetableBetweenStations(originStop: String, destinationStop: String, fullDate: String) {
        timetableInfo.isLoading = true
        timetableInfo.timetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate) { (output) in
            switch output {
            case .success(let result):
                DispatchQueue.main.async {
                    print("This function was executed")
                    self.timetableInfo.railODDailyTimetable = result
                    self.timetableInfo.timetableInfoError = .noError
                    self.timetableInfo.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.timetableInfo.timetableInfoError = error
                    self.timetableInfo.isLoading = false
                }
            }
        }
    }
    
    // Mark: - Access timetable info for train No.
    
    var railDailyTimetable: [RailDailyTimetable] {
        timetableInfo.railDailyTimetable
    }
    
    func getTrainNoTimetable(trainNo: String, fullDate: String) {
        timetableInfo.isLoading = true
        timetableInfo.trainNoTimetable(trainNo: trainNo, fullDate: fullDate) { (output) in
            switch output {
            case .success(let result):
                DispatchQueue.main.async {
                    self.timetableInfo.railDailyTimetable = result
                    self.timetableInfo.timetableInfoError = .noError
                    self.timetableInfo.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.timetableInfo.timetableInfoError = error
                    self.timetableInfo.isLoading = false
                }
            }
        }
    }
}
