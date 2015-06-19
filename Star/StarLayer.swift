/**

Draws a star inside a layer

*/
struct StarLayer {
  /**
  
  Creates a square layer with given size and draws the star shape in it.
  
  - parameter starPoints: Array of points for drawing a closed shape. The size of enclosing rectangle is 100 by 100.
  
  - parameter size: The width and height of the layer. The star shape is scaled to fill the size of the layer.
  
  - parameter lineWidth: The width of the star stroke.
  
  - parameter fillColor: Star shape fill color. Fill color is invisible if it is a clear color.
  
  - parameter strokeColor: Star shape stroke color. Stroke is invisible if it is a clear color.
  
  - returns: New layer containing the star shape.
  
  */
  static func create(starPoints: [CGPoint], size: Double,
    lineWidth: Double, fillColor: UIColor, strokeColor: UIColor) -> CALayer {
      
    let containerLayer = createContainerLayer(size)
    let path = createStarPath(starPoints, size: size)
      
    let shapeLayer = createShapeLayer(path.CGPath, lineWidth: lineWidth,
      fillColor: fillColor, strokeColor: strokeColor)
      
    let maskLayer = createMaskLayer(path.CGPath)
    
    containerLayer.mask = maskLayer
    containerLayer.addSublayer(shapeLayer)
    
    return containerLayer
  }
  
  /**
  
  Creates a mask layer with the given path shape. The purpose of the mask layer is to prevent the shape's stroke to go over the shape's edges.
  
  - parameter path: The star shape path.
  
  - returns: New mask layer.

  */
  static func createMaskLayer(path: CGPath) -> CALayer {
    let layer = CAShapeLayer()
    layer.anchorPoint = CGPoint()
    layer.contentsScale = UIScreen.mainScreen().scale
    layer.path = path
    return layer
  }
  
  /**
  
  Creates the star shape layer.
  
  - parameter path: The star shape path.
  
  - parameter lineWidth: The width of the star stroke.
  
  - parameter fillColor: Star shape fill color. Fill color is invisible if it is a clear color.
  
  - parameter strokeColor: Star shape stroke color. Stroke is invisible if it is a clear color.
  
  - returns: New shape layer.
  
  */
  static func createShapeLayer(path: CGPath, lineWidth: Double, fillColor: UIColor, strokeColor: UIColor) -> CALayer {
    let layer = CAShapeLayer()
    layer.anchorPoint = CGPoint()
    layer.contentsScale = UIScreen.mainScreen().scale
    layer.strokeColor = strokeColor.CGColor
    layer.fillColor = fillColor.CGColor
    layer.lineWidth = CGFloat(lineWidth)
    layer.path = path
    return layer
  }
  
  /**
  
  Creates a layer that will contain the shape layer.
  
  - returns: New container layer.
  
  */
  static func createContainerLayer(size: Double) -> CALayer {
    let layer = CALayer()
    layer.contentsScale = UIScreen.mainScreen().scale
    layer.anchorPoint = CGPoint()
    layer.masksToBounds = true
    layer.bounds.size = CGSize(width: size, height: size)
    return layer
  }
  
  /**
  
  Creates a path for the given star points and size. The star points specify a shape of size 100 by 100. The star shape will be scaled if the size parameter is not 100. For exampe, if size parameter is 200 the shape will be scaled by 2.
  
  - parameter starPoints: Array of points for drawing a closed shape. The size of enclosing rectangle is 100 by 100.
  
  - parameter size: Specifies the size of the shape to return.
  
  - returns: New shape path.
  
  */
  static func createStarPath(starPoints: [CGPoint], size: Double) -> UIBezierPath {
    let points = scaleStar(starPoints, factor: size / 100)
    let path = UIBezierPath()
    path.moveToPoint(points[0])
    let remainingPoints = Array(points[1..<points.count])
    
    for point in remainingPoints {
      path.addLineToPoint(point)
    }
    
    path.closePath()
    return path
  }
  
  /**
  
  Scale the star points by the given factor.
  
  - parameter starPoints: Array of points for drawing a closed shape. The size of enclosing rectangle is 100 by 100.  
  
  - parameter factor: The factor by which the star points are scaled. For example, if it is 0.5 the output points will define the shape twice as small as the original.
  
  - returns: The scaled shape.
  
  */
  static func scaleStar(starPoints: [CGPoint], factor: Double) -> [CGPoint] {
    return starPoints.map { point in
      return CGPoint(x: point.x * CGFloat(factor), y: point.y * CGFloat(factor))
    }
  }
}