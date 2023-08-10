//
//  THSRTimetableTDX.swift
//  THSRPlus
//
//  Created by Jerry on 2023/8/2.
//

import Foundation

enum TimetableInfoStatus: Error {
    case noError
    case loading
    case invalidToken
    case noDataAvailable
    case canNotProcessData
}

struct THSRTimetableTDX {
    func getToken() async throws {
        let url = URL(string: "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let clientId = "***REMOVED***"
        let clientSecret = "***REMOVED***"
        let httpBodyData = "grant_type=client_credentials&client_id=\(clientId)&client_secret=\(clientSecret)".data(using: .utf8)
        request.httpBody = httpBodyData
        
        let (data, _) = try await URLSession.shared.data(for: request)

        do {
            let decoder = JSONDecoder()
            let tokenJson = try decoder.decode(TDXToken.self, from: data)
            print("1234 token", tokenJson)
            UserDefaults.standard.set(tokenJson.access_token, forKey: "token")
        } catch {
            throw TimetableInfoStatus.invalidToken
        }
    }
    
    func testTdxApi() async throws -> [News] {
        let url = URL(string: "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/News?%24top=3&%24format=JSON")!
        var request = URLRequest(url: url)
        let loadedToken = UserDefaults.standard.string(forKey: "token") ?? ""
        request.setValue("Bearer \(loadedToken)", forHTTPHeaderField: "authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
            
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            do {
                print("1234 no token")
                try await getToken()
                print("1234 got token")
                return try await testTdxApi()
            } catch {
                throw TimetableInfoStatus.canNotProcessData
            }
        }
//        print("1234 statusCode: \(httpResponse?.statusCode)")
//        print("1234 allHeaderFields: \(httpResponse.allHeaderFields)")
//        print("1234 description: \(httpResponse.description)")
//        print("1234 hashValue: \(httpResponse.hashValue)")
//        print("1234 localizedString: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
            
        do {
            let decoder = JSONDecoder()
            let news = try decoder.decode([News].self, from: data)
            print("1234 news", news)
            return news
        } catch {
            throw TimetableInfoStatus.canNotProcessData
        }
    }
    
    func timetableBetweenStations(originStop: String, destinationStop: String, fullDate: String, isDeparture: Bool) async throws -> [RailODDailyTimetable] {
//        var resultData: [RailODDailyTimetable] = []
        let fullDateArray = fullDate.components(separatedBy: " ")
        let date = fullDateArray[0]
        let time = fullDateArray[1]

        let queryItems = [URLQueryItem(name: "$filter", value: "\(isDeparture ? "(OriginStopTime/DepartureTime) ge '\(time)'" : "(DestinationStopTime/ArrivalTime) ge '\(time)'")"), URLQueryItem(name: "$orderby", value: "\(isDeparture ? "OriginStopTime/DepartureTime" : "DestinationStopTime/ArrivalTime")"), URLQueryItem(name: "$format", value: "JSON")]

        var urlComps = URLComponents(string: "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/DailyTimetable/OD/\(originStop)/to/\(destinationStop)/\(date)")!
        // https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/DailyTimetable/OD/1000/to/1070/2023-08-06?%24top=30&%24format=JSON
        
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        var request = URLRequest(url: url)
        let loadedToken = UserDefaults.standard.string(forKey: "token") ?? ""
        request.setValue("Bearer \(loadedToken)", forHTTPHeaderField: "authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let httpResponse = response as? HTTPURLResponse
        print("1234 statusCode: \(httpResponse?.statusCode ?? 0)")
        print("1234 localizedString: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse?.statusCode ?? 0))")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            do {
                print("1234 no token")
                try await getToken()
                print("1234 got token")
                return try await timetableBetweenStations(originStop: originStop, destinationStop: destinationStop, fullDate: fullDate, isDeparture: isDeparture)
            } catch {
                throw TimetableInfoStatus.canNotProcessData
            }
        }
            
        do {
            let decoder = JSONDecoder()
            let railODDailyTimetable = try decoder.decode([RailODDailyTimetable].self, from: data)
            print("1234 railODDailyTimetable", railODDailyTimetable.count)
            return railODDailyTimetable
        } catch {
            throw TimetableInfoStatus.canNotProcessData
        }
    }
    
    func trainNoTimetable(trainNo: String, fullDate: String) async throws -> [RailDailyTimetable] {
        let fullDateArray = fullDate.components(separatedBy: " ")
        let date = fullDateArray[0]

        let queryItems = [URLQueryItem(name: "$format", value: "JSON")]

        var urlComps = URLComponents(string: "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/DailyTimetable/TrainNo/\(trainNo)/TrainDate/\(date)")!
        // https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/DailyTimetable/TrainNo/0853/TrainDate/2023-08-06?%24top=30&%24format=JSON
        
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        var request = URLRequest(url: url)
        let loadedToken = UserDefaults.standard.string(forKey: "token") ?? ""
        request.setValue("Bearer \(loadedToken)", forHTTPHeaderField: "authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            do {
                print("1234 no token")
                try await getToken()
                print("1234 got token")
                return try await trainNoTimetable(trainNo: trainNo, fullDate: fullDate)
            } catch {
                throw TimetableInfoStatus.canNotProcessData
            }
        }
            
        do {
            let decoder = JSONDecoder()
            let railDailyTimetable = try decoder.decode([RailDailyTimetable].self, from: data)
            print("1234 railDailyTimetable")
            return railDailyTimetable
        } catch {
            throw TimetableInfoStatus.canNotProcessData
        }
    }
    
    func trainFares(originStop: String, destinationStop: String) async throws -> [RailODFare] {
        let queryItems = [URLQueryItem(name: "$format", value: "JSON")]

        var urlComps = URLComponents(string: "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/ODFare/\(originStop)/to/\(destinationStop)")!
        // https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/ODFare/1000/to/1070?%24top=30&%24format=JSON
        
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        var request = URLRequest(url: url)
        let loadedToken = UserDefaults.standard.string(forKey: "token") ?? ""
        request.setValue("Bearer \(loadedToken)", forHTTPHeaderField: "authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            do {
                print("1234 no token")
                try await getToken()
                print("1234 got token")
                return try await trainFares(originStop: originStop, destinationStop: destinationStop)
            } catch {
                throw TimetableInfoStatus.canNotProcessData
            }
        }
            
        do {
            let decoder = JSONDecoder()
            let railODFare = try decoder.decode([RailODFare].self, from: data)
            print("1234 railODFare", railODFare)
            return railODFare
        } catch {
            throw TimetableInfoStatus.canNotProcessData
        }
    }
}
