//
//  HLine.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//

import SwiftUI

struct HLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}
