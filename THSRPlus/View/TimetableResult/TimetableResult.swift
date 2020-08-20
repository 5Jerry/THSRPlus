//
//  TimetableResult.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/14.
//

import SwiftUI

struct TimetableResult: View {
    
    var body: some View {
        // NavigationView {
            List {
                Text("Timetable page")
    //                    ForEach(userData.landmarks) { landmark in
    //                        if !self.userData.showFavoritesOnly || landmark.isFavorite {
    //                            NavigationLink(
    //                                destination: LandmarkDetail(landmark: landmark)
    //                                    .environmentObject(self.userData)
    //                            ) {
    //                                LandmarkRow(landmark: landmark)
    //                            }
    //                        }
    //                    }
            }
            .navigationBarTitle("搜尋結果", displayMode: .inline)
            // .navigationBarBackButtonHidden(false)
        // }
    }
}

struct TimetableResult_Previews: PreviewProvider {
    static var previews: some View {
        TimetableResult()
    }
}
