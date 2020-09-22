//
//  DetailRow.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/15.
//

import SwiftUI

struct DetailRow: View {
    var timetable: RailStopTime
    var direction: Int
    var isFirst: Bool
    var isLast: Bool
    var originStop: String
    var destinationStop: String
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Rectangle().fill(isFirst ? Color.black.opacity(0.0) : (direction == 0 ? Color.green : Color.blue)).frame(width: 6, height: 25)
                ZStack {
                    Circle().fill(Color.orange).frame(width: 20, height: 20)
                    originStop == timetable.StationID ? Circle().fill(Color.white.opacity(0.0)).frame(width: 10, height: 10) : (destinationStop == timetable.StationID ? (direction == 0 ? Circle().fill(Color.green).frame(width: 10, height: 10) : Circle().fill(Color.blue).frame(width: 10, height: 10)) :  Circle().fill(Color.white).frame(width: 10, height: 10))
                }
                Rectangle().fill(isLast ? Color.black.opacity(0.0) : direction == 0 ? Color.green : Color.blue).frame(width: 6, height: 25)
            }.frame(minWidth: 0, maxWidth: .infinity)
            Text(timetable.StationName.Zh_tw).frame(minWidth: 0, maxWidth: .infinity)
            Text(timetable.ArrivalTime ?? "--").frame(minWidth: 0, maxWidth: .infinity)
            Text(timetable.DepartureTime).frame(minWidth: 0, maxWidth: .infinity)
            Spacer().frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(timetable: RailStopTime(StationID: "1000", StationName: NameType(Zh_tw: "台北", En: "Taipei"), ArrivalTime: "18:00", DepartureTime: "18:05"), direction: 0, isFirst: false, isLast: false, originStop: "1000", destinationStop: "1070")
            .preferredColorScheme(.dark)
            // .previewLayout(.sizeThatFits)
    }
}
