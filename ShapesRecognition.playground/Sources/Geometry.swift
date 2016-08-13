import UIKit

extension CGPoint {
    
    /// Calculates the distance between two points.
    public func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.y - y, 2) + pow(point.x - x, 2))
    }

    /// Calculates the distance between the point and the line segment between the `start` and the `end` points.
    public func distance(to line: (start: CGPoint, end: CGPoint)) -> CGFloat {
        let a = area((self, line.start, line.end))
        let b = line.start.distance(to: line.end)
        return 2 * a / b
    }

    /// Calculates the distance between the point and the line segment between the `start` and the `end` points.
    /// `foot` point will contain the intersection between the line segment and the altitude from the point to the line segment.
    public func distance(to line: (start: CGPoint, end: CGPoint), inout foot: CGPoint!) -> CGFloat {
        let dist = distance(to: line)
        let r = sqrt(pow(distance(to: line.start), 2) - pow(dist, 2))
        let l = line.end.distance(to: line.start)
        let x = r/l * (line.end.x - line.start.x) + line.start.x
        let y = r/l * (line.end.y - line.start.y) + line.start.y
        foot = CGPoint(x: x, y: y)
        return dist
    }
    
}

/// Calculates the area of the triangle formed by three input points.
public func area(p: (CGPoint, CGPoint, CGPoint)) -> CGFloat {
    return 0.5 * fabs((p.0.x - p.2.x) * (p.1.y - p.0.y) - (p.0.x - p.1.x) * (p.2.y - p.0.y))
}

public typealias FarthestPoint = (index: Int, point: CGPoint!, distance: CGFloat)

/// Finds the farthes point to the line segment between first and the last points of the set.
/// Returns its index in the set, the point itself and corresponding distance.
public func farthestPoint(points: [CGPoint]) -> FarthestPoint? {
    var farthest: FarthestPoint?
    guard points.count >= 3 else { return farthest }
    
    let (p1, pn) = (points.first!, points.last!)
    for i in 1..<(points.count - 1) {
        let distance = points[i].distance(to: (p1, pn))
        if distance > (farthest?.distance ?? -CGFloat.max) {
            farthest = (i, points[i], distance)
        }
    }
    return farthest
}
