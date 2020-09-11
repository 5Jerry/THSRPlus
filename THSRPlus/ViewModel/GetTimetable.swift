//
//  GetTimetable.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/22.
//

import SwiftUI
import Combine
import Network

class GetTimetable: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)

    @Published var connected = TimetableInfoError.noError
    private var isConnected = TimetableInfoError.noError
    
    @Published var railODDailyTimetable = [RailODDailyTimetable]()
    @Published var railDailyTimetable = [RailDailyTimetable]()
    @Published var timetableInfoError = TimetableInfoError.noError
    @Published var isLoading = false
    private var timetableInfo = THSRTimetable()
    
    func networkMonitor() {
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            print(path.status)
            if path.status == .satisfied {
                OperationQueue.main.addOperation {
                    self.isConnected = TimetableInfoError.noError
                    self.connected = self.isConnected
                }
            } else {
                OperationQueue.main.addOperation {
                    self.isConnected = TimetableInfoError.noDataAvailable
                    self.connected = self.isConnected
                }
            }
        }
    }
    
    init(originStop: String, destinationStop: String, fullDate: String) {
        networkMonitor()
        getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate)
    }
    
    init(trainNo: String, fullDate: String) {
        networkMonitor()
        getTrainNoTimetable(trainNo: trainNo, fullDate: fullDate)
    }
    
//    var timetableInfoError: TimetableInfoError {
//        timetableInfo.timetableInfoError
//    }
//
//    var isLoading: Bool {
//        timetableInfo.isLoading
//    }
    
    // Mark: - Access timetable info between stations
    
//    var railODDailyTimetable: [RailODDailyTimetable] {
//        timetableInfo.railODDailyTimetable
//    }
    
    func getTimetableBetweenStations(originStop: String, destinationStop: String, fullDate: String) {
        isLoading = true
        timetableInfo.timetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate) { (output) in
            switch output {
            case .success(let result):
                DispatchQueue.main.async {
                    print("This function was executed")
                    self.railODDailyTimetable = result
                    self.timetableInfoError = .noError
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.timetableInfoError = error
                    self.isLoading = false
                }
            }
        }
    }
    
    // Mark: - Access timetable info for train No.
    
//    var railDailyTimetable: [RailDailyTimetable] {
//        timetableInfo.railDailyTimetable
//    }
    
    func getTrainNoTimetable(trainNo: String, fullDate: String) {
        isLoading = true
        timetableInfo.trainNoTimetable(trainNo: trainNo, fullDate: fullDate) { (output) in
            switch output {
            case .success(let result):
                DispatchQueue.main.async {
                    self.railDailyTimetable = result
                    self.timetableInfoError = .noError
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.timetableInfoError = error
                    self.isLoading = false
                }
            }
        }
    }
}
