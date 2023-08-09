//
//  MenuItemDetailsView.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import SwiftUI

struct MenuItemDetailsView: View {
    @ObservedObject var dish: Dish
    var body: some View {
        VStack(alignment: .leading) {
            Text(
                dish.title ?? "Unknown"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 20
                    )
                ).foregroundColor(Colors().Black)
                .padding(.horizontal, 16)
                
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(dish.dishDescription ?? "No description found")
                        .font(.custom(Fonts().karlaRegularFont, size: 16))
                        .foregroundColor(Colors().DarkGray)
                        .lineLimit(2)
                        .padding(.bottom, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("$\(dish.price ?? "0.0")")
                        .font(.custom(Fonts().karlaRegularFont, size: 18))
                        .foregroundColor(Colors().PrimaryLight)
                }
                if let imageUrl = dish.image {
                    if (imageUrl.isValidUrl()) {
                        if let imageUrl = URL(string: imageUrl) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipped()
                            } placeholder: {
                                Color.gray
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)
            .padding(.leading, 16)
            .padding(.trailing, 8)
            Rectangle()
                .fill(Colors().GrayTransparent.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: 1)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
    }
}

struct MenuItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemDetailsView(dish: Dish())
    }

}
