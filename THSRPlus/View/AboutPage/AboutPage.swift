//
//  AboutPage.swift
//  THSRPlus
//
//  Created by Train Jerry on 2022/3/6.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        VStack {
            Text("本應用程式之資料由\nTDX運輸資料流通服務平臺提供").multilineTextAlignment(.center)
            Text("\n聲明：本應用程式之資料僅供參考\n一切資料請以臺灣高鐵提供的為主").multilineTextAlignment(.center)
            Text("\n若有任何疑問\n請透過App Store的開發者網站聯絡").multilineTextAlignment(.center)
            Image("Icon")
            Text("\(NSLocalizedString("版本", comment: "")) \((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)")
        }
        .navigationBarTitle("關於", displayMode: .inline)
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
