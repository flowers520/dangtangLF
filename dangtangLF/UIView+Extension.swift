// UIView 扩展

import UIKit

extension UIView{

    //裁剪View 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat){
        let cornerSize = CGSizeMake(cornerRadius, cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.CGPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    //x
    var x: CGFloat{
        get{
            return frame.origin.x
        }
        set{
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    //y
    var y: CGFloat{
        get{
            return frame.origin.y
        }
        set{
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    //width
    var width: CGFloat{
        get{
            return frame.size.width
        }
        set{
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    //height
    var height: CGFloat{
        get{
            return frame.size.height
        }
        set{
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    //size
    var size: CGSize{
        get{
            return frame.size
        }
        set{
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    //centerX
    var centerX: CGFloat{
        get{
            return center.x
        }
        set{
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    //centerY
    var centerY: CGFloat{
        get{
            return center.y
        }
        set{
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
}