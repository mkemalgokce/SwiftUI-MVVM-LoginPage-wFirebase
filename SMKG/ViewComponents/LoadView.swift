//
//  LoadView.swift
//  SMKG
//
//  Created by Mustafa Kemal Gökçe on 30.07.2021.
//

import SwiftUI

struct LoadView: View {
    @State var animation = false
    var body: some View {
        VStack{
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.red, lineWidth: 8)
            .frame(width: 75, height: 75)
            .rotationEffect(.init(degrees: animation ? 360 : 0))
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)) {
                animation.toggle()
            }
        })
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
