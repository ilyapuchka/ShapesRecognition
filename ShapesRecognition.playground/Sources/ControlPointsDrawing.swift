import UIKit

public class ControlPointsDrawing: Drawing {
    
    public var canvas: DrawableView?
    public let path = UIBezierPath()
    
    public enum Style {
        case circle(radius: CGFloat)
        case square(size: CGFloat)
        case cross(size: CGFloat)
        
        func apply(to path: UIBezierPath, center point: CGPoint) {
            switch self {
            case let .circle(radius):
                path.moveToPoint(CGPoint(x: point.x + radius, y: point.y))
                path.addArcWithCenter(point, radius: radius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            case let .cross(size):
                path.moveToPoint(CGPoint(x: point.x - size, y: point.y - size))
                path.addLineToPoint(CGPoint(x: point.x + size, y: point.y + size))
                path.moveToPoint(CGPoint(x: point.x - size, y: point.y + size))
                path.addLineToPoint(CGPoint(x: point.x + size, y: point.y - size))
            case let .square(size):
                path.moveToPoint(CGPoint(x: point.x - size, y: point.y - size))
                path.addLineToPoint(CGPoint(x: point.x + size, y: point.y - size))
                path.addLineToPoint(CGPoint(x: point.x + size, y: point.y + size))
                path.addLineToPoint(CGPoint(x: point.x - size, y: point.y + size))
                path.addLineToPoint(CGPoint(x: point.x - size, y: point.y - size))
            }
        }
    }
    
    let style: Style
    public init(_ style: Style = .circle(radius: 2)) {
        self.style = style
    }
    
    public func touchesBegan(at point: CGPoint) {
        style.apply(to: path, center: point)
    }
    
    public func touchesMoved(to point: CGPoint) {
        style.apply(to: path, center: point)
    }
    
    public func touchesEnded(at point: CGPoint) {
        style.apply(to: path, center: point)
    }
    
    public func touchesCancelled(at point: CGPoint) {
        path.removeAllPoints()
    }
    
}
