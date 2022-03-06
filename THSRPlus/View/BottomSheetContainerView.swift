//
//  BottomSheetContainerView.swift
//  THSRPlus
//
//  Created by Train Jerry on 2022/2/21.
//

import SwiftUI

struct BottomSheetContainerView<Content: View>: View {
    var height: Double
    @Binding var showBottomView: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            content
                .frame(width: UIScreen.main.bounds.width, height: height)
            .background(Color("BottomSheetContainerViewBackground"))
            Button(action: {
                showBottomView = false
            }, label: {
                Image(systemName: "xmark.circle.fill")
            })
        }
    }
}

struct BottomSheetContainerView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContainerView(height: 200, showBottomView: .constant(true)) {
            Text("Hi")
        }
    }
}
