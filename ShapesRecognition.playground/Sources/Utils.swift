import UIKit
import CoreGraphics

public func draw(drawing: Drawing, points: [CGPoint], scale: CGFloat = 2.0) -> UIBezierPath {
    guard !points.isEmpty else { return UIBezierPath() }
    
    drawing.touchesBegan(at: points[0])
    if points.count > 1 {
        for i in (points.startIndex + 1)..<(points.endIndex - 1) {
            drawing.touchesMoved(to: points[i])
        }
        drawing.touchesEnded(at: points.last!)
    }
    drawing.path.applyTransform(CGAffineTransformMakeScale(scale, scale))
    return drawing.path
}
