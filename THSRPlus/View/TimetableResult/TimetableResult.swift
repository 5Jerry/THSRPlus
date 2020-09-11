//
//  TimetableResult.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/14.
//

import SwiftUI

struct TimetableResult: View {
    var originStop: String
    var destinationStop: String
    var fullDate: String
    var isDepart = true
    var isConnected: TimetableInfoError
    @ObservedObject var getTimetable: GetTimetable
    
    init(originStop: String, destinationStop: String, fullDate: String, isConnected: TimetableInfoError) {
        self.originStop = originStop
        self.destinationStop = destinationStop
        self.fullDate = fullDate
        self.isConnected = isConnected
        self.getTimetable = GetTimetable(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate)
    }
    
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
    
    var body: some View {
        VStack {
//            Text("getTimetable.connected: \(getTimetable.connected ? "Connected" : "not connected")")
//            Text("isConnected: \(isConnected ? "Connected" : "not connected")")
            if (getTimetable.isLoading) {
                ProgressView()
            } else {
                if (getTimetable.timetableInfoError == .noError) {
                    VStack {
                        Text("\(stationIdToStationName[originStop]!) → \(stationIdToStationName[destinationStop]!)")
                        Text("出發時間: \(fullDate)")
                    }
                    if (getTimetable.railODDailyTimetable.count == 0) {
                        Text("getTimetable.railODDailyTimetable: \(getTimetable.railODDailyTimetable)" as String)
                        Text("沒有符合的車次，請調整收尋條件後再搜尋")
                    } else {
                        HStack(spacing: 20) {
                            Text("車次")
                            Text("出發時間")
                            Text("抵達時間")
                            Text("行車時間")
                        }
                        List {
                            ForEach(getTimetable.railODDailyTimetable) { timetable in
                                NavigationLink(
                                    destination: TimetableDetail(trainNo: timetable.DailyTrainInfo.TrainNo, fullDate: fullDate, isConnected: getTimetable.connected)
                                ) {
                                    ResultRow(timetable: timetable)
                                }
                            }
                        }
                    }
                } else {
                    Text("Something went wrong: \(getTimetable.timetableInfoError)" as String)
                    Button("重新載入",
                           action: { getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate)
                        }
                    )
                    .navigationBarTitle("搜尋結果", displayMode: .inline)
                }
            }
        }
    }
}

struct TimetableResult_Previews: PreviewProvider {
    static var previews: some View {
        TimetableResult(originStop: "1000", destinationStop: "1070", fullDate: "2020-09-01", isConnected: TimetableInfoError.noError)
    }
}
