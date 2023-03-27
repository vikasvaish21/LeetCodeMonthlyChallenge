//
//  BlankView.swift
//  Devote
//
//  Created by Vikas Vaish on 28/02/23.
//

import SwiftUI

struct BlankView: View {
    //MARK: -  PROPERTY
    var backgroundColor : Color
    var backgroundOpacity: Double
    
    var body: some View {
        VStack{
            Spacer()
            
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity,alignment: .center)
        .background(Color.black)
        .opacity(0.5)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: Color.black, backgroundOpacity: 0.5)
            .background(BackgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
