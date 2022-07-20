import UIKit
import Foundation

var greeting = "Hello, playground"
// Single responsibility Principle

struct EmployeeModel{
    let id : Int
    let name : String
    let address : String
}

class HttpHandler{
    func getDatafromApi() -> Data{
        return Data()
    }
}
class Parser{
    func parseApiResponse(data:Data) -> Array<EmployeeModel>{
        return Array<EmployeeModel>()
    }
}
class DataBaseHandler{
    func saveDataToDatabase(data: Array<EmployeeModel>) {
        
    }
}


class Employee
{
    let _httpHandler: HttpHandler
    let _parser: Parser
    let _dataBaseHandler: DataBaseHandler
    
    init(httpHandler: HttpHandler,parser: Parser,dataBaseHandler: DataBaseHandler) {
        _httpHandler = httpHandler
        _parser = parser
        _dataBaseHandler = dataBaseHandler
    }
    func getEmployeeData() -> Void {
        let employeeResponse = _httpHandler.getDatafromApi()
        let employeeDataArray = _parser.parseApiResponse(data:employeeResponse)
        _dataBaseHandler.saveDataToDatabase(data: employeeDataArray)
    }
}
let objEmployee = Employee(httpHandler: HttpHandler(), parser: Parser(), dataBaseHandler: DataBaseHandler())
