//
//  TimetableBetweenStationModel.swift
//  THSRTimetable
//
//  Created by jerry cho on 2020/8/22.
//

import Foundation

// Timetable between station
struct RailODDailyTimetable: Decodable, Identifiable {
    var id: String { return DailyTrainInfo.TrainNo }
    var DailyTrainInfo: RailDailyTrainInfo
    var OriginStopTime: RailStopTime
    var DestinationStopTime: RailStopTime
}

// TrainNo timetable
struct RailDailyTimetable: Decodable, Identifiable {
    var id: String { return DailyTrainInfo.TrainNo }
    var DailyTrainInfo: RailDailyTrainInfo
    var StopTimes: [RailStopTime]
}

// Common data types from PTX (all below)
struct RailDailyTrainInfo: Decodable {
    var TrainNo: String
    var Direction: Int
    var StartingStationName: NameType
    var EndingStationName: NameType
}

struct RailStopTime: Decodable, Identifiable {
    var id: String { return StationID }
    var StationID: String
    var StationName: NameType
    var ArrivalTime: String? // this variable is optional
    var DepartureTime: String
}

extension RailStopTime: Equatable {
    static func == (lhs: RailStopTime, rhs: RailStopTime) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.StationID == rhs.StationID &&
            lhs.StationName.En == rhs.StationName.En &&
            lhs.StationName.Zh_tw == rhs.StationName.Zh_tw &&
            lhs.ArrivalTime == rhs.ArrivalTime &&
            lhs.DepartureTime == rhs.DepartureTime
    }
}

struct NameType: Decodable {
    var Zh_tw: String
    var En: String
}
