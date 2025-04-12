import UIKit

var greeting = "Hello, playground"


protocol HomeworkDelegate {
    func completeHomework()
}



class Teacher {
    var delegate: HomeworkDelegate? // A reference to the delegate

    func giveHomework() {
        print("Teacher: Assigning homework...")
        delegate?.completeHomework() // Calling delegate method
    }
}


class Student: HomeworkDelegate {
    func completeHomework() {
        print("Student: Completing homework!")
    }
}


let teacher = Teacher()
let student = Student()

teacher.delegate = student  // Assigning the delegate
teacher.giveHomework()

// Output:
// Teacher: Assigning homework...
// Student: Completing homework!
