import UIKit

var greeting = "Hello, playground"


//MARK: - 1. Iterating Over an Array of Strings

let stringArray = ["Apple", "Banana", "Cherry"]

// Using for-in loop
for fruit in stringArray {
    print(fruit)
}

// Using forEach
stringArray.forEach { fruit in
    print(fruit)
}


//MARK: - 2. Iterating Over an Array of Integers

let intArray = [1, 2, 3, 4, 5]

// Using for-in loop
for number in intArray {
    print(number)
}

// Using forEach
intArray.forEach { number in
    print(number)
}



//MARK: - 3. Iterating Over a String Value

let stringValue = "Swift"

// Using for-in loop
for char in stringValue {
    print(char)
}

// Using forEach
stringValue.forEach { char in
    print(char)
}


//MARK: - 4. Iterating Over an Integer Value

let intValue = 5

// Iterating from 0 to intValue (exclusive)
for i in 0..<intValue {
    print(i)
}

// Iterating from 0 to intValue (inclusive)
for i in 0...intValue {
    print(i)
}


//MARK: - 5. Iterating Over a Dictionary

let dictionary = ["name": "Alice", "age": "25", "city": "New York"]

// Using for-in loop to iterate over key-value pairs
for (key, value) in dictionary {
    print("\(key): \(value)")
}

// Using forEach
dictionary.forEach { key, value in
    print("\(key): \(value)")
}

for key in dictionary.keys {
    print("key : --> \(key)")
}


for value in dictionary.values {
    print("value : --> \(value)")
}



//MARK: - 6. Iterating Over a Set

let set: Set = [10, 20, 30, 40]

// Using for-in loop
for value in set {
    print(value)
}

// Using forEach
set.forEach { value in
    print(value)
}


//MARK: - 7. Stride

for number in stride(from: 0, to: 10, by: 2) {
    print(number) // Output: 0, 2, 4, 6, 8
}

for number in stride(from: 10, through: 0, by: -2) {
    print(number) // Output: 10, 8, 6, 4, 2, 0
}




//MARK: - 8. Enumerated Iteration

let array = ["a", "b", "c"]

for (index, value) in array.enumerated() {
    print("Index \(index): \(value)")
}
// Output:
// Index 0: a
// Index 1: b
// Index 2: c


//MARK: - 9. Tuples

let person = ("Alice", 25, "iOS Developer")

print(person.0)  // Alice
print(person.1)  // 25

// Iterating Over an Array of Tuples

let employees = [("Alice", 25), ("Bob", 30), ("Charlie", 28)]
for (name, age) in employees {
    print("\(name) is \(age) years old")
}
