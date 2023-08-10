//
//  TimetableDetail.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/15.
//

import SwiftUI

struct TimetableDetail: View {
    @StateObject var getTimetable = GetTimetable()
    @State private var showFares = false
    var trainNo: String
    var fullDate: String
    var originStop: String
    var destinationStop: String
    
    var body: some View {
         ZStack {
            switch getTimetable.timetableInfoStatus {
            case .loading:
                ProgressView()
            case .noError:
                VStack {
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
                }
            case .canNotProcessData:
                VStack {
                    Text("無法處理資料，請稍候重新載入").multilineTextAlignment(.center)
                    Button("重新載入",
                           action: {
                        Task {
                            await getTimetable.getTrainNoTimetable(trainNo: trainNo, fullDate: fullDate)
                            }
                        }
                    )
                }
            case .noDataAvailable:
                EmptyView()
            case .invalidToken:
                EmptyView()
            }
        }
        .navigationBarTitle("停靠車站")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        showFares.toggle()
                    }
                     }) {
                        Text("票價")
                }
                .opacity(getTimetable.timetableInfoStatus == .noError ? 1 : 0)
            }
        }
        .sheet(isPresented: $showFares) {
            FaresPage(originStop: originStop, destinationStop: destinationStop)
                .presentationDetents([.height(400)])
                .presentationDragIndicator(.visible)
        }
        .onFirstAppear {
            Task {
                await getTimetable.getTrainNoTimetable(trainNo: trainNo, fullDate: fullDate)
            }
        }
    }
}

struct TimetableDetail_Previews: PreviewProvider {
    static var previews: some View {
        TimetableDetail(trainNo: "1307", fullDate: "2023-08-12 06:58", originStop: "1000", destinationStop: "1070")
    }
}
