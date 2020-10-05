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
    var isDeparture: Bool
    @ObservedObject var getTimetable: GetTimetable
    @State private var showPopUp = false
    
    init(originStop: String, destinationStop: String, fullDate: String,  isDeparture: Bool) {
        self.originStop = originStop
        self.destinationStop = destinationStop
        self.fullDate = fullDate
        self.getTimetable = GetTimetable(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
        self.isDeparture = isDeparture
    }
    
    var body: some View {
        ZStack {
            VStack {
//                Text("getTimetable.connected: \(getTimetable.connected ? "Connected" : "not connected")")
//                Text("isConnected: \(isConnected == .noError ? "Connected" : "not connected")")
                if (getTimetable.isLoading) {
                    ProgressView()
                } else {
                    if (getTimetable.timetableInfoError == .noError) {
                        VStack {
                            Text("\(getTimetable.stationIdToStationName[originStop]!) → \(getTimetable.stationIdToStationName[destinationStop]!)").padding(.top)
                            isDeparture ? Text("出發時間: \(fullDate)") : Text("抵達時間: \(fullDate)")
                        }
                        if (getTimetable.railODDailyTimetable.count == 0) {
                            Text("沒有符合的車次，請調整搜尋條件後再搜尋")
                            .navigationTitle("搜尋結果")
                            .navigationBarTitleDisplayMode(.inline)
                        } else {
                            List {
                                Section(header:
                                    HStack {
                                        Text("車次").font(.system(size: 16)).frame(minWidth: 0, maxWidth: .infinity)
                                        Text("出發時間").font(.system(size: 16)).frame(minWidth: 0, maxWidth: .infinity)
                                        Text("抵達時間").font(.system(size: 16)).frame(minWidth: 0, maxWidth: .infinity)
                                        Text("行車時間").font(.system(size: 16)).frame(minWidth: 0, maxWidth: .infinity)
                                    }
                                ) {
                                    ForEach(getTimetable.railODDailyTimetable) { timetable in
                                            NavigationLink(
                                                destination: TimetableDetail(trainNo: timetable.DailyTrainInfo.TrainNo, fullDate: fullDate, originStop: originStop, destinationStop: destinationStop)
                                            ) {
                                                ResultRow(timetable: timetable)
                                            }
                                    }
                                }
                            }
                            .navigationBarTitle("搜尋結果")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        withAnimation {
                                            showPopUp.toggle()
                                        }
                                         }) {
                                            Text("票價")
                                    }
                                }
                            }
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
                               action: { getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
                            }
                        )
                        .navigationTitle("搜尋結果")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            if showPopUp {
                FaresPage(originStop: originStop, destinationStop: destinationStop, showPopup: $showPopUp)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct TimetableResult_Previews: PreviewProvider {
    static var previews: some View {
        TimetableResult(originStop: "1000", destinationStop: "1070", fullDate: "2020-12-10", isDeparture: true)
    }
}
