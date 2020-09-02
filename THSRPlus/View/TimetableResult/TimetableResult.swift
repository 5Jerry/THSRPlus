//
//  TimetableResult.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/14.
//

import SwiftUI

struct TimetableResult: View {
    // var railODDailyTimetable: [RailODDailyTimetable]
    @ObservedObject var getTimetable: GetTimetable
    var originStop: String
    var destinationStop: String
    var fullDate: String
    var isDepart = true
    // var isActive = false
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("車次")
                Text("出發時間")
                Text("抵達時間")
                Text("行車時間")
            }
            List {
                // Text("Timetable page \(getTimetable.railODDailyTimetable)" as String)
                ForEach(getTimetable.railODDailyTimetable) { timetable in
                    NavigationLink(
                        destination: TimetableDetail(getTimetable: GetTimetable(), trainNo: timetable.DailyTrainInfo.TrainNo, fullDate: fullDate)
                    ) {
                        ResultRow(timetable: timetable)
                    }
                }
            }
            .navigationBarTitle("搜尋結果", displayMode: .inline)
            // .navigationBarBackButtonHidden(false)
        }
        .onAppear {
            getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate)
        }
    }
}

struct TimetableResult_Previews: PreviewProvider {
    static var previews: some View {
        TimetableResult(getTimetable: GetTimetable(), originStop: "1000", destinationStop: "1070", fullDate: "2020-09-01")
    }
}
