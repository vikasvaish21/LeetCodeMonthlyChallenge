import UIKit

var greeting = "Hello, playground"


// control Flow


enum CompassPoint{
    case north
    case south
    case east
    case west
}


//enum planet {
//    case mercury
//    case venus
//    case earth
//    case mars
//    case jupiter
//    case saturn
//    case uranus
//    case neptune
//}

//func getThePlane(_ compassPoint: CompassPoint) -> String{
//    switch compassPoint {
//    case .north:
//        return "Lots of planets have a north"
//    case .south:
//        return "Watch out for penguins"
//    case .east:
//        return "Where the sun Rises"
//    case .west:
//        return "Where the skies are blue"
//    }
//}

func getThePlane(_ compassPoint: CompassPoint) -> String{
    if compassPoint == .north{
        return "nil"
    } else{
        return "Hate"
    }
}

getThePlane(.north)


enum BarCode {
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}

//var productBarCode = BarCode.upc(8, 85909, 51226, 3)
//productBarCode = .qrCode("ABCDEFGHIJKLMNOP")


//switch productBarCode{
//case .upc(let numberSystem,let manufacture,let product,let check):
//    print("upc: \(numberSystem),\(manufacture),\(product),\(check)")
//case .qrCode(let productCode):
//    print("QR code: ABCDEFGHIJKLMNOP ")
//}


enum ASCIIControlCharacter: Character{
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn  = "\r"
}

let aSCIIControl = ASCIIControlCharacter.lineFeed.rawValue


enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
let earthOrder = Planet.earth.rawValue


// MARK: - Closure

var Sumation:(Int,Int) -> Int = { (number1,number2) -> Int in
    return number1 + number2
}



//var Sumation:(Int,Int) -> Int = {
//    return $0 + $1
//}
//Sumation(7, 8)

typealias AddTwoNumberClosure = (_ number1: Int,_ number2: Int) -> Int
let additionalClosure : AddTwoNumberClosure = { (_ number1: Int,_ number2: Int) -> Int in  number1 + number2
}
//additionalClosure(9, 9)


func printGoodMorningMessage(isMorning: Bool,name: @autoclosure () -> String){
    if (isMorning){
        debugPrint("Good Morning \(name())")
    }
}

func assignName(name: String) -> String{
    debugPrint("assignName is called")
    return name
}

//printGoodMorningMessage(isMorning: true) { () -> String in
//    assignName(name: "ravi")
//}
//printGoodMorningMessage(isMorning: false){ () -> String in assignName(name: "codeCat15")
//}

//printGoodMorningMessage(isMorning: true, name: assignName(name: "Ravi"))
//printGoodMorningMessage(isMorning: false, name: assignName(name: "codeCat15"))


func getData(){
    let session = URLSession.shared
    let serviceUrl = URL(string: "http://jsonplaceholder.typicode.com/todos/1")
    let task = session.dataTask(with: serviceUrl!) { (serviceData, serviceResponse, error) in
        if error == nil{
            let response = serviceResponse as! HTTPURLResponse
            if response.statusCode == 200 {
                let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
                let result = jsonData as! [String:Any]
                print("id = \(result["id"] ?? 0)")
            }
        }
    }
    task.resume()
}
getData()

struct EndPoint{
    static let registerUser = "https://api-football-v1.p.rapidapi.com/v3/leagues"
    static let getUser = "https://api-football-v1.p.rapidapi.com/v3/leagues"
}


struct UserRegistrationRequest: Encodable{
    let FirstName,LastName,Email,Password : String
    enum CodingKeys: String,CodingKey{
        case FirstName = "First_Name"
        case LastName = "Last_Name"
        case Email,Password
    }
}

struct DataClass : Codable{
    let name ,email,id,joining: String
}

struct Welcome: Codable{
    let errorMessage: String
    let data: DataClass
}

struct User{
    func registerUser() {
        var urlRequest = URLRequest(url: URL(string: EndPoint.registerUser)!)
        urlRequest.httpMethod = "post"
        var dataDict = ["name": "Vikas","email": "Vikasvash08@gmail.com","password":"1234"]
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDict,options: .prettyPrinted)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error{
            debugPrint(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: urlRequest) {( data, httpUrlResponse, error )in
            if data != nil && data?.count != 0{
                let response = String(data: data!, encoding: .utf8)
                debugPrint(response!)
            }
        }.resume()
    }
    
