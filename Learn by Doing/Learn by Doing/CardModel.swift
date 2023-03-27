//
//  CardModel.swift
//  Learn by Doing
//
//  Created by Vikas Vaish on 02/03/23.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var title : String
    var headline: String
    var imageName : String
    var callToAction: String
    var message: String
    var gradientColors:[Color]
}
