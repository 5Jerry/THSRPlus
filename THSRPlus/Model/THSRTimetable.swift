//
//  THSRTimetable.swift
//  THSRTimetable
//
//  Created by jerry cho on 2020/8/22.
//

import CryptoKit
import Foundation

struct THSRTimetable {
    
    let authorization: String
    let xdate: String
    var railODDailyTimetable: [RailODDailyTimetable] = []
    var railDailyTimetable: [RailDailyTimetable] = [RailDailyTimetable(DailyTrainInfo: RailDailyTrainInfo(TrainNo: "", Direction: 0, StartingStationName: NameType(Zh_tw: "", En: ""), EndingStationName: NameType(Zh_tw: "", En: "")), StopTimes: [])]
    
    init() {
        func getTimeString() -> String {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
            dateFormater.locale = Locale(identifier: "en_US")
            dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
            let time = dateFormater.string(from: Date())
            return time
        }
        let appId = "f70ef0aeb70f47d39ba544b9da73bddc"
        let appKey = "wNMfFC0CxxKiBcBA5I2y23ElGsY"
        xdate = getTimeString()
        let signDate = "x-date: \(xdate)"
        let key = SymmetricKey(data: Data(appKey.utf8))
        let hmac = HMAC<SHA256>.authenticationCode(for: Data(signDate.utf8), using: key)
        let base64HmacString = Data(hmac).base64EncodedString()
        authorization = """
        hmac username="\(appId)", algorithm="hmac-sha256", headers="x-date", signature="\(base64HmacString)"
        """
    }

    func timetableBetweenStations(originStop: String, destinationStop: String, fullDate: String, completion: @escaping ([RailODDailyTimetable]) -> Void) {
        var resultData: [RailODDailyTimetable] = []
        let fullDateArray = fullDate.components(separatedBy: " ")
        let date = fullDateArray[0]
        let time = fullDateArray[1]

        let queryItems = [URLQueryItem(name: "$filter", value: "(OriginStopTime/DepartureTime) ge '\(time)'"), URLQueryItem(name: "$orderby", value: "OriginStopTime/DepartureTime"), URLQueryItem(name: "$format", value: "JSON")]

        var urlComps = URLComponents(string: "https://ptx.transportdata.tw/MOTC/v2/Rail/THSR/DailyTimetable/OD/\(originStop)/to/\(destinationStop)/\(date)")!
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        var request = URLRequest(url: url)
        request.setValue(xdate, forHTTPHeaderField: "x-date")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if resultData == data {
//                let content = String(data: data!, encoding: .utf8) ?? ""
//                print(content)
//            }

            guard let rawData = data else {
                fatalError("Couldn't get the raw data.")
            }

            do {
                let decoder = JSONDecoder()
                resultData = try decoder.decode([RailODDailyTimetable].self, from: rawData)
                completion(resultData)
                // print("Got raw data \(String(describing: resultData))")
            } catch {
                fatalError("There is an error: \(error)")
            }
        }.resume()
    }
    
    func trainNoTimetable(trainNo: String, fullDate: String, completion: @escaping ([RailDailyTimetable]) -> Void) {
        var resultData: [RailDailyTimetable] = []
        let fullDateArray = fullDate.components(separatedBy: " ")
        let date = fullDateArray[0]

        let queryItems = [URLQueryItem(name: "$format", value: "JSON")]

        var urlComps = URLComponents(string: "https://ptx.transportdata.tw/MOTC/v2/Rail/THSR/DailyTimetable/TrainNo/\(trainNo)/TrainDate/\(date)")!
        
        
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        var request = URLRequest(url: url)
        request.setValue(xdate, forHTTPHeaderField: "x-date")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if resultData == data {
//                let content = String(data: data!, encoding: .utf8) ?? ""
//                print(content)
//            }

            guard let rawData = data else {
                fatalError("Couldn't get the raw data.")
            }

            do {
                let decoder = JSONDecoder()
                resultData = try decoder.decode([RailDailyTimetable].self, from: rawData)
                completion(resultData)
                print("Got raw data \(String(describing: resultData))")
            } catch {
                fatalError("There is an error: \(error)")
            }
        }.resume()
    }
}
