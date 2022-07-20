import UIKit

var greeting = "Hello, playground"
protocol Shape{
    var area : Double{
        get
    }
}

class Rectangle:Shape {
    var width : Double = 0
    var length : Double = 0
    
    var area : Double{
        return width * length
    }
}

class Square: Shape {
    var width: Double = 0
    var area : Double{
        return pow(width, 2)
    }
}

let objReactangle = Rectangle()
objReactangle.length = 5
objReactangle.width = 2
debugPrint("area of rectangle = \(objReactangle.area)")
let objSquare = Square()
objSquare.width = 3
debugPrint("area of Square = \(objSquare.area)")
