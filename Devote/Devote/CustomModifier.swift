//
//  CustomModifier.swift
//  Devote
//
//  Created by Vikas Vaish on 27/02/23.
//

import Foundation
import SwiftUI

struct ClearListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
