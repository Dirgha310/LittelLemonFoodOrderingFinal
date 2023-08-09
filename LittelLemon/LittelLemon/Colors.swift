//
//  Color.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import Foundation
import SwiftUI

class Colors {
    let PrimaryLight = Color("71807B")
    let Primary = Color("495E57")
    let Secondary = Color("F4CE14")
    let Tertiary = Color("EE9972")
    let TertiaryLight = Color("FBDABB")
    let GrayLight = Color("AFAFAF")
    let Gray = Color("AFAFAF")
    let GrayTransparent = Color("9AAFAFAF")
    let White = Color("FFFFFF")
    let WhiteTransparent = Color("A6FFFFFF")
    let Black = Color("333333")
    let DarkGray = Color("444444")
}

extension Color {
    init(_ hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        
        scanner.currentIndex = hex.startIndex
        
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xff) / 255.0
        let g = Double((rgb >> 8) & 0xff) / 255.0
        let b = Double((rgb >> 0) & 0xff) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
