//
//  GetTimetable.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/22.
//

import SwiftUI
import Combine
import Network

@MainActor
class GetTimetable: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)

//    @Published var connected = TimetableInfoError.noError
//    private var isConnected = TimetableInfoError.noError
    
    @Published var railODDailyTimetable = [RailODDailyTimetable]()
    @Published var railDailyTimetable = [RailDailyTimetable]()
    @Published var railODFare = [RailODFare]()
    @Published var timetableInfoStatus = TimetableInfoStatus.loading
//    private var timetableInfo = THSRTimetable()
    private var timetableInfo = THSRTimetableTDX()
    
    let stationIdToStationName = [
        "0990": NSLocalizedString("南港", comment: ""),
        "1000": NSLocalizedString("台北", comment: ""),
        "1010": NSLocalizedString("板橋", comment: ""),
        "1020": NSLocalizedString("桃園", comment: ""),
        "1030": NSLocalizedString("新竹", comment: ""),
        "1035": NSLocalizedString("苗栗", comment: ""),
        "1040": NSLocalizedString("台中", comment: ""),
        "1043": NSLocalizedString("彰化", comment: ""),
        "1047": NSLocalizedString("雲林", comment: ""),
        "1050": NSLocalizedString("嘉義", comment: ""),
        "1060": NSLocalizedString("台南", comment: ""),
        "1070": NSLocalizedString("左營", comment: ""),
    ]
    
    private func networkMonitor() {
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            print(path.status)
            if path.status == .satisfied {
                OperationQueue.main.addOperation {
                    self.timetableInfoStatus = TimetableInfoStatus.noError
                }
            } else {
                OperationQueue.main.addOperation {
                    self.timetableInfoStatus = TimetableInfoStatus.noDataAvailable
                }
            }
        }
    }
    
//    init(){}
//
//    init(originStop: String, destinationStop: String, fullDate: String, isDeparture: Bool) {
//        networkMonitor()
//        getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
//    }
//
//    init(trainNo: String, fullDate: String) {
//        networkMonitor()
//        getTrainNoTimetable(trainNo: trainNo, fullDate: fullDate)
//    }
    
//    init(originStop: String, destinationStop: String) {
//        networkMonitor()
//        getTrainFares(originStop: originStop, destinationStop: destinationStop)
//    }
    
    // Mark: - Access timetable info between stations
    
    func testPrint() {
        print("testPrint in view model called")
    }
    
    func getTimetableBetweenStations(originStop: String, destinationStop: String, fullDate: String, isDeparture: Bool) async {
        self.timetableInfoStatus = .loading
        
        do {
            self.railODDailyTimetable = try await timetableInfo.timetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
            self.timetableInfoStatus = .noError
            if self.railODDailyTimetable.isEmpty {
                self.timetableInfoStatus = .noDataAvailable
            }
        } catch TimetableInfoStatus.canNotProcessData {
            self.timetableInfoStatus = .canNotProcessData
        } catch {
            self.timetableInfoStatus = .canNotProcessData
        }
        
//        timetableInfo.timetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture) { (output) in
//            switch output {
//            case .success(let result):
//                DispatchQueue.main.async {
//                    self.railODDailyTimetable = result
//                    self.timetableInfoError = .noError
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.timetableInfoError = error
//                }
//            }
//        }
    }
    
    // Mark: - Access timetable info for train No.
    
    func getTrainNoTimetable(trainNo: String, fullDate: String) async {
        self.timetableInfoStatus = .loading
        
        do {
            self.railDailyTimetable = try await timetableInfo.trainNoTimetable(trainNo: trainNo, fullDate: fullDate)
            self.timetableInfoStatus = .noError
            if self.railDailyTimetable.isEmpty {
                self.timetableInfoStatus = .noDataAvailable
            }
        } catch TimetableInfoStatus.canNotProcessData {
            self.timetableInfoStatus = .canNotProcessData
        } catch {
            self.timetableInfoStatus = .canNotProcessData
        }
        
//        timetableInfo.trainNoTimetable(trainNo: trainNo, fullDate: fullDate) { (output) in
//            switch output {
//            case .success(let result):
//                DispatchQueue.main.async {
//                    self.railDailyTimetable = result
//                    self.timetableInfoError = .noError
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.timetableInfoError = error
//                }
//            }
//        }
    }
    
    // Mark: - Access train fare
    
    func getTrainFares(originStop: String, destinationStop: String) async {
        self.timetableInfoStatus = .loading
        
        do {
            self.railODFare = try await timetableInfo.trainFares(originStop: originStop, destinationStop: destinationStop)
            self.timetableInfoStatus = .noError
        } catch TimetableInfoStatus.canNotProcessData {
            self.timetableInfoStatus = .canNotProcessData
        } catch {
            self.timetableInfoStatus = .canNotProcessData
        }
        
//        timetableInfo.trainFares(originStop: originStop, destinationStop: destinationStop) { output in
//            switch output {
//            case .success(let result):
//                DispatchQueue.main.async {
//                    self.railODFare = result
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.timetableInfoError = error
//                }
//            }
//        }
    }
}
