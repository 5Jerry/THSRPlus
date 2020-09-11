//
//  ContentView.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    @State private var originStop = "0990"
    @State private var destinationStop = "0990"
    @State private var date = Date()
    @State private var isDepart = true
    // @State private var isActive = false
    
    @ObservedObject var getTimetable: GetTimetable
    
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    var body: some View {
        // UITableView.appearance().backgroundColor = .clear
        return GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    // Color.white
                    MainPageBackground(width: geometry.size.width, height: geometry.size.height)
                        
                    // ZStack {
    //                    RoundedRectangle(cornerRadius: 30).fill(Color.black)
    //                    RoundedRectangle(cornerRadius: 30).fill(Color.white).padding(.all, 5.0)
                        // VStack(spacing: 0) {
                            Form {
                                Picker(selection: $originStop, label: Text("出發")) {
                                    Group {
                                        Text("南港").tag("0990")
                                        Text("台北").tag("1000")
                                        Text("板橋").tag("1010")
                                        Text("桃園").tag("1020")
                                        Text("新竹").tag("1030")
                                        Text("苗栗").tag("1035")
                                        Text("台中").tag("1040")
                                        Text("彰化").tag("1043")
                                        Text("雲林").tag("1047")
                                        Text("嘉義").tag("1050")
                                    }
                                    Text("台南").tag("1060")
                                    Text("左營").tag("1070")
                                }
                                // .listRowBackground(Color.green.opacity(0.4))
                                
                                Button("↑↓") {
                                    swap(&originStop, &destinationStop)
                                }
                                // .listRowBackground(Color.green.opacity(0.4))

                                Picker(selection: $destinationStop, label: Text("抵達")) {
                                    Group {
                                        Text("南港").tag("0990")
                                        Text("台北").tag("1000")
                                        Text("板橋").tag("1010")
                                        Text("桃園").tag("1020")
                                        Text("新竹").tag("1030")
                                        Text("苗栗").tag("1035")
                                        Text("台中").tag("1040")
                                        Text("彰化").tag("1043")
                                        Text("雲林").tag("1047")
                                        Text("嘉義").tag("1050")
                                    }
                                    Text("台南").tag("1060")
                                    Text("左營").tag("1070")
                                }
                                // .listRowBackground(Color.green.opacity(0.4))
                                
                                DatePicker(selection: $date, in: Date() ... Date().addingTimeInterval(86400 * 28), label: { Text("出發") })
                                    // .listRowBackground(Color.green.opacity(0.4))
                                
                                ZStack {
                                    NavigationLink(destination: TimetableResult(originStop: originStop, destinationStop: destinationStop, fullDate: date2String(date), isConnected: getTimetable.connected)) {
                                        EmptyView()
                                    }
                                    Text("查詢")//.foregroundColor(.black)
                                }
                                // .listRowBackground(Color.green.opacity(0.5))
                            }
                            .background(Color.white)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.45)
//                            .shadow(color: Color.black.opacity(0.3),
//                                    radius: 1,
//                                    x: 3,
//                                    y: 3)
                        // }
                    // }
                    
                    // Rectangle().fill(Color.black).frame(height: geometry.size.height * 0.15)
                    MainPageBackground(width: geometry.size.width, height: geometry.size.height).rotationEffect(.degrees(180))
                    
                }
                .navigationBarTitle("高鐵時刻表", displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsPage()) {
                        Text("設定").foregroundColor(.orange)
                    }
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(getTimetable: GetTimetable(originStop: "", destinationStop: "", fullDate: "2020-10-10 10:10"))
            .preferredColorScheme(.dark)
            
            
            
    }
}
