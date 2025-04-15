//
//  Binding+EXT.swift
//  FetchRecipeProject
//
//  Created by Chi-Hsien Wu on 4/15/25.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init(
            get: { value.wrappedValue != nil },
            set: { newValue in
                if !newValue {
                    value.wrappedValue = nil
                }
            }
        )
    }
}
