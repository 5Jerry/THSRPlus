//
//  ResultRow.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/14.
//

import SwiftUI

struct ResultRow: View {
    var timetable: RailODDailyTimetable
    
    func travelTime(departureTime: String, arrivalTime: String, dateFormat: String = "HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let outputDepartureTime = formatter.date(from: departureTime) ?? Date()
        let outputArrivalTime = formatter.date(from: arrivalTime) ?? Date()
        
        var elapsedTime = outputArrivalTime.timeIntervalSince(outputDepartureTime)
        
        if (outputDepartureTime > outputArrivalTime) {
            elapsedTime = elapsedTime + 86400
        }
        let hours = floor(elapsedTime / 60 / 60)

        // we have to subtract the number of seconds in hours from minutes to get
        // the remaining minutes, rounding down to the nearest minute (in case you
        // want to get seconds down the road)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        
        return "\(Int(hours)):\(String(format: "%02d", Int(minutes)))"
    }
    
    var body: some View {// Discard this page
        GeometryReader { geometry in
            Text(timetable.DailyTrainInfo.TrainNo)
                .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.5)
                .foregroundColor(.orange)
            Text("\(timetable.OriginStopTime.DepartureTime)")
                .position(x: geometry.size.width * 0.35, y: geometry.size.height * 0.5)
            Text("→")
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
            Text(timetable.DestinationStopTime.ArrivalTime ?? "--")
                .position(x: geometry.size.width * 0.65, y: geometry.size.height * 0.5)
            Text("\(travelTime(departureTime: timetable.OriginStopTime.DepartureTime, arrivalTime: timetable.DestinationStopTime.ArrivalTime!))")
                .position(x: geometry.size.width * 0.9, y: geometry.size.height * 0.5)
        }
    }
}

struct ResultRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultRow(timetable: RailODDailyTimetable(DailyTrainInfo: RailDailyTrainInfo(TrainNo: "0837", Direction: 0, StartingStationName: NameType(Zh_tw: "台北", En: "Taipei"), EndingStationName: NameType(Zh_tw: "左營", En: "Zuoying")), OriginStopTime: RailStopTime(StationID: "1000", StationName: NameType(Zh_tw: "台北", En: "Taipei"), ArrivalTime: "17:55", DepartureTime: "18:00"), DestinationStopTime: RailStopTime(StationID: "1070", StationName: NameType(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "19:00", DepartureTime: "19:00")))
                
//            ResultRow(timetable: RailODDailyTimetable(DailyTrainInfo: RailDailyTrainInfo(TrainNo: "1837", Direction: 0, StartingStationName: NameType(Zh_tw: "台北", En: "Taipei"), EndingStationName: NameType(Zh_tw: "左營", En: "Zuoying")), OriginStopTime: RailStopTime(StationID: "1000", StationName: NameType(Zh_tw: "台北", En: "Taipei"), ArrivalTime: "17:55", DepartureTime: "18:00"), DestinationStopTime: RailStopTime(StationID: "1070", StationName: NameType(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "19:00", DepartureTime: "19:00")))
//                .previewDevice("iPod touch (7th generation)")
        }
        //.previewLayout(.sizeThatFits)
    }
}
