//
//  ContentView.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/6.
//

import SwiftUI

struct ContentView: View {
    @State var fromStation = "台北"
    @State var toStation = "台中"
    @State var date = Date()
    @State var isDepart = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30).fill(Color.black)
                    RoundedRectangle(cornerRadius: 30).fill(Color.white).padding(.all, 5.0)
                    VStack(spacing: 10) {
                        HStack {
                            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                                Text(fromStation).foregroundColor(.black)
                            }
                            Text("→")
                            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                                Text(toStation).foregroundColor(.black)
                            }
                        }
    //                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
    //                        Text("\(date) 出發").foregroundColor(.black)
    //                    }
                        DatePicker("", selection: $date).frame(height: 30)
//                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
//                            Text("查詢").foregroundColor(.orange)
//                        }
                        NavigationLink(destination: TimetableResult()) {
                            Text("查詢").foregroundColor(.orange)
                        }
                    }
                }
                Spacer(minLength: 30)
                Rectangle().fill(Color.black).frame(minWidth: 0, maxWidth: .infinity).frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
