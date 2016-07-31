import UIKit

public class CurveDrawing: Drawing {
    public var canvas: DrawableView?
    public let path = UIBezierPath()
    var controlPoints: [CGPoint] = []
    
    public init() {}
    
    public func touchesBegan(at point: CGPoint) {
        controlPoints = [point]
        path.removeAllPoints()
        path.moveToPoint(point)
    }
    
    public func touchesMoved(to point: CGPoint) {
        guard controlPoints.count == 3 else {
            controlPoints.append(point)
            return
        }
        path.addCurveToPoint(
            point,
            controlPoint1: controlPoints[1],
            controlPoint2: controlPoints[2]
        )
        controlPoints = [point]
    }
    
    public func touchesEnded(at point: CGPoint) {
        if controlPoints.count > 1 {
            for _ in controlPoints.count..<4 {
                touchesMoved(to: point)
            }
        }
        controlPoints = []
    }
    
    public func touchesCancelled(at point: CGPoint) {
        path.removeAllPoints()
    }
    
}
