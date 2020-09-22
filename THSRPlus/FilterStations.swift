//
//  FilterStations.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/9/9.
//

import SwiftUI

struct FilterStations: View {
    @Binding var originStop: String
    @Binding var destinationStop: String
    @ObservedObject var getTimetable = GetTimetable()
    
    init(originStop: Binding<String>, destinationStop: Binding<String>) {
        _originStop = originStop
        _destinationStop = destinationStop
    }
    
    var body: some View {
        VStack {
            Group {
//                Text("選擇車站")
//                    .font(.headline)
                GeometryReader { geometry in
                    HStack {
                        Picker(selection: $originStop, label: Text("出發")) {
                            ForEach(getTimetable.stationIdToStationName.sorted(by: <), id: \.key) { key, value in
                                Text(value).tag(key)
                            }
                        }
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height, alignment: .center)
                        .clipped()
                        .labelsHidden()
                        
                        Picker(selection: $destinationStop, label: Text("出發")) {
                            ForEach(getTimetable.stationIdToStationName.sorted(by: <), id: \.key) { key, value in
                                Text(value).tag(key)
                            }
                        }
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height, alignment: .center)
                        .clipped()
                        .labelsHidden()
                    }
                }
            }
        }
        .frame(height: 200)
    }
}


struct FilterStations_Previews: PreviewProvider {
    static var previews: some View {
        FilterStations(originStop: .constant("0990"), destinationStop: .constant("1070"))
    }
}
