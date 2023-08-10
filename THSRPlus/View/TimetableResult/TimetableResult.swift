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
    @StateObject private var getTimetable = GetTimetable()
    @State private var showFares = false
    
    var body: some View {
        ZStack {
            switch getTimetable.timetableInfoStatus {
            case .loading:
                ProgressView()
            case .noError:
                VStack {
                    VStack {
                        Text("\(getTimetable.stationIdToStationName[originStop]!) → \(getTimetable.stationIdToStationName[destinationStop]!)")
                            .padding(.top)
                        isDeparture ? Text("\(NSLocalizedString("出發時間", comment: "")): \(fullDate)") : Text("\(NSLocalizedString("抵達時間", comment: "")): \(fullDate)")
                    }
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
                    }
                }
            case .noDataAvailable:
                VStack {
                    VStack {
                        Text("\(getTimetable.stationIdToStationName[originStop]!) → \(getTimetable.stationIdToStationName[destinationStop]!)")
                            .padding(.top)
                        isDeparture ? Text("\(NSLocalizedString("出發時間", comment: "")): \(fullDate)") : Text("\(NSLocalizedString("抵達時間", comment: "")): \(fullDate)")
                    }
                    Spacer()
                    Text("沒有符合的車次，請調整搜尋條件後再搜尋").multilineTextAlignment(.center)
                    Spacer()
                }
            case .canNotProcessData:
                VStack {
                    Text("無法處理資料，請稍候重新載入").multilineTextAlignment(.center)
                    Button("重新載入",
                           action: {
                        Task {
                            await getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
                            }
                        }
                    )
                }
            case .invalidToken:
                EmptyView()
            }
        }
        .navigationBarTitle("搜尋結果")
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
                await getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
            }
        }
    }
}

struct TimetableResult_Previews: PreviewProvider {
    static var previews: some View {
        TimetableResult(originStop: "1000", destinationStop: "1070", fullDate: "2023-08-10 09:00", isDeparture: true)
    }
}
