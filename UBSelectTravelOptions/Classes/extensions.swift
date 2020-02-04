//
//  extensions.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func getFrom(customClass: AnyClass, nameResource: String) -> UIImage? {
        let frameWorkBundle = Bundle(for: customClass)
        if let bundleURL = frameWorkBundle.resourceURL?.appendingPathComponent("UBSelectTravelOptions.bundle"), let resourceBundle = Bundle(url: bundleURL) {
            return UIImage(named: nameResource, in: resourceBundle, compatibleWith: nil)
        }
        return nil
    }
    
}

extension UIView {
    
    func addBorder(edges: UIRectEdge, color: UIColor, thickness: CGFloat = 1.0) {
        let borderName = "CustomBorderLayer"
        
        if let border = self.layer.sublayers?.filter({ $0.name == borderName }).first {
            border.removeFromSuperlayer()
        }
        let shape = CAShapeLayer()
        shape.name = borderName
        
        let path = UIBezierPath()
        path.move(to: .zero)
        
        if edges.contains(.top) {
            let point: CGPoint = .init(x: self.bounds.width, y: 0)
            path.addLine(to: point)
            path.move(to: point)
        }
        if edges.contains(.right) {
            path.move(to: .init(x: self.bounds.width, y: 0))
            let point: CGPoint = .init(x: self.bounds.width, y: self.bounds.height)
            path.addLine(to: point)
            path.move(to: point)
        }
        if edges.contains(.bottom) {
            path.move(to: .init(x: self.bounds.width, y: self.bounds.height))
            let point: CGPoint = .init(x: 0, y: self.bounds.height)
            path.addLine(to: point)
            path.move(to: point)
        }
        if edges.contains(.left) {
            path.move(to: .init(x: 0, y: self.bounds.height))
            let point: CGPoint = .init(x: 0, y: 0)
            path.addLine(to: point)
            path.move(to: point)
        }
        path.close()
        
        shape.path = path.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = color.cgColor
        shape.lineWidth = thickness
        
        self.layer.addSublayer(shape)
    }
    
}

enum iPhoneType {
    case S4
    case S5
    case S6_7_8
    case S6_7_8Plus
    case X_XS
    case XR_XMax
}

extension UIDevice {
    static var screenSize: Size {
        return Size()
    }
    static var iPhoneCurrent: iPhoneType {
        switch UIScreen.main.bounds.size {
        case self.screenSize.S4:        return .S4
        case self.screenSize.S5:        return .S5
        case self.screenSize.S6:        return .S6_7_8
        case self.screenSize.S6Plus:    return .S6_7_8Plus
        case self.screenSize.XandXS:    return .X_XS
        default:                        return .XR_XMax
        }
    }
    static var isInfinteScreen: Bool {
        return self.iPhoneCurrent == .X_XS || self.iPhoneCurrent == .XR_XMax
    }
}

class Size {
    var XRandMax: CGSize {
        return CGSize(width: 414, height: 895)
    }
    var XandXS: CGSize {
        return CGSize(width: 375, height: 812)
    }
    var S6Plus: CGSize {
        return CGSize(width: 414, height: 736)
    }
    var S6: CGSize {
        return CGSize(width: 375, height: 667)
    }
    var S5: CGSize {
        return CGSize(width: 320, height: 568)
    }
    var S4: CGSize {
        return CGSize(width: 320, height: 480)
    }
}
