//
//  TimetableDetail.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/15.
//

import SwiftUI

struct TimetableDetail: View {
    @ObservedObject var getTimetable: GetTimetable
    @State private var showPopUp = false
    var trainNo: String
    var fullDate: String
    var originStop: String
    var destinationStop: String
    
    init(trainNo: String, fullDate: String, originStop: String, destinationStop: String) {
        self.trainNo = trainNo
        self.fullDate = fullDate
        self.getTimetable = GetTimetable(trainNo: trainNo, fullDate: fullDate)
        self.originStop = originStop
        self.destinationStop = destinationStop
    }
    
    var body: some View {
        ZStack {
            VStack {
                if (getTimetable.isLoading) {
                    ProgressView()
                } else {
                    if (getTimetable.timetableInfoError == .noError && getTimetable.railDailyTimetable.count != 0) {
                        HStack {
                            Text(
                                "\(getTimetable.railDailyTimetable[0].DailyTrainInfo.TrainNo)"
                            ).foregroundColor(.orange)
                            
                            Text("\(NSLocalizedString("\(getTimetable.railDailyTimetable[0].DailyTrainInfo.StartingStationName.Zh_tw)", comment: "")) → \(NSLocalizedString("\(getTimetable.railDailyTimetable[0].DailyTrainInfo.EndingStationName.Zh_tw)", comment: ""))")
                        }.padding(.top)
                        
                        HStack {
                            GeometryReader { geometry in
                                Text("站名")
                                    .position(x: geometry.size.width * 0.25, y: 15)
                                Text("抵站時間簡寫")
                                    .position(x: geometry.size.width * 0.5, y: 15)
                                Text("離站時間簡寫")
                                    .position(x: geometry.size.width * 0.75, y: 15)
                            }
                        }
                        .background(Color.gray)
                        .frame(width: UIScreen.screenWidth, height: 30)
                            
                        List {
                            ForEach(getTimetable.railDailyTimetable[0].StopTimes) { timetable in
                                DetailRow(timetable: timetable, direction: getTimetable.railDailyTimetable[0].DailyTrainInfo.Direction, isFirst: timetable == getTimetable.railDailyTimetable[0].StopTimes.first ? true : false, isLast: timetable == getTimetable.railDailyTimetable[0].StopTimes.last ? true : false, originStop: originStop, destinationStop: destinationStop)
                            }
                            .listRowInsets(EdgeInsets())
                            .frame(width: UIScreen.screenWidth, height: 70)
                        }
                        .navigationTitle(
                            Text("停靠車站")
                        )
                        .listStyle(.plain)
                        //.navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .navigationBarTrailing) {
//                                Button(action: {
//                                    withAnimation {
//                                        showPopUp.toggle()
//                                    }
//                                     }) {
//                                        Text("票價")
//                                }
//                            }
//                        }
//                        .navigationBarItems(trailing:
//                            Button(action: {
//                                withAnimation {
//                                    showPopUp.toggle()
//                                }
//                                 }) {
//                                    Text("票價")
//                            }
//                        )
                    } else {
                        switch getTimetable.timetableInfoError {
                        case .noDataAvailable:
                            Text("無法取得資料，請檢查網路連線後重新載入").multilineTextAlignment(.center)
                        case .canNotProcessData:
                            Text("無法處理資料，請稍候重新載入").multilineTextAlignment(.center)
                        default:
                            Text("發生錯誤，請重新載入").multilineTextAlignment(.center)
                        }
                        
                        Button("重新載入",
                               action: { getTimetable.getTrainNoTimetable(trainNo: trainNo, fullDate: fullDate)
                            }
                        )
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

struct TimetableDetail_Previews: PreviewProvider {
    static var previews: some View {
        TimetableDetail(trainNo: "0841", fullDate: "2020-12-10 10:10", originStop: "1000", destinationStop: "1070")
    }
}
