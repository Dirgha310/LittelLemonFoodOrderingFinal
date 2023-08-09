//
//  ProfileView.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var manager: UserManager = UserManager()
    private let menuViewModel: MenuViewModel = MenuViewModel()
    @State private var navigateToHomeView: Bool = false
    @State private var navigateToOnBoardingView: Bool = false
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var isEmailNotificationsOrderStatusChecked: Bool = false
    @State var isEmailNotificationsPasswordChangesChecked: Bool = false
    @State var isEmailNotificationsSpecialOffersChecked: Bool = false
    @State var isEmailNotificationsNewsletterChecked: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    LittleLemonToolbar(
                        onBackButtonClicked: {
                            navigateToHomeView = true
                        }
                    )
                    FormProfileView(
                        firstName: $firstName,
                        lastName: $lastName,
                        email: $email,
                        phoneNumber: $phoneNumber
                    )
                    FormEmailNotifications(
                        isEmailNotificationsOrderStatusChecked: $isEmailNotificationsOrderStatusChecked,
                        isEmailNotificationsPasswordChangesChecked: $isEmailNotificationsPasswordChangesChecked,
                        isEmailNotificationsSpecialOffersChecked: $isEmailNotificationsSpecialOffersChecked,
                        isEmailNotificationsNewsletterChecked: $isEmailNotificationsNewsletterChecked
                    ).padding(.bottom, 8)
                    Button {
                        menuViewModel.deleteAllObjects(viewContext)
                        manager.clear()
                        navigateToOnBoardingView = true
                    } label: {
                        Text(
                            "Logout"
                        ).font(
                            .custom(
                                Fonts().karlaRegularFont,
                                size: 16
                            )
                        ).fontWeight(.bold)
                    }.buttonStyle(
                        ButtonStyle1()
                    ).padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    ExtraButtonsProfileView(
                        onDiscardChangesButtonClicked: {
                            firstName = manager.firstName
                            lastName = manager.lastName
                            email = manager.email
                            phoneNumber = manager.phoneNumber
                            isEmailNotificationsOrderStatusChecked = manager.isEmailNotificationOrderStatusEnabled
                            isEmailNotificationsPasswordChangesChecked = manager.isEmailNotificationPasswordChangesEnabled
                            isEmailNotificationsSpecialOffersChecked = manager.isEmailNotificationSpecialOffersEnabled
                            isEmailNotificationsNewsletterChecked = manager.isEmailNotificationNewsletterEnabled
                            alertTitle = "Profile Restored"
                            alertMessage = "The saved data was restored successfully"
                            showAlert.toggle()
                        },
                        onSaveChangesButtonClicked: {
                            if (
                                !firstName.isEmpty &&
                                !lastName.isEmpty &&
                                !email.isEmpty &&
                                !phoneNumber.isEmpty &&
                                email.isValidEmail()
                            ) {
                                handleSaveChangesAction(
                                    manager,
                                    firstName,
                                    lastName,
                                    email,
                                    phoneNumber,
                                    isEmailNotificationsOrderStatusChecked,
                                    isEmailNotificationsPasswordChangesChecked,
                                    isEmailNotificationsSpecialOffersChecked,
                                    isEmailNotificationsNewsletterChecked
                                )
                                alertTitle = "Profile Data Updated"
                                alertMessage = "The new data was saved successfully"
                                showAlert.toggle()
                            } else {
                                if (
                                    firstName.isEmpty ||
                                    lastName.isEmpty ||
                                    phoneNumber.isEmpty ||
                                    email.isEmpty
                                ) {
                                    alertTitle = "Error"
                                    alertMessage = "The data couldn't be saved. Please enter all data."
                                    showAlert.toggle()
                                } else {
                                    if (
                                        !email.isEmpty &&
                                        !email.isValidEmail()
                                    ) {
                                        alertTitle = "Error"
                                        alertMessage = "The email entered is not valid"
                                        showAlert.toggle()
                                    }
                                }
                            }
                        }
                    )
                }.background(
                    NavigationLink(
                        destination: HomeView(),
                        isActive: $navigateToHomeView,
                        label: { EmptyView() }
                    )
                ).background(
                    NavigationLink(
                        destination: MainView(),
                        isActive: $navigateToOnBoardingView,
                        label: { EmptyView() }
                    )
                )
            } .navigationBarHidden(true)
        }.navigationBarHidden(true)
            .onAppear {
                firstName = manager.firstName
                lastName = manager.lastName
                email = manager.email
                phoneNumber = manager.phoneNumber
                isEmailNotificationsOrderStatusChecked = manager.isEmailNotificationOrderStatusEnabled
                isEmailNotificationsPasswordChangesChecked = manager.isEmailNotificationPasswordChangesEnabled
                isEmailNotificationsSpecialOffersChecked = manager.isEmailNotificationSpecialOffersEnabled
                isEmailNotificationsNewsletterChecked = manager.isEmailNotificationNewsletterEnabled
                
            }.alert(
                isPresented: $showAlert
            ) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(
                        Text("Ok")
                    ) {
                        
                    }
                )
            }
    }
}

