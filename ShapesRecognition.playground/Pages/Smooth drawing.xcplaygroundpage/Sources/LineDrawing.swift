import UIKit

public class LineDrawing: Drawing {
    public var canvas: DrawableView?
    public let path = UIBezierPath()
    
    public init() {}
    
    public func touchesBegan(at point: CGPoint) {
        path.removeAllPoints()
        path.moveToPoint(point)
    }
    
    public func touchesMoved(to point: CGPoint) {
        path.addLineToPoint(point)
    }
    
    public func touchesEnded(at point: CGPoint) {
        path.addLineToPoint(point)
    }
    
    public func touchesCancelled(at point: CGPoint) {
        path.removeAllPoints()
    }
    
}
