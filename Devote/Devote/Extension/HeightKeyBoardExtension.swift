//
//  HeightKeyBoardExtension.swift
//  Devote
//
//  Created by Vikas Vaish on 26/02/23.
//

import Foundation
import SwiftUI


#if canImport(UIKit)
extension View{
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

extension View {
    func clearListBackground() -> some View {
        modifier(ClearListBackgroundModifier())
    }
}
