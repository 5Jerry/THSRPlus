//
//  ContentView.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/6.
//

import SwiftUI
import PartialSheet

struct ContentView: View {
    @State private var originStop = "1000"
    @State private var destinationStop = "1070"
    @State private var date = Date()
    @State private var isDeparture = true
    @State private var showBottomView = false
    // @State private var isActive = false
    
    @ObservedObject var getTimetable: GetTimetable
    @EnvironmentObject var partialSheetManager : PartialSheetManager
    
    @EnvironmentObject var settings: UserSettings
    
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    var body: some View {
        GeometryReader { geometry in
            let height: CGFloat = max(geometry.size.width, geometry.size.height)
            let width = height * 0.48
            
            ZStack(alignment: .bottom) {
                NavigationView {
                    VStack(spacing: 50) {
                        MainPageBackground(width: geometry.size.width, height: geometry.size.height)
                           
                        VStack(spacing: 10) {
                            HStack {
                                VStack {
                                    Text("出發站")
                                    Spacer().frame(height: height * 0.01)
                                    Button(action: {
                                        withAnimation {
                                            showBottomView.toggle()
                                        }
//                                        self.partialSheetManager.showPartialSheet({
//                                             print("normal sheet dismissed")
//                                        }) {
//                                            FilterStations(originStop: $originStop, destinationStop: $destinationStop)
//                                        }
                                    }, label: {
                                        Text("\(getTimetable.stationIdToStationName[originStop]!)").font(.system(size: 25))
                                            .minimumScaleFactor(0.01)
                                            .lineLimit(1)
                                            .foregroundColor(.orange).frame(width: width * 0.35, height: height * 0.1)
                                            .background(Color.black).cornerRadius(10.0)
                                    })
                                }

                                VStack {
                                    Spacer().frame(height: height * 0.04)
                                    Button(action: {
                                        swap(&originStop, &destinationStop)
                                    }, label: {
                                        Text("←→").foregroundColor(.orange).font(.system(size: 22))
                                    })
                                }

                                VStack {
                                    Text("抵達站")
                                    Spacer().frame(height: height * 0.01)
                                    Button(action: {
                                        withAnimation {
                                            showBottomView.toggle()
                                        }
//                                        self.partialSheetManager.showPartialSheet({
//                                             print("normal sheet dismissed")
//                                        }) {
//                                            FilterStations(originStop: $originStop, destinationStop: $destinationStop)
//                                        }
                                    }, label: {
                                        Text("\(getTimetable.stationIdToStationName[destinationStop]!)")
                                            .font(.system(size: 25))
                                            .minimumScaleFactor(0.01)
                                            .lineLimit(1)
                                            .foregroundColor(.orange).frame(width: width * 0.35, height: height * 0.1)
                                            .background(Color.black).cornerRadius(10.0)
                                    })
                                }
                            }

                            Button(action: {
                                isDeparture = !isDeparture
                            }, label: {
                                VStack {
                                    isDeparture ? Text("出發時間") : Text("抵達時間")
                                }
                                .foregroundColor(.blue).font(.system(size: 22))
                                    .frame(width: width * 0.5, height: height * 0.05)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(20.0)
                            })

                            DatePicker(selection: $date, in: Date().addingTimeInterval(-86400 * 7) ... Date().addingTimeInterval(86400 * 28), label: {
                                EmptyView()
                            }).labelsHidden()

                            NavigationLink(destination: TimetableResult(originStop: originStop, destinationStop: destinationStop, fullDate: date2String(date), isDeparture: isDeparture)) {
                                Text("查詢")
                                    .font(.system(size: 22))
                                    .foregroundColor(.blue)
                                    .frame(width: width * 0.9, height: height * 0.05)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(20.0)
                            }
                        }
                        .frame(width: width, height: height * 0.4)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10.0)

                        MainPageBackground(width: geometry.size.width, height: geometry.size.height).rotationEffect(.degrees(180))

                    }
                    .navigationBarTitle("高鐵時刻表")
                    .navigationBarItems(trailing:
                        HStack {
                            NavigationLink(destination: SettingsPage()) {
                                Text("設定", bundle: settings.bundle).foregroundColor(.orange)
                            }
                            NavigationLink(destination: AboutPage()) {
                                Text("關於").foregroundColor(.orange)
                            }
                        }
                    )
                }
//                .opacity(showBottomView ? 0.4 : 1)
                
                VStack {
                    if showBottomView {
                        Rectangle()
                            .fill(Color.black.opacity(0.4)) // This rectangle has to be filled with color other than clear and the opacity cannot be set to 0, or the on tap gesture will not work
                            .onTapGesture {
                                showBottomView = false
                            }
                        BottomSheetContainerView(height: height * 0.3, showBottomView: $showBottomView) {
                            FilterStations(originStop: $originStop, destinationStop: $destinationStop)
                        }
                            .transition(.move(edge: .bottom))
                    }
                }
                .animation(.easeInOut)
            }
            .ignoresSafeArea(.all, edges: .all)
//            .onAppear {
//                print("1234 locale", Locale.current.languageCode)
//            }
        }
        .addPartialSheet()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(getTimetable: GetTimetable())
            //.previewDevice("iPod touch")
            .preferredColorScheme(.dark)
            .environmentObject(PartialSheetManager())
            .environmentObject(UserSettings())
    }
}
