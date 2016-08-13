import UIKit

public class DouglasPeucker {
    var points: [CGPoint] = [] {
        didSet {
            keep = points.map({ $0 })
            
            if points.count >= 3 {
                stack = [(0, points.count - 1)]
            }
        }
    }
    let tolerance: CGFloat
    
    public var path: UIBezierPath = UIBezierPath()
    
    private func buildPath(farthest: FarthestPoint?, currentRange: (Int, Int)?) -> UIBezierPath {
        let path = draw(LineDrawing(), points: result)
        let controlPointsPath = draw(ControlPointsDrawing(), points: result)
        path.appendPath(controlPointsPath)
        
        if let currentRange = currentRange {
            let currentRangePath = draw(LineDrawing(), points: [points[currentRange.0], points[currentRange.1]])
            path.appendPath(currentRangePath)
        }
        
        let removedPoints = keep.enumerate().filter({ $0.element == nil }).map({ points[$0.index] })
        let removedPointsPath = draw(ControlPointsDrawing(.cross(size: 3)), points: removedPoints)
        path.appendPath(removedPointsPath)
        
        if let farthest = farthest, let currentRange = currentRange {
            let farthestPointPath = draw(ControlPointsDrawing(.square(size: 3)), points: [farthest.point])
            path.appendPath(farthestPointPath)
            
            var foot: CGPoint!
            farthest.point.distance(to: (start: points[currentRange.0], end: points[currentRange.1]), foot: &foot)
            let heightPath = draw(LineDrawing(), points: [farthest.point, foot])
            path.appendPath(heightPath)
        }
        
        return path
    }
    
    /// This flag is used to run the algorithm one more time to build the final path with all discarded points
    private var finished: Bool = false
    
    public var result: [CGPoint] { return keep.flatMap({ $0 }) }
    
    var stack: [(Int, Int)] = [] //ranges stack
    var keep: [CGPoint?] = [] //points to keep
    
    public init(tolerance: CGFloat) {
        self.tolerance = tolerance
    }
    
    func _run() -> Bool {
        guard !stack.isEmpty else {
            if !finished {
                finished = true
                path = buildPath(nil, currentRange: nil)
                return true
            }
            else {
                return false
            }
        }

        let (startIndex, endIndex) = stack[0]
        let currentRange = stack[0]
        stack = Array(stack.dropFirst())
        
        let keepPoints = keep[(startIndex)...endIndex].flatMap({ $0 })
        
        guard let farthest = farthestPoint(keepPoints) else {
            return true
        }
        self.path = buildPath(farthest, currentRange: currentRange)
        
        if farthest.distance >= tolerance {
            if farthest.index > 1 {
                stack.insert((startIndex, startIndex + farthest.index), atIndex: 0)
            }
            if endIndex - startIndex - farthest.index > 1  {
                stack.insert((startIndex + farthest.index, endIndex), atIndex: 0)
            }
        }
        else {
            for i in (startIndex+1)..<endIndex {
                keep[i] = nil
            }
        }
        
        return true
    }
    
    /// Runs the algorithm on the provided set of points
    public func run(points: [CGPoint]) {
        for _ in iterations(points) {}
    }

    /// Returns the sequence of algorithm iterations applied to the provided set of points
    public func iterations(points: [CGPoint]) -> Iterations {
        self.points = points
        return Iterations(douglasPeucker: self)
    }

    public struct Iterations: SequenceType {
        let douglasPeucker: DouglasPeucker
        
        public func generate() -> AnyGenerator<Iteration> {
            return AnyGenerator() {
                if self.douglasPeucker._run() {
                    return Iteration(path: self.douglasPeucker.path)
                }
                else {
                    return nil
                }
            }
        }
        
    }
    
    public struct Iteration {
        public let path: UIBezierPath
    }
    
}

public func douglasPeucker(points: [CGPoint], tolerance: CGFloat) -> [CGPoint] {
    guard let farthest = farthestPoint(points) else { return points }
    guard farthest.distance > tolerance else { return [points.first!, points.last!] }
    
    let left = douglasPeucker(Array(points[0...farthest.index]), tolerance: tolerance)
    let right = douglasPeucker(Array(points[farthest.index..<points.count]), tolerance: tolerance)
    
    return Array([Array(left.dropLast()), right].flatten())
}
