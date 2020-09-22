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
    var originStop: String
    var destinationStop: String
    
    init(trainNo: String, fullDate: String, isConnected: TimetableInfoError, originStop: String, destinationStop: String) {
        self.trainNo = trainNo
        self.fullDate = fullDate
        self.isConnected = isConnected
        self.getTimetable = GetTimetable(trainNo: trainNo, fullDate: fullDate)
        self.originStop = originStop
        self.destinationStop = destinationStop
    }
    
    var body: some View {
        VStack {
            if (getTimetable.isLoading) {
                ProgressView()
            } else {
                if (getTimetable.timetableInfoError == .noError) {
                    List {
                        Section(header:
                            HStack {
                                Spacer()
                                Text("站名")
                                Text("抵站時間")
                                Text("離站時間")
                                Spacer()
                            }
                        ) {
                            ForEach(getTimetable.railDailyTimetable[0].StopTimes) { timetable in
                                DetailRow(timetable: timetable, direction: getTimetable.railDailyTimetable[0].DailyTrainInfo.Direction, isFirst: timetable == getTimetable.railDailyTimetable[0].StopTimes.first ? true : false, isLast: timetable == getTimetable.railDailyTimetable[0].StopTimes.last ? true : false, originStop: originStop, destinationStop: destinationStop)
                            }
                        }
                        .listRowInsets(.init(top: 0, leading: 25, bottom: 0, trailing: 0))
                        .navigationBarTitle("\(getTimetable.railDailyTimetable[0].DailyTrainInfo.TrainNo)  \(getTimetable.railDailyTimetable[0].DailyTrainInfo.StartingStationName.Zh_tw) →  \(getTimetable.railDailyTimetable[0].DailyTrainInfo.EndingStationName.Zh_tw)", displayMode: .inline)
                    }
                } else {
                    switch getTimetable.timetableInfoError {
                    case .noDataAvailable:
                        Text("無法取得資料，請檢查網路連線後重新載入")
                    case .canNotProcessData:
                        Text("無法處理資料，請稍候重新載入")
                    default:
                        Text("發生錯誤，請重新載入")
                    }
                    
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
        TimetableDetail(trainNo: "0841", fullDate: "2020-12-10 10:10", isConnected: TimetableInfoError.noError, originStop: "1000", destinationStop: "1070")
    }
}
