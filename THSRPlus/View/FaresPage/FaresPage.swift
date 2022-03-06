//
//  FaresPage.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/9/26.
//

import SwiftUI

struct FaresPage: View {
    var originStop: String
    var destinationStop: String
    @ObservedObject var getTimetable: GetTimetable
    @Binding var showPopup: Bool
    
    init(originStop: String, destinationStop: String, showPopup: Binding<Bool>) {
        self.originStop = originStop
        self.destinationStop = destinationStop
        self.getTimetable = GetTimetable(originStop: originStop, destinationStop: destinationStop)
        self._showPopup = showPopup
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack {
                if (getTimetable.isLoading) {
                    ProgressView()
                } else {
                    if (getTimetable.timetableInfoError == .noError && getTimetable.railODFare.count == 1) {
                        //GeometryReader { geometry in
                            //if (getTimetable.railODFare.count == 1) {
                                ForEach(0..<getTimetable.railODFare[0].Fares.count) { index in
                                    switch getTimetable.railODFare[0].Fares[index].TicketType {
                                    case "標準":
                                        HStack {
                                            Text("標準車廂").frame(minWidth: 0, maxWidth: 100)
                                            Text("\(getTimetable.railODFare[0].Fares[index].Price)").frame(minWidth: 0, maxWidth: 100)
                                        }
                                        HStack {
                                            Text("早鳥9折").frame(minWidth: 0, maxWidth: 100)
                                            Text("\(Int(getTimetable.railODFare[0].Fares[index].Price * 9 / 10) - Int(getTimetable.railODFare[0].Fares[index].Price * 9 / 10 % 5))").frame(minWidth: 0, maxWidth: 100)
                                        }
                                        HStack {
                                            Text("早鳥8折").frame(minWidth: 0, maxWidth: 100)
                                            Text("\(Int(getTimetable.railODFare[0].Fares[index].Price * 8 / 10) - Int(getTimetable.railODFare[0].Fares[index].Price * 8 / 10 % 5))").frame(minWidth: 0, maxWidth: 100)
                                        }
                                        HStack {
                                            Text("早鳥65折").frame(minWidth: 0, maxWidth: 100)
                                            Text("\(Int(getTimetable.railODFare[0].Fares[index].Price * 65 / 100) - Int(getTimetable.railODFare[0].Fares[index].Price * 65 / 100 % 5))").frame(minWidth: 0, maxWidth: 100)
                                        }
                                    case "商務":
                                        HStack {
                                            Text("商務車廂").frame(minWidth: 0, maxWidth: 100)
                                            Text("\(getTimetable.railODFare[0].Fares[index].Price)").frame(minWidth: 0, maxWidth: 100)
                                        }
                                    case "自由":
                                        HStack {
                                            Text("自由車廂").frame(minWidth: 0, maxWidth: 100)
                                            Text("\(getTimetable.railODFare[0].Fares[index].Price)").frame(minWidth: 0, maxWidth: 100)
                                        }
                                    default:
                                        EmptyView()
                                    }
                                }
                            //}
                        //}
                    } else {
                        switch getTimetable.timetableInfoError {
                        case .noDataAvailable:
                            Text("無法取得資料，請檢查網路連線後重新載入").multilineTextAlignment(.center)
                        case .canNotProcessData:
                            Text("無法處理資料，請稍候重新載入").multilineTextAlignment(.center)
                        default:
                            Text("發生錯誤，請重新載入").multilineTextAlignment(.center)
                        }
                        
                        Button("重新載入",
                               action: { getTimetable.getTrainFares(originStop: originStop, destinationStop: destinationStop)
                            }
                        )
                    }
                }
                Button(action: {
                    withAnimation {showPopup.toggle()}
                }) {
                    Text("關閉")
                }
                .padding(.vertical, 10)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(BlurView())
            .cornerRadius(25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.3))
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct FaresPage_Previews: PreviewProvider {
    static var previews: some View {
        FaresPage(originStop: "1000", destinationStop: "1070", showPopup: .constant(true))
    }
}