private func handleSaveChangesAction(
    _ manager: UserManager,
    _ firstName: String,
    _ lastName: String,
    _ email: String,
    _ phoneNumber: String,
    _ isEmailNotificationsOrderStatusChecked: Bool,
    _ isEmailNotificationsPasswordChangesChecked: Bool,
    _ isEmailNotificationsSpecialOffersChecked: Bool,
    _ isEmailNotificationsNewsletterChecked: Bool
) {
    manager.firstName = firstName
    manager.lastName = lastName
    manager.email = email
    manager.phoneNumber = phoneNumber
    manager.isEmailNotificationOrderStatusEnabled = isEmailNotificationsOrderStatusChecked
    manager.isEmailNotificationPasswordChangesEnabled = isEmailNotificationsPasswordChangesChecked
    manager.isEmailNotificationSpecialOffersEnabled = isEmailNotificationsSpecialOffersChecked
    manager.isEmailNotificationNewsletterEnabled = isEmailNotificationsNewsletterChecked
}

private struct LittleLemonToolbar: View {
    var onBackButtonClicked: () -> Void
    var body: some View {
        ZStack() {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .frame(maxWidth: .infinity)
            HStack {
                Button {
                    onBackButtonClicked()
                } label: {
                    Circle()
                        .foregroundColor(Colors().Primary)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.white)
                        )
                }.padding(.leading, 12)
                Spacer()
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
                    .padding(.trailing, 12)
            }.frame(maxWidth: .infinity)
            
        }.padding(.vertical, 20)
            .frame(maxWidth: .infinity)
    }
}

private struct FormProfileView: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var phoneNumber: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(
                "Personal Information"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 20
                    )
                ).foregroundColor(Colors().Black)
                .padding(.bottom, 16)
            Text(
                "First Name"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 14
                    )
                ).foregroundColor(Colors().GrayLight)
                .padding(.bottom, 12)
                
            TextField(
                "",
                text: $firstName
            ).padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.gray, lineWidth: 1)
                ).accentColor(.yellow)
                    .padding(.bottom, 16)
            Text(
                "Last Name"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 14
                    )
                ).foregroundColor(Colors().GrayLight)
                .padding(.bottom, 12)
                
            TextField(
                "",
                text: $lastName
            ).padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray, lineWidth: 1)
            ).accentColor(.yellow)
                .padding(.bottom, 16)
            Text(
                "Email"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 14
                    )
                ).foregroundColor(Colors().GrayLight)
                .padding(.bottom, 12)
                
            TextField(
                "",
                text: $email
            ).padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray, lineWidth: 1)
            ).accentColor(.yellow)
                .padding(.bottom, 16)
            Text(
                "Phone number"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 14
                    )
                ).foregroundColor(Colors().GrayLight)
                .padding(.bottom, 12)
                
            TextField(
                "",
                text: $phoneNumber
            ).padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.gray, lineWidth: 1)
            ).accentColor(.yellow)
                
        }.padding()
    }
}

private struct FormEmailNotifications: View {
    @Binding var isEmailNotificationsOrderStatusChecked: Bool
    @Binding var isEmailNotificationsPasswordChangesChecked: Bool
    @Binding var isEmailNotificationsSpecialOffersChecked: Bool
    @Binding var isEmailNotificationsNewsletterChecked: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(
                "Email Notifications"
            ).fontWeight(.bold)
                .font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 20
                    )
                ).foregroundColor(Colors().Black)
                .padding(.bottom, 16)
            Toggle(
                isOn: $isEmailNotificationsOrderStatusChecked
            ) {
                Text(
                    "Order statuses"
                ).fontWeight(.bold)
                    .font(
                        .custom(
                            Fonts().karlaRegularFont,
                            size: 16
                        )
                    ).foregroundColor(Colors().GrayLight)
                    .padding(.bottom, 12)
            }.padding(.bottom, 8)
            Toggle(
                isOn: $isEmailNotificationsPasswordChangesChecked
            ) {
                Text(
                    "Password changes"
                ).fontWeight(.bold)
                    .font(
                        .custom(
                            Fonts().karlaRegularFont,
                            size: 16
                        )
                    ).foregroundColor(Colors().GrayLight)
                    .padding(.bottom, 12)
            }.padding(.bottom, 8)
            Toggle(
                isOn: $isEmailNotificationsSpecialOffersChecked
            ) {
                Text(
                    "Special offers"
                ).fontWeight(.bold)
                    .font(
                        .custom(
                            Fonts().karlaRegularFont,
                            size: 16
                        )
                    ).foregroundColor(Colors().GrayLight)
                    .padding(.bottom, 12)
            }.padding(.bottom, 8)
            Toggle(
                isOn: $isEmailNotificationsNewsletterChecked
            ) {
                Text(
                    "Newsletter"
                ).fontWeight(.bold)
                    .font(
                        .custom(
                            Fonts().karlaRegularFont,
                            size: 16
                        )
                    ).foregroundColor(Colors().GrayLight)
                    .padding(.bottom, 12)
            }.padding(.bottom, 8)
        }.padding()
    }
}

private struct ExtraButtonsProfileView: View {
    var onDiscardChangesButtonClicked: () -> Void
    var onSaveChangesButtonClicked: () -> Void
    var body: some View {
        HStack {
            Button {
                onDiscardChangesButtonClicked()
            } label: {
                Text(
                    "Discard Changes"
                ).font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 16
                    )
                ).fontWeight(.bold)
            }.buttonStyle(
                ButtonStyle3()
            )
            Button {
                onSaveChangesButtonClicked()
            } label: {
                Text(
                    "Save Changes"
                ).font(
                    .custom(
                        Fonts().karlaRegularFont,
                        size: 16
                    )
                ).fontWeight(.bold)
            }.buttonStyle(
                ButtonStyle2()
            )
        }.padding(.horizontal, 16)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