    func registerUserWithEncodableProtocol(){
        var urlRequest = URLRequest(url: URL(string: EndPoint.registerUser)!)
        urlRequest.httpMethod = "post"
        let request = UserRegistrationRequest(FirstName: "Vikas", LastName: "Vash", Email: "Vikasvash08@gmail.com", Password: "1234")
        do {
            let requestBody = try JSONEncoder().encode(request)
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        } catch let error{
            debugPrint(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: urlRequest) {( data, httpUrlResponse, error )in
            if data != nil && data?.count != 0{
                let response = String(data: data!, encoding: .utf8)
                debugPrint(response!)
            }
        }.resume()
    }
    
    
    func GetUserFromServer() {
        let headers = [
            "X-RapidAPI-Key": "d61b8c1008msh8a1e6ec8f396d7fp1dd593jsn8a2d76e5a5a3",
            "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"
        ]
        var urlRequest = URLRequest(url: URL(string: EndPoint.getUser)!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: urlRequest) { (data, dataResponse, error)in
            if data != nil && data?.count != 0{
//                let response = String(data: data!, encoding: .utf8)
                do {
                    let response =  try JSONSerialization.jsonObject(with: data!,options: .mutableContainers)
                    debugPrint(response)
                } catch{
                    debugPrint(error.localizedDescription)
                }
                
            }
        }.resume()
    }
}

var temp = User()
temp.GetUserFromServer()

struct EmployeeResponse:Decodable{
    let id : Int
    let dep_id : Int
    let salary : Double
    let name,role,joining_date,workPhone:String
}


struct ReportResponse: Decodable{
    let reports: [Report]
}

struct Report: Decodable {
    let id, labourHours, totalcost: String
    
}

struct HttpUtility{
    func getApiData<T:Decodable>(requestUrl:URL,completionHandler:@escaping (_ result:T) -> Void) {
        
    }
}

struct Employee{
    func getEmployeeData(){
        let employeeAPiUrl = "http://demo0333988.mockable.io/Employees"
        URLSession.shared.dataTask(with: URL(string: employeeAPiUrl)!) {( responseData, httpApiResponse, error ) in
            if (error == nil && responseData != nil && responseData?.count != 0){
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(EmployeeResponse.self, from: responseData!)
                    debugPrint(result.joining_date)
                } catch let error{
                    debugPrint("error occured while decodong = \(error.localizedDescription)")
                }
                
            }else{
                print("not working")
            }
        }.resume()
    }
    
    
    func getReport(){
        var reportURL = "http://demo0333988.mockable.io/getReports"
        URLSession.shared.dataTask(with: URL(string: reportURL)!) {( responseData, httpApiResponse, error ) in
            if (error == nil && responseData != nil && responseData?.count != 0){
                let decoder = JSONDecoder()
                do{
                    let reportResult = try decoder.decode(ReportResponse.self, from: responseData!)
                    for report in reportResult.reports{
                        debugPrint(report.labourHours)
                    }
                } catch let error{
                    debugPrint("error occured while decodong = \(error.localizedDescription)")
                }
                
            }else{
                print("not working")
            }
        }.resume()
    }
}
let objUser = User()
//objUser.registerUser()
//objUser.registerUserWithEncodableProtocol()
//objUser.GetUserFromServer()
//var emp = Employee()
//emp.getReport()


//protocol Coordinator: AnyObject {
//    var navigationController : UINavigationController{get set}
//    func configureRootViewController()
//}
//
//
//class MainCoordinator:Coordinator{
//    var navigationController: UINavigationController
//    init(with _navigationController: UINavigationController){
//        self.navigationController  = _navigationController
//    }
//}
//
//protocol cooordinatorBoard: UIViewController{
//    static func istantiateFromStoryBoard
//}

let numbers :[Int] = [0,2,1,3,6,4,9,7,8]
//let evenNumbersFirst = numbers.sorted{ (a,b) in
//     a % 2 == 0
//}
//let decendingNumbers = numbers.sorted { (a, b) -> Bool in
//    return a > b
//}

let numberAsString = numbers.map { a -> String in
   return String(a)
}
//print(numberAsString)


//let numberLessThanFive = numbers.filter { (a) in
//    return a < 5
//}
let numberLessThanFive = numbers.filter { (a) in
    return a < 5
}
//print(numberLessThanFive)


let sumOfAllNumbers = numbers.reduce("") { partialResult, a in
    partialResult + String(a)
}
//print(sumOfAllNumbers)

//
//private let concurrentQueue = DispatchQueue(label: "com.gcd.dispatchBarrier",attributes: .concurrent)
//
//for value in 1...5{
//    concurrentQueue.async(flags: .barrier)  {
//        print("async \(value)")
//    }
//}
//
//for value in 6...10{
//    concurrentQueue.async {
//        print("barrier \(value)")
//    }
//}
//
//for value in 11...15{
//    concurrentQueue.async   {
//        print("sync \(value)")
//    }
//}

let queue = DispatchQueue(label: "thread-safe-array")

