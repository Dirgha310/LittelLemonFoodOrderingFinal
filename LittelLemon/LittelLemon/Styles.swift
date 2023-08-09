//
//  Styles.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import SwiftUI

struct ButtonStyle1: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(Colors().Black)
            .background(
                configuration.isPressed ? Colors().Secondary.opacity(0.8) : Colors().Secondary
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                Colors().Tertiary, lineWidth: 1)
            )
    }
}

struct ButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(Colors().White)
            .background(
                configuration.isPressed ? Colors().Primary.opacity(0.8) : Colors().Primary
            )
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                Colors().Primary, lineWidth: 1)
            )
    }
}

struct ButtonStyle3: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(Colors().GrayLight)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
            .stroke(
                Colors().Primary, lineWidth: 1)
            )
    }
}
