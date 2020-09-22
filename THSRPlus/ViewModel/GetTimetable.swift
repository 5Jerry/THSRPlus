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
    
    let stationIdToStationName = [
        "0990": "南港",
        "1000": "台北",
        "1010": "板橋",
        "1020": "桃園",
        "1030": "新竹",
        "1035": "苗栗",
        "1040": "台中",
        "1043": "彰化",
        "1047": "雲林",
        "1050": "嘉義",
        "1060": "台南",
        "1070": "左營",
    ]
    
    private func networkMonitor() {
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
    
    init(){}
    
    init(originStop: String, destinationStop: String, fullDate: String, isDeparture: Bool) {
        networkMonitor()
        getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
    }
    
    init(trainNo: String, fullDate: String) {
        networkMonitor()
        getTrainNoTimetable(trainNo: trainNo, fullDate: fullDate)
    }
    
    // Mark: - Access timetable info between stations
    
    func getTimetableBetweenStations(originStop: String, destinationStop: String, fullDate: String, isDeparture: Bool) {
        isLoading = true
        timetableInfo.timetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture) { (output) in
            switch output {
            case .success(let result):
                DispatchQueue.main.async {
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
