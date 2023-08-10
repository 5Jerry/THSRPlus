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
                            .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.1)
                        Text("全票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.15)
                        if let business1 = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 1 && fare.CabinClass == 2})?.Price {
                            Text("NT$\(business1)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.15)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.15)
                        }
                        Text("孩童/敬老/愛心票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.2)
                        if let business2 = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 9 && fare.CabinClass == 2})?.Price {
                            Text("NT$\(business2)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.2)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.2)
                        }
                        Text("團體票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.25)
                        if let business3 = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 8 && fare.FareClass == 1 && fare.CabinClass == 2})?.Price {
                            Text("NT$\(business3)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.25)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.25)
                        }
                    }
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: geometry.size.width - 10, height: 2)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.3125)
                    Group {
                        Text("標準車廂")
                            .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.375)
                        Text("全票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.425)
                        Text("早鳥9折")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.475)
                        Text("早鳥8折")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.525)
                        Text("早鳥65折")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.575)
                        if let Standard = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 1 && fare.CabinClass == 1})?.Price {
                            Text("NT$\(Standard)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.425)
                            Text("NT$\(Int(Standard * 9 / 10) - Int(Standard * 9 / 10 % 5))")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.475)
                            Text("NT$\(Int(Standard * 8 / 10) - Int(Standard * 8 / 10 % 5))")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.525)
                            Text("NT$\(Int(Standard * 65 / 100) - Int(Standard * 65 / 100 % 5))")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.575)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.425)
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.475)
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.525)
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.575)
                        }
                        Text("孩童/敬老/愛心")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.625)
                        if let Standard = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 9 && fare.CabinClass == 1})?.Price {
                            Text("NT$\(Standard)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.625)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.625)
                        }
                        Text("團體票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.675)
                        if let Standard = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 8 && fare.FareClass == 1 && fare.CabinClass == 1})?.Price {
                            Text("NT$\(Standard)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.675)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.675)
                        }
                    }
                    Rectangle()
                        .fill(Color(red: 64/255, green: 224/255, blue: 208/255))
                        .frame(width: geometry.size.width - 10, height: 2)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.7375)
                    Group {
                        Text("自由車廂")
                            .position(x: geometry.size.width * 0.1, y: geometry.size.height * 0.8)
                        Text("全票")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.85)
                        if let nonReserved = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 1 && fare.CabinClass == 3})?.Price {
                            Text("NT$\(nonReserved)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.85)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.85)
                        }
                        Text("孩童/敬老/愛心")
                            .position(x: geometry.size.width * widthScale, y: geometry.size.height * 0.9)
                        if let nonReserved = getTimetable.railODFare[0].Fares.first(where: { fare in fare.TicketType == 1 && fare.FareClass == 9 && fare.CabinClass == 3})?.Price {
                            Text("NT$\(nonReserved)")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.9)
                        } else {
                            Text("NT$ - ")
                                .position(x: geometry.size.width * (1 - widthScale), y: geometry.size.height * 0.9)
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

//struct BlurView: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
//        return view
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//
//    }
//}

struct FaresPage_Previews: PreviewProvider {
    static var previews: some View {
        FaresPage(originStop: "1000", destinationStop: "1070")
    }
}
