//
//  InputField.swift
//  LoginPage
//
//  Created by Mustafa Kemal Gökçe on 30.07.2021.
//

import SwiftUI

struct InputField: View {
    @Binding var textValue: String
    @State var isVisible: Bool
    @State var placeHolder: String
    @State var isPass: Bool
    let color = Color.black.opacity(0.7)
    let bgColor = Color.white
    var body: some View {
        if isPass{
            HStack {
                if isVisible{
                    TextField(placeHolder, text: $textValue)
                        .padding()

                }else{
                    SecureField(placeHolder, text: $textValue)
                        .padding()
                }
                                          
                Button(action: {
                    self.isVisible.toggle()
                }, label: {
                    Image(systemName: isVisible ? "eye.slash.fill": "eye.fill")
                        .padding().foregroundColor(self.color)
                })
                
             
            }.background(RoundedRectangle(cornerRadius: 4).stroke(self.textValue != "" ? self.bgColor : self.color, lineWidth: 2))
        }else{
            TextField(placeHolder, text: $textValue)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(textValue != "" ? self.bgColor : self.color, lineWidth: 2))
        }
        
    }
}

