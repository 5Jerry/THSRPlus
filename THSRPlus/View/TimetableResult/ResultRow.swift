//
//  ResultRow.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/14.
//

import SwiftUI

struct ResultRow: View {
    // var timetable: Timetable
    
    var body: some View {
        HStack {
            Spacer()
            Text("657")
            Spacer()
            Text("15:46")
            Text("→")
            Text("16:46")
            Spacer()
            Text("1:00")
            Spacer()
        }
    }
}

struct ResultRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultRow()
            ResultRow()
                .previewDevice("iPod touch (7th generation)")
        }
        .previewLayout(.fixed(width: 285, height: 70))
    }
}
