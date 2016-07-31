import UIKit
import CoreGraphics

public func draw(drawing: Drawing, points: [CGPoint]) -> UIBezierPath {
    drawing.touchesBegan(at: points[0])
    for i in points.startIndex + 1..<(points.endIndex-1) {
        drawing.touchesMoved(to: points[i])
    }
    drawing.touchesEnded(at: points.last!)
    drawing.path.applyTransform(CGAffineTransformMakeScale(2, 2))
    return drawing.path
}
