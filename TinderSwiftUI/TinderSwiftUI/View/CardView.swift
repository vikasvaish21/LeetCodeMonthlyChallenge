//
//  CardView.swift
//  TinderSwiftUI
//
//  Created by Vikas Vaish on 13/03/23.
//

import SwiftUI

struct CardView: View {
    var id = UUID()
    var style : UIBlurEffect.Style = .systemUltraThinMaterial
    var user: Results
    @Binding var isLinked: Bool
    var body: some View {
        ZStack{
            ForEach
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
