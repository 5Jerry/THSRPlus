//
//  UserSettings.swift
//  THSRPlus
//
//  Created by Train Jerry on 2022/3/6.
//

import SwiftUI

class UserSettings: ObservableObject {
    
    @AppStorage("selectedLanguage") var selectedLanguage = Locale.current.languageCode == "zh" ? "zh-Hant" : "en"

    var bundle: Bundle? {
        let b = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj")!
        return Bundle(path: b)
    }
}
