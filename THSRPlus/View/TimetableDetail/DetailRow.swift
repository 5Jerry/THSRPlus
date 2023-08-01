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
        GeometryReader { geometry in
//            VStack(spacing: 0) {
//            VStack {
                Rectangle().fill(isFirst ? Color.black.opacity(0.0) : (direction == 0 ? Color.green : Color.blue))
                        .frame(width: 6, height: 25)
                        .position(x: geometry.size.width * 0.1, y: 12.5)
                ZStack {
                    Circle().fill(Color.orange)
                        .frame(width: 20, height: 20)
                        .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.5)
                    originStop == timetable.StationID ? Circle().fill(Color.white.opacity(0.0)).frame(width: 10, height: 10).position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.5) : (destinationStop == timetable.StationID ? (direction == 0 ? Circle().fill(Color.green).frame(width: 10, height: 10).position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.5) : Circle().fill(Color.blue).frame(width: 10, height: 10).position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.5)) :  Circle().fill(Color.white).frame(width: 10, height: 10).position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.5))
                }
                Rectangle().fill(isLast ? Color.black.opacity(0.0) : direction == 0 ? Color.green : Color.blue)
                    .frame(width: 6, height: 25)
                    .position(x: geometry.size.width * 0.1, y: 57.5)
//            }
            Text("\(NSLocalizedString("\(timetable.StationName.Zh_tw)", comment: ""))")
                .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.5)
            Text(timetable.ArrivalTime ?? "--")
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
            Text(timetable.DepartureTime)
                .position(x: geometry.size.width * 0.75, y: geometry.size.height * 0.5)
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
