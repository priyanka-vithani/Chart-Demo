import UIKit
enum TimingFunction{
    case linear,easeIn,easeOut,easeInOut,
    spring,
    easeInSine,easeOutSine,easeInOutSine,
    easeInQuad,easeOutQuad,easeInOutQuad,
    easeInCubic,easeOutCubic,easeInOutCubic,
    easeInQuart,easeOutQuart,easeInOutQuart,
    easeInQuint,easeOutQuint,easeInOutQuint,
    easeInExpo,easeOutExpo,easeInOutExpo,
    easeInCirc,easeOutCirc,easeInOutCirc,
    easeInBack,easeOutBack,easeInOutBack
    
    func getTimingFunction() -> CAMediaTimingFunction {
        switch self {
        case .linear:
            return CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:
            return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        case .spring:
            return CAMediaTimingFunction(controlPoints: 0.5, 1.1+Float(1/3), 1, 1)
        case .easeInSine:
            return CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
        case .easeOutSine:
            return CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
        case .easeInOutSine:
            return CAMediaTimingFunction(controlPoints: 0.445, 0.05, 0.55, 0.95)
        case .easeInQuad:
            return CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
        case .easeOutQuad:
            return CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
        case .easeInOutQuad:
            return CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
        case .easeInCubic:
            return CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
        case .easeOutCubic:
            return CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
        case .easeInOutCubic:
            return CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
        case .easeInQuart:
            return CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
        case .easeOutQuart:
            return CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        case .easeInOutQuart:
            return CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        case .easeInQuint:
            return CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
        case .easeOutQuint:
            return CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
        case .easeInOutQuint:
            return CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
        case .easeInExpo:
            return CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
        case .easeOutExpo:
            return CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
        case .easeInOutExpo:
            return CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
        case .easeInCirc:
            return CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
        case .easeOutCirc:
            return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
        case .easeInOutCirc:
            return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
        case .easeInBack:
            return CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        case .easeOutBack:
            return CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        case .easeInOutBack:
            return CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
        }
    }
}
class LineScale: RPLoadingAnimationDelegate {
    
    func setup(_ layer: CALayer, size: CGSize, colors: [UIColor]) {
        
        let lineNum: CGFloat = 7
        let lineSize: CGSize = CGSize(width: size.width / 10, height: size.height / 2.5)
        let line = CALayer()
        let duration: CFTimeInterval = 0.6
        
        let frame = CGRect(
            x: (layer.bounds.width - lineSize.width) / 2 - lineSize.width * lineNum / 1,
            y: (layer.bounds.height - lineSize.height) / 2,
            width: lineSize.width,
            height: lineSize.height
        )
        
        line.backgroundColor = colors[0].cgColor
        line.frame = frame
        line.cornerRadius = lineSize.width / 2
        
        let replicatorLayer = CAReplicatorLayer()
        
        replicatorLayer.frame = layer.bounds
        replicatorLayer.addSublayer(line)
        
        replicatorLayer.instanceCount = Int(lineNum)
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(lineSize.width + 5, 0, 0)
        replicatorLayer.instanceDelay = 0.15
        
        layer.addSublayer(replicatorLayer)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        scaleAnimation.toValue = 0.2
        scaleAnimation.duration = duration
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.timingFunction = TimingFunction.easeInOutCubic.getTimingFunction()
        line.add(scaleAnimation, forKey: "scaleAnimation")
        
        if colors.count > 1 {
            var cgColors : [CGColor] = []
            for color in colors {
                cgColors.append(color.cgColor)
            }
            
            let colorAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
            colorAnimation.values = cgColors
            colorAnimation.duration = 0.8
            colorAnimation.repeatCount = .infinity
            colorAnimation.autoreverses = true
            line.add(colorAnimation, forKey: "colorAnimation")
        }
    }
}
