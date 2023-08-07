//
//  GradientLine.swift
//  definexcase
//
//  Created by Digiturk on 21.01.2023.
//
import UIKit

/// Line of the gradient
///
/// - vertical: From top to bottom
/// - horizontal: From left to right
/// - leftCrosswise: From top-left to bottom-right
/// - rightCrosswise: From top-right to bottom-left
/// - custom: Customize line with start and end points. CGPoints must be between 0 and 1.
/// 
public enum GradientLine: Equatable {

    case vertical

    case horizontal

    case leftCrosswise

    case rightCrosswise

    case custom(startPoint: CGPoint, endPoint: CGPoint)

    var startPoint: CGPoint {

        switch self {
        case .vertical: return CGPoint(x: 0.5, y: 0)
        case .horizontal: return CGPoint(x: 0, y: 0.5)
        case .leftCrosswise: return CGPoint(x: 0, y: 1)
        case .rightCrosswise: return CGPoint(x: 1, y: 1)
        case .custom(let startPoint, _): return startPoint
        }
    }

    var endPoint: CGPoint {

        switch self {
        case .vertical: return CGPoint(x: 0.5, y: 1)
        case .horizontal: return CGPoint(x: 1, y: 0.5)
        case .leftCrosswise: return CGPoint(x: 1, y: 0)
        case .rightCrosswise: return CGPoint(x: 0, y: 0)
        case .custom(_, let endPoint): return endPoint
        }
    }
}
