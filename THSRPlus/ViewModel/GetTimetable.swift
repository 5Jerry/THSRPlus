//
//  GetTimetable.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/22.
//

import SwiftUI

@MainActor
class GetTimetable: ObservableObject {
    
    @Published var railODDailyTimetable = [RailODDailyTimetable]()
    @Published var railDailyTimetable = [RailDailyTimetable]()
    @Published var railODFare = [RailODFare]()
    @Published var timetableInfoStatus = TimetableInfoStatus.loading
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
    }
    
    // Mark: - Access train fare
    
    func getTrainFares(originStop: String, destinationStop: String) async {
        self.timetableInfoStatus = .loading
        
        do {
            self.railODFare = try await timetableInfo.trainFares(originStop: originStop, destinationStop: destinationStop)
            self.timetableInfoStatus = .noError
            if self.railODFare.isEmpty {
                self.timetableInfoStatus = .noDataAvailable
            }
        } catch TimetableInfoStatus.canNotProcessData {
            self.timetableInfoStatus = .canNotProcessData
        } catch {
            self.timetableInfoStatus = .canNotProcessData
        }
    }
}
