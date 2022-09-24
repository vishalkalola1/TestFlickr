//
//  View+Extensions.swift
//  Movies
//
//  Created by vishal on 8/2/22.
//

import SwiftUI
import UIKit

extension View {
    func errorAlert(error: Binding<Error?>) -> some View {
        return alert(isPresented: .constant(error.wrappedValue != nil)) {
            Alert(title: Text("Error"),
                  message:  Text(error.wrappedValue?.localizedDescription ?? ""))
        }
    }
}
