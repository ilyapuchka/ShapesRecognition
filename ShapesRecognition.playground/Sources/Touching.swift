import UIKit

public protocol Touching {
    var view: UIView? { get }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    func touchesBegan(at point: CGPoint)
    
    func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    func touchesMoved(to point: CGPoint)
    
    func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    func touchesEnded(at point: CGPoint)
    
    func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
    func touchesCancelled(at point: CGPoint)
}

extension Drawing {
    public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touchPoint = touches.first?.locationInView(view) else { return }
        touchesBegan(at: touchPoint)
    }
    
    public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touchPoint = touches.first?.locationInView(view) else { return }
        touchesMoved(to: touchPoint)
    }
    
    public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touchPoint = touches.first?.locationInView(view) else { return }
        touchesEnded(at: touchPoint)
    }
    
    public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard let touchPoint = touches?.first?.locationInView(view) else { return }
        touchesCancelled(at: touchPoint)
    }
}
