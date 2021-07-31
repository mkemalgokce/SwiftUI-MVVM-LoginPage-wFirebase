//
//  SignUpView.swift
//  LoginPage
//
//  Created by Mustafa Kemal Gökçe on 30.07.2021.
//

import SwiftUI
import FirebaseAuth
struct SignUpView: View {
    let bgColor = Color.white
    let color = Color.black.opacity(0.7)
    @State var mail: String = ""
    @State var pass: String = ""
    @State var rePass: String = ""
    @State var visible: Bool = false
    @State var reVisible: Bool = false
    @Binding var show: Bool
    @ObservedObject var viewModel: LoginViewModel
    var body: some View {
        ZStack(alignment: .topLeading){
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing).opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0){
                Button(action: {
                    self.show.toggle()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(self.color)
                        .font(.title)
                })
                VStack{
                    Image(systemName: "flame")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.4, height:  UIScreen.main.bounds.width * 0.52, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .aspectRatio(contentMode: .fit)
                    Text("Register")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding()
                    VStack{
                        InputField(textValue: self.$mail, isVisible: false, placeHolder: "E-mail", isPass: false)
                        InputField(textValue: self.$pass, isVisible: visible, placeHolder: "Password", isPass: true)
                        InputField(textValue: self.$rePass, isVisible: reVisible, placeHolder: "Re-enter Password", isPass: true)
                       
                        Button(action: {
                            viewModel.createUser(mail: self.mail, pass: self.pass, verificationPass: rePass)
                            
                            
                        }, label: {
                            Text("Register")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                                
                            
                        }).background(self.color)
                        .cornerRadius(10)
                        .padding(.top, 25)
                        .alert(isPresented: $viewModel.isAlert, content: {
                            Alert(title: Text("❗️❗️❗️"), message: Text(viewModel.alertMsg), dismissButton: .destructive(Text("OK")))
                        })
                    }.padding()
                    
                    
                    
                }
            }
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if viewModel.isLoading{
                LoadView()
            }
            
            
        }
    }
}

