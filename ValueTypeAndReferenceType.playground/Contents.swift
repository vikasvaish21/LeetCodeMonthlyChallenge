import Foundation
import CoreFoundation
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
// MARK: Retain Cycle Working
//class Person{
//    var firstName: String
//
//    init(firstname: String){
//        self.firstName = firstname
//    }
//
//    func printName(name: String){
//        print("name is \(name)")
//    }
//
//    deinit {
//        print("\(firstName) is deinitilized")
//    }
//}
//
//var person: Person? = Person(firstname: "Naruto")
//print(CFGetRetainCount(person))
//var Person1 = person
//var Person2 = person
////print(CFGetRetainCount(person))
////person = nil
//print(CFGetRetainCount(person))
//Person1 = nil
//print(CFGetRetainCount(person))
//Person2 = nil
//print(CFGetRetainCount(person))
//person = nil
//

// MARK: example of Memory leak or Strong reference Cycle
//class A {
//    var b: B?
//    deinit {
//        print("A - deinit")
//    }
//}
//class B {
//    var a: A?
//    deinit {
//        print("B - deinit")
//    }
//}
//
//var a: A? = A()
//var b: B? = B()
//print(CFGetRetainCount(a))
//print(CFGetRetainCount(b))
//a?.b = b
//b?.a = a
//print(CFGetRetainCount(a))
//print(CFGetRetainCount(b))
//a = nil
//b = nil




// MARK: COPY on Write

func address(o: UnsafeRawPointer) -> NSString {
    let addr = Int(bitPattern: o)
    return NSString(format: "%p", addr)
}

struct Point {
    var p: Int
}
var pointA = [Point(p: 25), Point(p: 20)]
address(o: pointA)

//1
var pointB = pointA
address(o: pointB)
//2
////print(pointA === pointB)
//pointA[0].p = 10
//address(o: pointA)
//address(o: pointB)

// MARK: Closure having strong reference Cycle

class HTMLElement{
    let name : String
    let text : String?
    
    lazy var asHTML: () -> String = {/*[unowned self] in*/
        if let text = self.text{
            return "<\(self.name)>\(text)</\(self.name)>"
        } else{
            return "<\(self.name)>"
        }
    }

    init(name: String,text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit{
        print("HTMLElement \(name) is being deallocated")
    }
}


//let heading = HTMLElement(name: "h1")
//let defaultValue =  "some Default text"
//heading.asHTML = {
//    return "<\(heading.name)>\(heading.text ?? defaultValue)</\(heading.name)>"
//}
//var paragraph: HTMLElement? =  HTMLElement(name: "p", text: "some sample paragraph body text")
//print(paragraph!.asHTML())
//paragraph = nil


// MARK: Copy on Assigment



class MemoryAddress {

    static func printReferenceTypeAddress(reference: AnyObject) {
        print(Unmanaged.passUnretained(reference).toOpaque())
    }
    
    static func printValueTypeAddress(value: UnsafeRawPointer){
        let bitPattern = Int(bitPattern: value)
        print(NSString(format: "%p", bitPattern))
    }
}
struct Foo {
    let age = 1
}

class CopyOnAssignment:UIViewController{
    var var1 = Foo()
    override func viewDidLoad() {
        var var2 = var1
        MemoryAddress.printValueTypeAddress(value: &var1)
        MemoryAddress.printValueTypeAddress(value: &var2)
    }
}
var coa = CopyOnAssignment()
coa.viewDidLoad()


// MARK: Copy on Write

struct Maze{
    var root : Int
    init(withRoot _root: Int){
        root = _root
    }
}
class copyOnWrite: UIViewController{
    var newVar = [Maze(withRoot: 2)]
    override func viewDidLoad() {
        var newVar1 = newVar
        MemoryAddress.printValueTypeAddress(value: &newVar1)
        MemoryAddress.printValueTypeAddress(value: &newVar)
        newVar[0].root = 3
        MemoryAddress.printValueTypeAddress(value: &newVar1)
        MemoryAddress.printValueTypeAddress(value: &newVar)
    }
   
}


var cow = copyOnWrite()
//cow.viewDidLoad()
