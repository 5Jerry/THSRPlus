//
//  MainPageBackground.swift
//  THSRPlus
//
//  Created by jerry cho on 2020/9/10.
//

import SwiftUI

struct MainPageBackground: View {
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
            ZStack {
                Path { path in
                    path.move(to: CGPoint(x: width, y: 15))
                    path.addLine(to: CGPoint(x: width - 100 * (width / 414), y: 15))
                    path.addCurve(to: CGPoint(x: width - 210 * (width / 414), y: 55 * (height / 814)), control1: CGPoint(x: width - 150 * (width / 414), y: 15), control2: CGPoint(x: width - 150 * (width / 414), y: 15))
                    path.addLine(to: CGPoint(x: width - 280 * (width / 414), y: 100 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 200 * (width / 414), y: 100 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 110 * (width / 414), y: 30 * (height / 814)))
                    path.addLine(to: CGPoint(x: width, y: 30 * (height / 814)))
                }
                .fill(Color.gray.opacity(0.5))
                
                Path { path in
                    path.move(to: CGPoint(x: width, y: 30 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 230 * (width / 414), y: 30 * (height / 814)))
                    path.addCurve(to: CGPoint(x: width - 360 * (width / 414), y: 55 * (height / 814)), control1: CGPoint(x: width - 330 * (width / 414), y: 30 * (height / 814)), control2: CGPoint(x: width - 330 * (width / 414), y: 25 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 400 * (width / 414), y: 100 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 280 * (width / 414), y: 100 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 220 * (width / 414), y: 65 * (height / 814)))
                    path.addLine(to: CGPoint(x: width, y: 65 * (height / 814)))
                }
                .fill(Color.orange)
            }
            .frame(width: width, height: 100 * (height / 814))
    }
}

struct MainPageBackground_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            let height: CGFloat = max(geometry.size.width, geometry.size.height)
            let width = height * 0.48
            MainPageBackground(width: width, height: height)
            .previewDevice("iPhone 11 Pro Max")
        }
        
    }
}
