//
//  LoginView.swift
//  LoginPage
//
//  Created by Mustafa Kemal Gökçe on 30.07.2021.
//

import SwiftUI


struct LoginView: View {
    let bgColor = Color.white
    let color = Color.black.opacity(0.7)
    @State var email: String = ""
    @State var pass: String = ""
    @State var visible: Bool = false
    @State var isForgot: Bool = false
    @Binding var show: Bool
    @State var forgotMail: String = ""
    @ObservedObject var viewModel: LoginViewModel
    var body: some View {
        ZStack(alignment: .topTrailing){
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing).opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image(systemName: "flame")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.4, height:  UIScreen.main.bounds.width * 0.52, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fit)
                Text("Log in to Your Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(self.color)
                    .padding()
                VStack{
                    InputField(textValue: self.$email, isVisible: false, placeHolder: "E-mail", isPass: false)
                    InputField(textValue: self.$pass, isVisible: visible, placeHolder: "Password", isPass: true)
                    HStack(){
                        Spacer()
                        Button(action:{
                            withAnimation(){
                                self.isForgot = true
                            }
                            
                        }){
                            Text("Forgot Password")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }.foregroundColor(self.color)
                    }
                    Button(action: {
                        viewModel.signIn(mail: email, pass: pass)
                        
                    }, label: {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            
                        
                    }).background(self.color)
                    .cornerRadius(10)
                    .padding(.top, 25)
                    .alert(isPresented: $viewModel.isAlert, content: {
                        Alert(title: Text("❗️❗️❗️"), message: Text(viewModel.alertMsg), dismissButton: Alert.Button.cancel())
                    })
                }.padding()
                HStack{
                    Text("Don't have an account ?")
                        .font(.title3)
                    Button(action: {
                        withAnimation(){
                            self.show.toggle()
                        }
                    }, label: {
                        Text("Sign Up Now")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            
                    })
                }
                
            }.padding()
            .allowsHitTesting(!isForgot)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            if viewModel.isLoading{
                LoadView()
            }
            if self.isForgot{
                VStack{
                    Text("Please Enter Your Mail Adress")
                        .font(.title)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding()
                    InputField(textValue: $forgotMail, isVisible: true, placeHolder: "Mail", isPass: false)
                        .padding()
                    HStack{
                        Button(action: {
                            viewModel.resetPassword(mail: forgotMail)
                            withAnimation(){
                                self.isForgot.toggle()
                            }
                            
                        }, label: {
                            Text("Reset Password")
                        }).padding()
                        Button(action: {
                            withAnimation(){
                                self.isForgot.toggle()
                            }
                        }, label: {
                            Text("Cancel")
                        }).padding()
                    }
                }
                .background(Color.yellow)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
            }
            
        }
    }
}


