//
//  FaresPage.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/9/26.
//

import SwiftUI

struct FaresPage: View {
    @StateObject var getTimetable = GetTimetable()
    var originStop: String
    var destinationStop: String
    let widthScale = 0.25
    
    var body: some View {
        VStack {
            switch getTimetable.timetableInfoStatus {
            case .loading:
                ProgressView()
            case .noError:
                GeometryReader { geometry in
                    Group {
                        Text("商務車廂")
                            .bold()
                            .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                            .background(Rectangle().fill(.purple).cornerRadius(4))
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.08)
                        Text("全票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.17)
                        if let business1 = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 1 && fare.CabinClass == 2})?.Price {
                            Text("NT$\(business1)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.17)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.17)
                        }
                        Text("孩童票/敬老票/愛心票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.22)
                        if let business2 = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 9 && fare.CabinClass == 2})?.Price {
                            Text("NT$\(business2)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.22)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.22)
                        }
                        Text("團體票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.27)
                        if let business3 = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 8 && fare.FareClass == 1 && fare.CabinClass == 2})?.Price {
                            Text("NT$\(business3)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.27)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.27)
                        }
                    }
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: geometry.size.width - 10, height: 2)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.315)
                    Group {
                        Text("標準車廂")
                            .bold()
                            .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                            .background(Rectangle().fill(Color(red: 64/255, green: 224/255, blue: 208/255)).cornerRadius(4))
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.38)
                        Text("全票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.465)
                        Text("早鳥9折")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.515)
                        Text("早鳥8折")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.565)
                        Text("早鳥65折")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.615)
                        if let Standard = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 1 && fare.CabinClass == 1})?.Price {
                            Text("NT$\(Standard)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.465)
                            Text("NT$\(Int(Standard * 9 / 10) - Int(Standard * 9 / 10 % 5))")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.515)
                            Text("NT$\(Int(Standard * 8 / 10) - Int(Standard * 8 / 10 % 5))")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.565)
                            Text("NT$\(Int(Standard * 65 / 100) - Int(Standard * 65 / 100 % 5))")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.615)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.465)
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.515)
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.565)
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.615)
                        }
                        Text("孩童票/敬老票/愛心票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.665)
                        if let Standard = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 9 && fare.CabinClass == 1})?.Price {
                            Text("NT$\(Standard)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.665)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.665)
                        }
                        Text("團體票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.715)
                        if let Standard = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 8 && fare.FareClass == 1 && fare.CabinClass == 1})?.Price {
                            Text("NT$\(Standard)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.715)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.715)
                        }
                    }
                    Rectangle()
                        .fill(Color(red: 64/255, green: 224/255, blue: 208/255))
                        .frame(width: geometry.size.width - 10, height: 2)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.76)
                    Group {
                        Text("自由車廂")
                            .bold()
                            .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                            .background(Rectangle().fill(.orange).cornerRadius(4))
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.825)
                        Text("全票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.91)
                        if let nonReserved = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 1 && fare.CabinClass == 3})?.Price {
                            Text("NT$\(nonReserved)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.91)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.91)
                        }
                        Text("孩童票/敬老票/愛心票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.96)
                        if let nonReserved = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 9 && fare.CabinClass == 3})?.Price {
                            Text("NT$\(nonReserved)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.96)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.96)
                        }
                    }
                }
            case .canNotProcessData:
                VStack {
                    Text("無法處理資料，請稍候重新載入").multilineTextAlignment(.center)
                    Button("重新載入",
                           action: {
                        Task {
                            await getTimetable.getTrainFares(originStop: originStop, destinationStop: destinationStop)
                            }
                        }
                    )
                }
            case .invalidToken:
                EmptyView()
            case .noDataAvailable:
                EmptyView()
            }
        }
        .onFirstAppear {
            Task {
                await getTimetable.getTrainFares(originStop: originStop, destinationStop: destinationStop)
            }
        }
    }
}

struct FaresPage_Previews: PreviewProvider {
    static var previews: some View {
        FaresPage(originStop: "1000", destinationStop: "1070")
            .frame(height: 400)
    }
}
