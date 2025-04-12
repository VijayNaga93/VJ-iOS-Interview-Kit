import UIKit

var greeting = "Hello, playground"

let numbers = [1,2,3,4,5]

//MARK: - Map

let doubledNumbersCheck = numbers.map { $0 * 2 }



//MARK: - Filter

let filteresNumbers = numbers.filter{ $0 % 2 == 0 }



//MARK: - Reduce

let reducerdNumbers = numbers.reduce(0) { $0 + $1 }



//MARK: - Sort

let sortNumbers1 = numbers.sorted { $0 < $1 }
let sortNumbers2 = numbers.sorted { $0 > $1 }



//MARK: - Compact Map

let numbersWithNil = [1,2,nil,4,5]
let compactNumbers = numbersWithNil.compactMap { $0 }


//MARK: - Chaining

let chainedNumbers = numbersWithNil.compactMap { $0 }.map { $0 * 2 }



//MARK: - Custom Higher-Order Function

/*
 func performOperation(on numbers: [Int], using operation: (Int) -> Int) -> [Int] {
     return numbers.map(operation)
 }

 let doubledNumbers = performOperation(on: numbers) { $0 * 2 }
 print(doubledNumbers)  // Output: [2, 4, 6, 8, 10]
 */

//MARK: - Custom higher order function with map

func performOperations(numbers: [Int], operation: (Int) -> Int) -> [Int] {
    return numbers.map(operation)
}

//let temp = numbers.map(<#T##transform: (Int) throws(Error) -> T##(Int) throws(Error) -> T#>)

let doubledNumbers1 = performOperations(numbers: numbers) { value in
    value * 2
}

let doubleNumbers2 = performOperations(numbers: numbers, operation: { $0 * 2 })

let doubleNumbers3 = performOperations(numbers: numbers) { $0 * 2 }


//func square(_ value: Int) -> Int {
//    return value * value
//}


// Type - Seperate function

func square(value: Int) -> Int {
    return value * value
}

let squared1 = performOperations(numbers: numbers, operation: square)

let squared2 = performOperations(numbers: numbers, operation: square)


// Type - Seperate Closure

let squareClosure: ((Int) -> Int)

squareClosure = {  value in
    value * value
}

let squared3 = performOperations(numbers: numbers, operation: squareClosure)


//MARK: - Custom higher order function with filter

//numbers.filter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)

func filterNumbers(number: [Int], operation: (Int) -> Bool) -> [Int] {
    return number.filter(operation)
}
let evenNumbers = filterNumbers(number: numbers) { $0 % 2 == 0 }






