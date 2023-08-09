//
//  HomeView.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var navigateToProfileView: Bool = false
    @State private var filterTextValue: String = ""
    @State private var categorySelected: String = "all"
    private let menuViewModel: MenuViewModel = MenuViewModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Toolbar(
                    onProfileAvatarClicked: {
                        navigateToProfileView = true
                    }
                )
                ScrollView {
                    HeroView(filterTextValue: $filterTextValue)
                    FilterContainer { value in
                        categorySelected = value
                    }
                    FetchData(
                        predicate:buildPredicate(),
                        sortDescriptors: buildSortDescriptors()
                    ) { (dishes: [Dish]) in
                        ForEach(dishes, id: \.self) { dish in
                            MenuItemDetailsView(dish: dish)
                        }
                    }
                }.task {
                    await menuViewModel.getMenuData(context: viewContext)
                }
            }.navigationBarHidden(true)
                .background(
                    NavigationLink(
                        destination: ProfileView(),
                        isActive: $navigateToProfileView,
                        label: { EmptyView() }
                    )
                )
        }.navigationBarHidden(true)
    }
    func buildPredicate() -> NSPredicate {
        if filterTextValue == "" {
            if categorySelected != "all" {
                return NSPredicate(format: "category == %@", categorySelected)
            } else {
                return NSPredicate(value: true)
            }
        }
        if (categorySelected == "all") {
            return NSPredicate(format: "title CONTAINS[cd] %@", filterTextValue)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@ AND category == %@", filterTextValue, categorySelected)
        }
    }
    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                 key: "title",
                 ascending: true,
                 selector: #selector(NSString .localizedCaseInsensitiveCompare))
            
        ]
    }
}

private struct Toolbar: View {
    var onProfileAvatarClicked: () -> Void
    var body: some View {
        ZStack(alignment: .trailing) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 50)
                .frame(maxWidth: .infinity)
            Button {
                onProfileAvatarClicked()
            } label: {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
            }.padding(.trailing, 12)
        }.padding(.vertical, 20)
            .frame(maxWidth: .infinity)
    }
}

private struct HeroView: View {
    @Binding var filterTextValue: String
    var body: some View {
        ZStack {
            Colors().Primary
            VStack(alignment: .leading, spacing: 0) {
                Text(
                    NSLocalizedString("title", comment: "")
                ).font(
                    .custom(
                        Fonts().markaziTextRegularFont,
                        size: 48
                    )
                ).foregroundColor(Colors().Secondary)
                Text(
                    NSLocalizedString("location", comment: "")
                ).font(
                    .custom(
                       Fonts().markaziTextRegularFont,
                        size: 36
                    )
                ).foregroundColor(Colors().White)
                HStack(spacing: 0) {
                    Text(
                        NSLocalizedString("description", comment: "")
                    ).font(
                        .custom(
                            Fonts().karlaRegularFont,
                            size: 16
                        )
                    ).foregroundColor(Colors().White)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing, 16)
                    Image("hero")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.bottom, 8)
                VStack {
                    HStack {
                        Image(
                            systemName: "magnifyingglass"
                        ).foregroundColor(.gray)
                            .padding(.trailing, 10)
                        TextField(
                            NSLocalizedString("search_placehloder", comment: "")
                           ,
                            text: $filterTextValue
                        )
                    }.padding()
                }.background(Color.white.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 8)
                    .padding(.bottom, 8)
            }.padding(16)
        }
    }
}

private struct FilterContainer: View {
    let onFilterClicked: (String) -> Void
    var body: some View {
        VStack {
            Text(
                NSLocalizedString("filter_order_for_delivery", comment: "").uppercased()
            ).font(
                .custom(
                    Fonts().karlaRegularFont,
                    size: 24
                )
            )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.horizontal, 16)
            ScrollView(.horizontal) {
                HStack(spacing: 1) {
                    CustomFilter(
                        name: NSLocalizedString("filter_all", comment: "")
                    ) { value in
                        onFilterClicked(value.lowercased())
                    }
                    CustomFilter(
                        name: NSLocalizedString("filter_starters", comment: "")
                    ) { value in
                        onFilterClicked(value.lowercased())
                    }
                    CustomFilter(
                        name: NSLocalizedString("filter_mains", comment: "")
                    ) { value in
                        onFilterClicked(value.lowercased())
                    }
                    CustomFilter(
                        name: NSLocalizedString("filter_desserts", comment: "")
                    ) { value in
                        onFilterClicked(value.lowercased())
                    }
                    CustomFilter(
                        name: NSLocalizedString("filter_sides", comment: "")
                    ) { value in
                        onFilterClicked(value.lowercased())
                    }
                }
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
            Rectangle()
                .fill(Colors().GrayTransparent.opacity(0.5))
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}

private struct CustomFilter: View {
    let name: String
    let onFilterClicked: (String) -> Void

    var body: some View {
        Button(action: {
            onFilterClicked(name)
        }, label: {
            Text(name)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 16
                    )
                )
                .foregroundColor(Colors().Primary)
                .padding()
                .background(Colors().GrayLight)
                .cornerRadius(16)
        })
        .padding(.trailing, 16)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
