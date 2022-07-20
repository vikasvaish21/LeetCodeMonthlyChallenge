import UIKit

var greeting = "Hello, playground"


protocol Shape{
    func calculateArea() -> Double
}
class Rectangle: Shape{
    let width : Double
    let height :Double
    
    init(_width: Double, _height: Double){
        width = _width
        height = _height
    }
    
    func calculateArea() -> Double {
        return width * height
    }
    
}
 
class Circle: Shape{
    let radius:Double
    
    init(_radius:Double){
        radius = _radius
    }
    func calculateArea() -> Double{
        return Double.pi * radius * radius
    }
}
class Triangle: Shape{
    let base: Double
    let height: Double
    
    init(_base:Double,_height:Double){
        base = _base
        height = _height
    }
    
    func calculateArea() -> Double{
        return 0.5 * base * height
    }
}

class AreaCalculator{
    
    func area(shape: Shape) -> Double{
        return shape.calculateArea()
    }
   
}
let objAreaCalculate = AreaCalculator()
let objRectangle = Rectangle(_width: 2, _height: 2)
let objCircle = Circle(_radius: 10)
let objtriangle = Triangle(_base: 5, _height: 5)
//debugPrint("Area = \(objAreaCalculate.area(shape: objtriangle))")
//debugPrint("Area = \(objAreaCalculate.area(shape: objCircle))")
debugPrint("Area = \(objAreaCalculate.area(shape: objRectangle))")