var arr = [1,2,3,4,5]
// write
queue.async() {
    // perform writes on data
    var last = arr.removeLast()
//    print(arr)
}

// read
queue.async() {
    // perform read and assign value
//    print(arr)
}


struct Foo {
    let age = 1
}

class NewAssignment{
    func testCopyOnAssignment() {
        var var1 = Foo()
        var var2 = var1
        withUnsafePointer(to: &var1) {
            print("\($0)") // print address (Ex: 0x00007ffee6702fb0)
        }
        withUnsafePointer(to: &var2) {
            print("\($0)") // print different address (Ex: 0x00007ffee6702fa8)
        }
    }
}
var newAs = NewAssignment()
newAs.testCopyOnAssignment()



var serialQueue = DispatchQueue(label: "concurrentQueue",attributes: .concurrent)
var numbersArray: String = ""
for i in 0...5{
    numbersArray += "\(i) "
}
//print(numbersArray)

queue.async {
    numbersArray = ""
    for j in 6...10{
        numbersArray += "\(j) "
    }
//    print(numbersArray)
}
queue.async {
    numbersArray = ""
    for k in 11...15{
        numbersArray += "\(k) "
    }
//    print(numbersArray)
}
numbersArray = ""
for l in 16...20{
    numbersArray += "\(l) "
}
//print(numbersArray)


var findSum : (_ number1: Int,_ number2: Int) -> Int = { (number1,number2) in
    number1 + number2
}
//findSum(11, 22)




func captureFunction(){
    var A = 100
    var captureClosure: () -> Void = { [A] in
//        print(A)
    }
    
    captureClosure()
    A = 200
    captureClosure()
    A = 300
    captureClosure()
}
//captureFunction()


protocol Product {
    associatedtype Code
    var productCode: Code { get }
    func description() -> String
}

struct Laptop : Product{
    
    typealias Code = String
    var productCode: String
    func description() -> String {
        "This is a Laptop"
    }
}
struct KeyBoard: Product{
    typealias Code = Int
    var productCode: Int
    func description() -> String {
        "This is a KeyBoard"
    }
    
   
}
struct Factory{
    func makeProduct() -> some Product{
        return Laptop(productCode: "test")
    }
    func makeProduct() -> Laptop{
        return Laptop(productCode: "test")
    }
    func makeProduct() -> KeyBoard{
        return KeyBoard(productCode: 1)
    }
}

func SquareArray<T:Numeric>(array:Array<T>) -> LazyMapSequence<Array<T>,T>{
    return array.lazy.map { $0 * $0
    }
}


struct Example {
    var length : String
    var breadth : String
}

extension Example{
    init(name: String){
        let split = name.components(separatedBy: " ")
        length = split.first ?? ""
        breadth =  split.last ??  ""
        
    }
}

struct LoanCalculator{
    var loanAmount: Int
    var rateOfInterest: Int
    var year :Int
    var simpleInterest: Int {
        get {
            return (loanAmount * rateOfInterest * year)/100
        }
        
    }
}
//let loanCalculator = LoanCalculator(loanAmount:500000,rateOfInterest:10,year:5)
//debugPrint("Interest amount = \(loanCalculator.simpleInterest)")


struct Circle{
    
    var radius: Double = 0
    var area: Double{
        get {
            return radius * radius * Double.pi
        }
        set{
            radius = sqrt(newValue/Double.pi)
        }
    }
}
//var circle = Circle()
//circle.radius = 5
//debugPrint("area = \(circle.area)")



//circle.area = 25
//debugPrint("area = \(circle.radius)")


protocol SomeProtocol{
    var mustBeSettable:Int{
        get
        set
    }
    var doesNotNeedToBeSettable:Int{
        get
        set
    }
}


protocol FullyNamed{
    associatedtype Code
    var productCode:Code{get}
    func description() -> String
    
}


struct Student:FullyNamed{
    typealias Code = String
    var productCode: String
    func description() -> String {
        return "Name of Student"
    }
}

struct Teacher:FullyNamed{
    typealias Code = String
    var productCode: String
    func description() -> String {
        return "Name of Teacher"
    }
}

struct NewFactory{
    func makeProduct() -> some FullyNamed{
        return  Student(productCode: "test")
    }
    func makeProduct() -> Student{
        return Student(productCode: "test")
    }
    func makeProduct() -> Teacher{
        return Teacher(productCode: "test")
    }
}

//MARK: -  Dependency operation

enum Subject {
    case english
    case Hindi
    case Math
}

//func School(_ name: Subject) -> String{
//    switch name{
//    case .Hindi:
//        return print("Don't know much")
//    case .english:
//        return print("Itermediate")
//    case .Math:
//        return print("Expert")
//    }
//}
//School(.Math)
