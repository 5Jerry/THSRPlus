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
    
    var body: some View {
        HStack(spacing: 35) {
            VStack(spacing: 0) {
                Rectangle().fill(isFirst ? Color.black.opacity(0.0) : (direction == 0 ? Color.green : Color.blue)).frame(width: 6, height: 25)
                ZStack {
                    Circle().fill(Color.orange).frame(width: 20, height: 20)
                    Circle().fill(Color.white).frame(width: 10, height: 10)
                }
                Rectangle().fill(isLast ? Color.black.opacity(0.0) : direction == 0 ? Color.green : Color.blue).frame(width: 6, height: 25)
            }
            Spacer().frame(width: 0)
            Text(timetable.StationName.Zh_tw)
            // Spacer()
            Text(timetable.ArrivalTime ?? "--")
            // Spacer()
            Text(timetable.DepartureTime)
            // Spacer()
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(timetable: RailStopTime(StationID: "1000", StationName: NameType(Zh_tw: "台北", En: "Taipei"), ArrivalTime: "18:00", DepartureTime: "18:05"), direction: 0, isFirst: false, isLast: false).preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
