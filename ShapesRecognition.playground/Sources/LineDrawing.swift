import UIKit

public class LineDrawing: Drawing {
    public var canvas: DrawableView?
    public let path = UIBezierPath()
    private var lastPoint: CGPoint!
    
    public init() {}
    
    public func touchesBegan(at point: CGPoint) {
        path.removeAllPoints()
        path.moveToPoint(point)
        lastPoint = point
    }
    
    public func touchesMoved(to point: CGPoint) {
        path.moveToPoint(lastPoint)
        path.addLineToPoint(point)
        lastPoint = point
    }
    
    public func touchesEnded(at point: CGPoint) {
        path.moveToPoint(lastPoint)
        path.addLineToPoint(point)
    }
    
    public func touchesCancelled(at point: CGPoint) {
        path.removeAllPoints()
    }
    
}
