//
//  SettingsPage.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/9/3.
//

import SwiftUI

struct SettingsPage: View {
    @State private var isPresented = false
    var body: some View {
        VStack {
            Text("本應用程式之資料由\nPTX公共運輸整合平台流通服務平台提供").multilineTextAlignment(.center)
            Image("PtxLogo").resizable().scaledToFit().frame(maxWidth: 200, minHeight: 0, maxHeight: 100)
            Image("Icon")
//                .onTapGesture(perform: {
//                Alert(title: Text("彩蛋？"), message: Text("感謝支持"), dismissButton: Alert.Button.default(Text("確定")))
//            })
            Text("版本1.0")
        }
        .navigationBarTitle("關於", displayMode: .inline)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
