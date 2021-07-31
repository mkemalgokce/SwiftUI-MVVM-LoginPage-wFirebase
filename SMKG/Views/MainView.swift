//
//  MainView.swift
//  SMKG
//
//  Created by Mustafa Kemal Gökçe on 30.07.2021.
//

import SwiftUI
import FirebaseAuth
struct MainView: View {
    var body: some View {
        VStack{
            Text("Succesfully logged on \(Auth.auth().currentUser?.email ?? "")")
            Button(action: {
                
            }, label: {
                Text("Log out")
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
