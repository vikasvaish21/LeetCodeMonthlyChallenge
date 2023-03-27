//
//  FooterView.swift
//  TinderSwiftUI
//
//  Created by Vikas Vaish on 13/03/23.
//

import SwiftUI

struct FooterView: View {
    @Binding var isLinked : Bool
    @Binding var isDisLiked : Bool
    
    var body: some View {
        HStack{
            Button {
                isDisLiked.toggle()
            } label: {
                Image(systemName: "xmark.circle")
                    .renderingMode(.template)
                    .font(.system(size: 42,weight: .light))
                    .padding()
            }
            .foregroundColor(.black)
            Spacer()
            Text("Swipe")
                .foregroundColor(.pink)
                .font(.system(size: 25,weight: .bold,design: .serif))
                .padding(.horizontal,20)
                .padding(.vertical,12)
                .background(Capsule().stroke(.pink,lineWidth: 2))
                Spacer()
            Button {
                isLinked.toggle()
            } label: {
                Image(systemName: "heart.circle")
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .font(.system(size: 42,weight: .light))
                    .padding()
            }
            .buttonStyle(<#T##style: PrimitiveButtonStyle##PrimitiveButtonStyle#>)
            
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(isLinked: <#Binding<Bool>#>, isDisLiked: <#Binding<Bool>#>)
    }
}
