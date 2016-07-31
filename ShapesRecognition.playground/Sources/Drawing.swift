import UIKit

public protocol Drawing: Touching {
    var canvas: DrawableView? { get set }
    var path: UIBezierPath { get }
}

extension Drawing {
    public var view: UIView? {
        return canvas?.view
    }
}

public protocol Viewable {
    var view: UIView { get }
}

extension UIView: Viewable {
    public var view: UIView {
        return self
    }
}

public protocol Drawable {
    var drawingLayer: CAShapeLayer { get }
    var drawing: Drawing? { get set }
    func update(path: UIBezierPath?)
}

extension Drawable {
    
    public func update(path: UIBezierPath?) {
        guard let path = path else {
            drawingLayer.path = nil
            return
        }
        
        let newPath = path.copy() as! UIBezierPath
        drawingLayer.path = newPath.CGPath
    }
    
}

public typealias DrawableView = protocol<Drawable, Viewable>

public class DrawingView: UIView, Drawable {
    
    public var drawing: Drawing? = nil {
        willSet {
            if newValue == nil {
                drawing?.canvas = nil
            }
        }
        didSet {
            //to avoid retain cycle between drawing and the view
            weak var weakSelf = self
            drawing?.canvas = weakSelf
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(backgroundLayer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy public var drawingLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.backgroundColor = nil
        layer.lineWidth = 2
        self.layer.addSublayer(layer)
        return layer
    }()
    
    lazy public var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.backgroundColor = nil
        layer.lineWidth = 2
        return layer
    }()
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        drawing?.touchesBegan(touches, withEvent: event)
        update(drawing?.path)
    }
    
    override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        drawing?.touchesMoved(touches, withEvent: event)
        update(drawing?.path)
    }

    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        drawing?.touchesEnded(touches, withEvent: event)
        update(drawing?.path)
        completePath(drawing?.path)
    }

    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        drawing?.touchesCancelled(touches, withEvent: event)
        update(nil)
    }
    
    func completePath(path: UIBezierPath?) {
        guard let path = path?.copy() as? UIBezierPath else { return }
        if let backgroundPath = backgroundLayer.path {
            path.appendPath(UIBezierPath(CGPath: backgroundPath))
        }
        backgroundLayer.path = path.CGPath
    }
    
}

public class DrawingViewController: UIViewController {
    
    override public func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
    }
    
    public var drawingView: DrawingView {
        return view as! DrawingView
    }
    
    override public func loadView() {
        view = DrawingView()
    }
    
}
