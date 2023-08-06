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
    
    private func testPrint() {
        getTimetable.testPrint()
    }
    
    var body: some View {
        ZStack {
            VStack {
//                Text("getTimetable.connected: \(getTimetable.connected ? "Connected" : "not connected")")
                if (getTimetable.isLoading) {
                    ProgressView()
                } else {
                    if (getTimetable.timetableInfoError == .noError) {
                        VStack {
                            Text("\(getTimetable.stationIdToStationName[originStop]!) → \(getTimetable.stationIdToStationName[destinationStop]!)")
                                .padding(.top)
                            isDeparture ? Text("\(NSLocalizedString("出發時間", comment: "")): \(fullDate)") : Text("\(NSLocalizedString("抵達時間", comment: "")): \(fullDate)")
                        }
                        
                        if (getTimetable.railODDailyTimetable.count == 0) {
                            Text("沒有符合的車次，請調整搜尋條件後再搜尋").multilineTextAlignment(.center)
                            .navigationTitle("搜尋結果")
                            .navigationBarTitleDisplayMode(.inline)
                        } else {
                            VStack {
                                ZStack {
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(width: UIScreen.screenWidth, height: 30)
                                    HStack {
                                        GeometryReader { geometry in
                                            Text("車次")
                                                .position(x: geometry.size.width * 0.1, y: 15)
                                            Text("出發時間簡寫")
                                                .position(x: geometry.size.width * 0.35, y: 15)
                                            Text("抵達時間簡寫")
                                                .position(x: geometry.size.width * 0.65, y: 15)
                                            Text("行車時間")
                                                .position(x: geometry.size.width * 0.9, y: 15)
                                        }
                                    }
                                    .frame(width: UIScreen.screenWidth - 30, height: 30)
                                }
                                
                                List {
                                        ForEach(getTimetable.railODDailyTimetable) { timetable in
                                            ZStack {
                                                ResultRow(timetable: timetable)
                                                NavigationLink(
                                                    destination: TimetableDetail(trainNo: timetable.DailyTrainInfo.TrainNo, fullDate: fullDate, originStop: originStop, destinationStop: destinationStop)
                                                ) {
                                                    EmptyView()
                                                }
                                                .frame(width: UIScreen.screenWidth - 30)
                                            }
                                        }
//                                    }
                                }
                            }
                            .navigationBarTitle("搜尋結果")
                            .navigationBarTitleDisplayMode(.inline)
                            .listStyle(.plain)
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
                        // .onAppear {
                        //     check Internet connection on appear, not when initializing
                        // }
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
                               action: { getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
                            }
                        )
                        .navigationTitle("搜尋結果")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            //.onAppear(perform: testPrint)
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
