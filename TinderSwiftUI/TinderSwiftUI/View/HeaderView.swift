//
//  HeaderView.swift
//  TinderSwiftUI
//
//  Created by Vikas Vaish on 13/03/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Button {
                print("Information")
            } label: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.system(size: 24,weight: .regular))
                    .frame(width: 40,height: 40,alignment: .center)
                    .padding()
            }
            .tint(.primary)
            Spacer()
        }
        .padding(.trailing,110)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
