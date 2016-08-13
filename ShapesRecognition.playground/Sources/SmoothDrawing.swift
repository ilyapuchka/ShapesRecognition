import UIKit

public class SmoothDrawing: Drawing {
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
        guard controlPoints.count == 4 else {
            controlPoints.append(point)
            return
        }
        let endPoint = CGPoint(
            x: (controlPoints[2].x + point.x)/2,
            y: (controlPoints[2].y + point.y)/2
        )
        path.addCurveToPoint(
            endPoint,
            controlPoint1: controlPoints[1],
            controlPoint2: controlPoints[2]
        )
        controlPoints = [endPoint, point]
    }
    
    public func touchesEnded(at point: CGPoint) {
        if controlPoints.count > 1 {
            for _ in controlPoints.count..<5 {
                touchesMoved(to: point)
            }
        }
        controlPoints = []
    }
    
    public func touchesCancelled(at point: CGPoint) {
        path.removeAllPoints()
    }
    
}
