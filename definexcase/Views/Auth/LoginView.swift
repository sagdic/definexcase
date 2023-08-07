//
//  LoginView.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject private var loginVM = LoginViewModelImpl(service: DefinexServiceImpl())
    @State private var isAlertPresented = false
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        VStack {
            Spacer()
            
//            MARK: - Masked Gradient Title
            Text("Definex\nCase Study")
                .font(.custom(.medium, size: 32))
                .multilineTextAlignment(.center)
                .overlay {
                    LinearGradient(
                        colors: [.titleGrad0, .titleGrad1],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .mask(
                        Text("Definex\nCase Study")
                            .font(.custom(.medium, size: 32))
                            .multilineTextAlignment(.center)
                    )
                }.padding(.bottom,63)
            
//            MARK: - Email textfield
            FloatingTextField(title: "email", text: $email,icon: "envelope.fill", isSecured: false).font(.custom(.regular, size: 16))
            
//            MARK: - Password textfield
            FloatingTextField(title: "password", text: $password, icon: "lock.fill", isSecured: true).font(.custom(.regular, size: 16))
            
            
            Spacer()
            
//            MARK: - Login Button
            Button {
                loginVM.credentials.email = email
                loginVM.credentials.password = password
                loginVM.performLogin()
            } label: {
                Text("login")
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 40.0)
            .buttonBorderShape(.roundedRectangle(radius: 12))
            .background(LinearGradient(
                colors: [.loginBtnGrad1, .loginBtnGrad0],
                startPoint: .leading,
                endPoint: .trailing
            )).tint(.black)
                .cornerRadius(6)
                .padding(.bottom, 43)
                .onChange(of: loginVM.isLogged) { newValue in
                    if newValue {
                        self.authentication.updateValidation(success: true)
                    }
                }
            
//           MARK: - Forgot Password Button
            ZStack {
                HLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                    .foregroundColor(.gray)
                    .frame(height: 1).padding(.horizontal, UIScreen.main.bounds.width / 4)
                Button {
                    isAlertPresented = true
                } label: {
                    Text("forgotpass")
                        .font(.custom(.regular, size: 10))
                        .padding(.horizontal, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 99)
                                .stroke(.blue, lineWidth: 1)
                        ).background(.white)
                }
                .alert(title: "comingsoon", message: "notyet",
                       dismissButton: CustomAlertButton(title: "dismiss", action: {}),
                        isPresented: $isAlertPresented)
                }.padding(.bottom, 16)
                
            //        MARK: - Social Media Buttons
            HStack{
//                Facebook
                Button {
                    isAlertPresented = true
                } label: {
                    HStack {
                        Image("facebook_icon")
                        Spacer()
                        Text("FACEBOOK")
                            .font(.custom(.medium, size: 16))
                        Spacer()
                    }
                }
                .alert(title: "comingsoon", message: "notyet",
                       dismissButton: CustomAlertButton(title: "dismiss", action: {}),
                        isPresented: $isAlertPresented)
                .frame(width: UIScreen.main.bounds.width/2-40, height: 40.0)
                .background(Color.facebookColor).tint(.white)
                .cornerRadius(6)
                .padding(.leading, 16)
                
                Spacer()
                
//                Twitter
                Button {
                    isAlertPresented = true
                } label: {
                    HStack {
                        Image("twitter_icon")
                        Spacer()
                        Text("TWITTER")
                            .font(.custom(.medium, size: 16))
                        Spacer()
                    }
                }
                .alert(title: "comingsoon", message: "notyet",
                        dismissButton: CustomAlertButton(title: "dismiss", action: {}),
                         isPresented: $isAlertPresented)
                .frame(width: UIScreen.main.bounds.width/2-40, height: 40.0)
                .background(Color.twitterColor).tint(.white)
                .cornerRadius(6)
                .padding(.trailing, 16)
            }.padding(.bottom, 16)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            LoginView()
                .environment(\.locale, .init(identifier: "en"))
            LoginView()
                .environment(\.locale, .init(identifier: "tr"))
        }
    }
}
