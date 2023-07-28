//
//  SettingsPage.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/9/3.
//

import SwiftUI

//extension String {
//func localized(lang: String) ->String {
//    var translatedLang = ""
//    if lang == "zh" {
//        translatedLang = "zh-Hant"
//    } else {
//        translatedLang = lang
//    }
//
//    let path = Bundle.main.path(forResource: translatedLang, ofType: "lproj")
//    let bundle = Bundle(path: path!)
//
//    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//}}

struct SettingsPage: View {
    @EnvironmentObject var settings: UserSettings
    @AppStorage("selectedLanguage") private var selectedLanguage = Locale.current.languageCode == "zh" ? "zh-Hant" : "en"
    let languages = ["zh-Hant": "中文", "en": "English"]
    
    var body: some View {
        VStack {
            HStack {
                Text("語言", bundle: settings.bundle)
                    .offset(x: 20)
                Spacer()
                Menu {
                    Picker(selection: $selectedLanguage, label: Text("語言")) {
                        ForEach(languages.sorted(by: >), id: \.key) { key, value in
                            Text(value)
                        }
                    }
                } label: {
                    Text("\(languages[selectedLanguage] ?? "")")
                }
                .foregroundColor(.orange)
                .offset(x: -20)
            }
            .frame(width: UIScreen.main.bounds.width - 20, height: 40)
            .background(Color("BottomSheetContainerViewBackground"))
            .cornerRadius(10)
            Spacer()
        }
        .offset(y: 10)
        .navigationBarTitle("設定", displayMode: .inline)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
            .environmentObject(UserSettings())
    }
}
