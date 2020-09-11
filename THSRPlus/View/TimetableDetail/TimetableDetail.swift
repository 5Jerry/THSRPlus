//
//  TimetableDetail.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/15.
//

import SwiftUI

struct TimetableDetail: View {
    @ObservedObject var getTimetable: GetTimetable
    var trainNo: String
    var fullDate: String
    var isConnected: TimetableInfoError
    
    init(trainNo: String, fullDate: String, isConnected: TimetableInfoError) {
        self.trainNo = trainNo
        self.fullDate = fullDate
        self.isConnected = isConnected
        self.getTimetable = GetTimetable(trainNo: trainNo, fullDate: fullDate)
    }
    
    var body: some View {
        VStack {
            if (getTimetable.isLoading) {
                ProgressView()
            } else {
                if (getTimetable.timetableInfoError == .noError) {
                    Spacer().frame(height: 10)
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Spacer().frame(width: 23)
                        Text("站名")
                        Spacer().frame(width: 23)
                        Text("抵站時間")
                        Spacer().frame(width: 15)
                        Text("離站時間")
                    }
                    if (getTimetable.timetableInfoError == .canNotProcessData) {
                        Text("Something went wrong: \(getTimetable.timetableInfoError)" as String)
                        Text("railDailyTimetable: \(getTimetable.railDailyTimetable)" as String)
                    }
                    List {
                        ForEach(getTimetable.railDailyTimetable[0].StopTimes) { timetable in
                            DetailRow(timetable: timetable, direction: getTimetable.railDailyTimetable[0].DailyTrainInfo.Direction, isFirst: timetable == getTimetable.railDailyTimetable[0].StopTimes.first ? true : false, isLast: timetable == getTimetable.railDailyTimetable[0].StopTimes.last ? true : false)
                            
                        }
                        .listRowInsets(.init(top: 0, leading: 25, bottom: 0, trailing: 0))
                        .navigationBarTitle("\(getTimetable.railDailyTimetable[0].DailyTrainInfo.TrainNo)  \(getTimetable.railDailyTimetable[0].DailyTrainInfo.StartingStationName.Zh_tw) →  \(getTimetable.railDailyTimetable[0].DailyTrainInfo.EndingStationName.Zh_tw)", displayMode: .inline)
                    }
                } else {
                    Text("Something went wrong: \(getTimetable.timetableInfoError)" as String)
                    Button("重新載入",
                           action: { getTimetable.getTrainNoTimetable(trainNo: trainNo, fullDate: fullDate)
                        }
                    )
                }
            }
        }
    }
}

struct TimetableDetail_Previews: PreviewProvider {
    static var previews: some View {
        TimetableDetail(trainNo: "0841", fullDate: "2020-09-01 06:00", isConnected: TimetableInfoError.noError)
    }
}
