//
//  LazyView.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/11/21.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
