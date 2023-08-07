//
//  ResultState.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import SwiftUI

enum ResultState<T> {
    case loading
    case success(content: T)
    case failed(error: Error)
}
