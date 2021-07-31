//
//  HomeView.swift
//  LoginPage
//
//  Created by Mustafa Kemal Gökçe on 30.07.2021.
//

import SwiftUI

struct Home: View{
    @State var show = false
    @ObservedObject var viewModel = LoginViewModel()
    @AppStorage("loginStatus") var status = false
    var body: some View{
        ZStack{
            if status{
                
                Button(action: {
                    viewModel.logOut()
                }, label: {
                    Text("Log out")
                })
            }else{
                if self.show == false {
                    LoginView(show: $show, viewModel: viewModel)
                }else{
                    SignUpView(show: $show, viewModel: viewModel)
                }
            }
            
        }

        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
