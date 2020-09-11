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
        // GeometryReader { geometry in
            ZStack {
                
    //                Path { path in
    //                    let width = min(geometry.size.width, geometry.size.height)
    //                    let height = width * 0.75
    //
    //                    path.move(to: CGPoint(x: width, y: height - 50))
    //                    path.addLine(to: CGPoint(x: 0, y: height - 50))
    //                    path.addLine(to: CGPoint(x: 0, y: height + 150))
    //                    path.addLine(to: CGPoint(x: width, y: height + 150))
    //                }.fill(Color.blue)
                    
                    
                Path { path in
                    // let width = min(geometry.size.width, geometry.size.height)
                    // let height = width * 0.75
                    
                    path.move(to: CGPoint(x: width, y: 0))
                    path.addLine(to: CGPoint(x: width - 100 * (width / 414), y: 0))
                    path.addCurve(to: CGPoint(x: width - 210 * (width / 414), y: 40 * (height / 814)), control1: CGPoint(x: width - 150 * (width / 414), y: 0), control2: CGPoint(x: width - 150 * (width / 414), y: 0))
                    path.addLine(to: CGPoint(x: width - 280 * (width / 414), y: 85 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 200 * (width / 414), y: 85 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 110 * (width / 414), y: 15 * (height / 814)))
                    path.addLine(to: CGPoint(x: width, y: 15 * (height / 814)))
                }
                // .frame(width: geometry.size.width, height: 85 * (geometry.size.height / 814))
                
                Path { path in
                    // let width = min(geometry.size.width, geometry.size.height)
                    // let height = width * 0.75

                    path.move(to: CGPoint(x: width, y: 15 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 230 * (width / 414), y: 15 * (height / 814)))
                    path.addCurve(to: CGPoint(x: width - 360 * (width / 414), y: 40 * (height / 814)), control1: CGPoint(x: width - 330 * (width / 414), y: 15 * (height / 814)), control2: CGPoint(x: width - 330 * (width / 414), y: 10 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 400 * (width / 414), y: 85 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 280 * (width / 414), y: 85 * (height / 814)))
                    path.addLine(to: CGPoint(x: width - 220 * (width / 414), y: 50 * (height / 814)))
                    path.addLine(to: CGPoint(x: width, y: 50 * (height / 814)))
                }
                .fill(Color.orange)
                
                // .frame(width: geometry.size.width, height: 85 * (geometry.size.height / 814))
            }
            // .scaledToFit()
            // .aspectRatio(0.5, contentMode: .fill)
            .frame(width: width, height: 85 * (height / 814))
        // }
    }
}

struct MainPageBackground_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            MainPageBackground(width: geometry.size.width, height: geometry.size.height)
            .previewDevice("iPhone 11 Pro Max")
        }
    }
}
