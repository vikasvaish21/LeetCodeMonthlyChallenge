//
//  ContentView.swift
//  Learn by Doing
//
//  Created by Vikas Vaish on 01/03/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: -  Properties
    var cards: [Card] = cardData
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
            HStack(alignment: .center,spacing: 20) {
                ForEach(cards) { item in
                    CardView(card: item)
                }
            }
            .padding(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
    }
}
