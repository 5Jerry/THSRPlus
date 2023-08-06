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

// Train fares
struct RailODFare: Decodable {
    var Fares: [Fare]
}

struct Fare: Decodable {
    var TicketType: Int // this variable is optional, but force unwrap for now // 票種類型 : [1:'一般票(單程票)',2:'來回票',3:'電子票証(悠遊卡/一卡通)',4:'回數票',5:'定期票(30天期)',6:'定期票(60天期)',7:'早鳥票',8:'團體票']
    var FareClass: Int // 費率等級 : [1:'成人',2:'學生',3:'孩童',4:'敬老',5:'愛心',6:'愛心孩童',7:'愛心優待/愛心陪伴',8:'軍警',9:'法優']
    var CabinClass: Int // 費率等級 : [1:'標準座車廂',2:'商務座車廂',3:'自由座車廂']
    var Price: Int // this variable is optional, but force unwrap for now
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

struct TDXToken: Decodable {
    var access_token: String
    var expires_in: Int
    var token_type: String
}

struct News: Decodable {
    var NewsID: String
    var Language: String
    var NewsCategory: String
    var Title: String
    var Description: String
    var NewsUrl: String
    var AttachmentUrlList: [String]
    var StartTime: String
    var EndTime: String
    var PublishTime: String
    var UpdateTime: String
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
