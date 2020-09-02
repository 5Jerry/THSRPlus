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
    
    // var getTimetable: GetTimetable
    
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
//                    RoundedRectangle(cornerRadius: 30).fill(Color.black)
//                    RoundedRectangle(cornerRadius: 30).fill(Color.white).padding(.all, 5.0)
                    VStack(spacing: 10) {
                        // HStack {
                            
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
                        
                                
                                
                            Text("→")
                                .multilineTextAlignment(.center)
                        
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
                        
//                                Button(action: {}) {
//                                    Text(destinationStop).foregroundColor(.black)
//                                }
                        
//                            DatePicker(selection: $date, in: ClosedRange<Date> Date()...Date().addTimeInterval(TimeInterval), label: <#T##() -> _#>)
                            DatePicker(selection: $date, label: { Text("出發") })
//                            Button("search") {
////                                 print("\(originStop) \(destinationStop)")
////                                print("Just print something \(date2String(date))")
//                                getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: date2String(date))
//                            }
                        }
                        
                        
                        
                        NavigationLink(destination: TimetableResult(getTimetable: GetTimetable(), originStop: originStop, destinationStop: destinationStop, fullDate: date2String(date))) {
                            Text("查詢").foregroundColor(.orange)
                        }
                        
//                        .simultaneousGesture(TapGesture().onEnded{
//                            print("Hello world!")
//                            getTimetable.getTimetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: date2String(date))
//                        })
                    }
                }
                Spacer(minLength: 30)
                Rectangle().fill(Color.black).frame(minWidth: 0, maxWidth: .infinity).frame(height: 100)
                Rectangle().fill(Color.orange).frame(minWidth: 0, maxWidth: .infinity).frame(height: 150)
            }
            .navigationBarTitle("高鐵時刻表", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
