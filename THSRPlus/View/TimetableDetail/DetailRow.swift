//
//  DetailRow.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/8/15.
//

import SwiftUI

struct DetailRow: View {
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Rectangle().fill(Color.blue).frame(width: 6, height: 25)
                ZStack {
                    Circle().fill(Color.orange).frame(width: 20, height: 20)
                    Circle().fill(Color.white).frame(width: 10, height: 10)
                }
                Rectangle().fill(Color.blue).frame(width: 6, height: 25)
            }
            Spacer()
            Text("台北")
            Spacer()
            Text("15:46")
            Spacer()
            Text("16:46")
            Spacer()
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow().preferredColorScheme(.dark).previewLayout(.fixed(width: 285, height: 70))
    }
}
