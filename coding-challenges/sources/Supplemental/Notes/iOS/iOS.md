

# Swift

<details>
<summary>What are optionals in Swift and what are their benefits?</summary>

Optionals are a powerful feature in Swift that allow you to represent the absence of a value. In many cases, variables or constants in your code will have a specific value, such as a number, a string, or an object. However, there are situations where a value might not exist, such as when reading data from a file, making a network request, or interacting with user input.

In such situations, you can use optionals to indicate that a value might be missing, and provide a way to safely handle that absence. An optional is a type that can hold either a value of a certain type or no value at all. The benefit of optionals is that they help prevent runtime errors that can occur when trying to access a value that doesn't exist, by allowing you to check if a value exists before using it.

A good analogy to understand optionals in Swift is to think of them as a box that may or may not contain something. If the box contains something, you can use that thing. If the box is empty, you need to handle that case separately.

Here's an example of how optionals work in Swift. Let's say you have a variable name that might contain a string, or might not have a value at all:

```swift
var name: String?
```

The question mark ? at the end of the type annotation tells Swift that name is an optional string, which means it can either have a string value or no value at all.

To use the value of an optional, you can use optional binding to check if the optional has a value and unwrap it if it does. Here's an example of how to do this:

```swift
if let unwrappedName = name {
    print("Hello, \(unwrappedName)!")
} else {
    print("Hello, World!")
}
```

In this example, the if let statement checks if name has a value, and if it does, it unwraps the value and assigns it to a new constant unwrappedName. If name doesn't have a value, the else block is executed instead.

Optionals are a powerful feature that can help you write more robust and error-free code in Swift, especially in situations where values might be missing or unavailable.
</details>

<details>
<summary>What is the difference between value and reference types in Swift?</summary>

In Swift, there are two basic kinds of types: value types and reference types. The difference between them has to do with how they are stored in memory and how they are passed around in your code.

Value types are types that store their data directly in memory, and are copied when they are assigned to a new variable, passed as a parameter to a function, or returned from a function. This means that each copy of a value type has its own unique memory address, and changing the value of one copy does not affect the values of other copies.

Some examples of value types in Swift include:

Structs: Structs are a basic value type in Swift, and are used to encapsulate data and behavior. When you create a new instance of a struct, a copy of the struct is made in memory.
Enums: Enums are another value type in Swift, and are used to represent a finite set of possible values. When you create a new instance of an enum, a copy of the enum is made in memory.
Basic types: Basic types like Int, Double, and Bool are also value types in Swift, and are stored directly in memory.
A good analogy to understand value types in Swift is to think of them like apples. If you have two apples, and you take a bite out of one apple, the other apple is still whole and unchanged. Similarly, when you copy a value type in Swift, each copy has its own unique memory address, and changes made to one copy do not affect the values of other copies.

Reference types, on the other hand, are types that store a reference to their data in memory, and are not copied when they are assigned to a new variable, passed as a parameter to a function, or returned from a function. This means that multiple variables can reference the same underlying data in memory, and changes made to one variable will affect the values of all the other variables that reference the same data.

Some examples of reference types in Swift include:

Classes: Classes are a basic reference type in Swift, and are used to encapsulate data and behavior. When you create a new instance of a class, a reference to the class is made in memory.
Closures: Closures are another reference type in Swift, and are used to capture and encapsulate behavior. When you create a new closure, a reference to the closure is made in memory.
A good analogy to understand reference types in Swift is to think of them like tickets to a concert. If you have a ticket to a concert, and you give that ticket to a friend, you and your friend are both attending the same concert. Similarly, when you create a reference to a reference type in Swift, both the original reference and the new reference point to the same underlying data in memory, and changes made to one reference will affect the values of all the other references that point to the same data.
</details>

<details>
<summary>Which additional capabilities do classes provide compared to structs
in Swift?</summary>

In Swift, classes provide several additional capabilities compared to structs, including:

Inheritance: Classes allow you to define a new class that is a modified version of an existing class. This is known as inheritance, and it allows you to reuse code and behavior from existing classes, while also adding or modifying behavior as needed.

Type casting: Classes allow you to perform type casting to check the type of an instance at runtime, or to treat an instance as an instance of a subclass. This can be useful in situations where you need to perform different operations on instances of different classes.

Deinitialization: Classes provide a deinitializer, which is a method that is called automatically when an instance is deallocated. This allows you to perform cleanup operations or release resources that the instance was using.

Reference semantics: As I mentioned earlier, classes are reference types, which means that multiple variables can reference the same underlying data in memory. This can be useful in situations where you need to share data between different parts of your code, or when you need to modify a large object in place.

A good analogy to understand the differences between classes and structs in Swift is to think of them like blueprints for a house. A class is like a blueprint for a custom home, where you can modify the design or add additional rooms as needed. A struct, on the other hand, is like a blueprint for a pre-fabricated house, where the design is fixed and cannot be changed.

Here's an example of how inheritance works in Swift. Let's say you have a base class Person that defines basic information about a person, such as their name and age:

```swift
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sayHello() {
        print("Hello, my name is \(name)!")
    }
}
```

You can use inheritance to create a new class Employee that inherits from Person, and adds additional information about their job, such as their job title and salary:

```swift
class Employee: Person {
    var jobTitle: String
    var salary: Double
    
    init(name: String, age: Int, jobTitle: String, salary: Double) {
        self.jobTitle = jobTitle
        self.salary = salary
        super.init(name: name, age: age)
    }
    
    func sayJobTitle() {
        print("I am a \(jobTitle)!")
    }
}
```

In this example, the Employee class inherits all of the properties and methods of the Person class, and adds two new properties (jobTitle and salary) and one new method (sayJobTitle). By using inheritance, you can reuse the existing behavior and properties of the Person class, while also adding additional functionality specific to the Employee class.
</details>

<details>
<summary>What is protocol oriented programming? Which features do protocols have in Swift?</summary>

Protocol-oriented programming (POP) is a programming paradigm in Swift that emphasizes the use of protocols to define interfaces and behavior, instead of relying on class inheritance. In POP, you create small, composable protocols that define specific functionality or behavior, and then use those protocols to build complex, reusable systems.

Protocols in Swift are a type that defines a blueprint of properties, methods, and other requirements that a conforming type must implement. Protocols provide several key features in Swift, including:

Interface abstraction: Protocols allow you to abstract away the implementation details of a type and define a more general interface that can be used to interact with any conforming type. This can help make your code more modular and easier to test.

Composition: Protocols allow you to define small, composable units of behavior that can be combined to create larger, more complex systems. By breaking down your code into smaller, more manageable pieces, you can create code that is easier to understand and maintain.

Multiple inheritance: Unlike classes, Swift protocols support multiple inheritance, which means that a single type can conform to multiple protocols. This can help you avoid the problems of traditional class inheritance, such as tight coupling and the diamond problem.

Default implementations: Protocols in Swift can provide default implementations for methods and properties, which can make it easier to create conforming types by reducing the amount of boilerplate code that you need to write.

A good analogy to understand protocols in Swift is to think of them like a recipe. A recipe provides a set of instructions that define how to make a specific dish, and you can use that recipe to create the dish using different ingredients. Similarly, a protocol provides a set of requirements that define how to implement a specific behavior or functionality, and you can use that protocol to create different types that conform to the protocol.

Here's an example of how to use protocols in Swift. Let's say you have a protocol Animal that defines the basic behavior of an animal:

```swift
protocol Animal {
    var name: String { get }
    func makeSound()
}
```

In this example, the Animal protocol defines two requirements: a name property and a makeSound() method. Any type that conforms to the Animal protocol must provide an implementation for these requirements.

You can use this protocol to define different types of animals, such as a Dog:

```swift
struct Dog: Animal {
    var name: String
    
    func makeSound() {
        print("Woof!")
    }
}
```

In this example, the Dog struct conforms to the Animal protocol by providing implementations for the name property and the makeSound() method. By using protocols, you can create types that conform to a specific interface or behavior, while also providing the flexibility to swap out different implementations as needed.
</details>

# Memory Management

<details>
<summary>What is Automatic Reference Counting in Swift?</summary>

Automatic Reference Counting (ARC) is a memory management feature in Swift that automatically tracks and manages the memory usage of objects and deallocates them when they are no longer needed.

In Swift, every time you create an instance of a class, the runtime system allocates memory to store the instance's data and creates a reference to that instance. The reference count is the number of references to the instance. When the reference count drops to zero, it means that there are no more references to the instance, and the runtime system deallocates the memory used by the instance.

ARC automatically manages the reference count of objects in your code, ensuring that objects are deallocated as soon as they are no longer needed. ARC works by keeping track of the references to an object and incrementing and decrementing the reference count as references are added and removed.

ARC also provides a way to break retain cycles, which occur when two or more objects hold strong references to each other, creating a situation where their reference count never drops to zero. To break a retain cycle, you can use a weak or unowned reference to one of the objects, which does not increment the reference count and allows the reference count to drop to zero when the other references are removed.

Here's an example of a simple class that uses ARC:

```swift
class Person {
    var name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var person1: Person?
var person2: Person?
var person3: Person?

person1 = Person(name: "Alice")
person2 = person1
person3 = person1

person1 = nil
person2 = nil
person3 = nil
```

In this example, three Person instances are created and assigned to the variables person1, person2, and person3. When these variables are set to nil, the reference count of

One possible analogy for Automatic Reference Counting (ARC) in Swift is a library book checkout system.

When a library user checks out a book, the librarian notes that the book has one reference, because one person is currently using it. If another library user checks out the same book, the librarian notes that the book has two references, because two people are currently using it. When a user returns a book, the librarian notes that the book has one less reference, because one user is no longer using it. When the reference count of the book drops to zero, the book is no longer in use, and can be removed from the system.

In this analogy, the books are objects in memory, and the library users are the references to those objects. When a reference is created to an object, the reference count is incremented. When a reference is removed, the reference count is decremented. When the reference count of an object drops to zero, it means that the object is no longer in use, and can be deallocated.

Just as a library book checkout system ensures that books are only removed from the system when they are no longer in use, ARC in Swift ensures that objects are only deallocated when they are no longer needed. By automatically managing the reference count of objects in memory, ARC ensures that memory is used efficiently and that objects are deallocated in a safe and controlled manner.
</details>

<details>
<summary>What is the difference between a weak and a strong reference?</summary>

In Swift, references are used to keep track of objects in memory. There are strong and weak references. The main difference between the two is how they affect the reference count of an object and its lifetime.

A strong reference is the default type of reference in Swift. When you create a strong reference to an object, the reference count of the object is incremented by 1, and the object remains in memory as long as there is at least one strong reference to it. When all strong references to an object are removed, the reference count drops to 0, and the object is deallocated.

A weak reference, on the other hand, does not increment the reference count of an object. When you create a weak reference to an object, the object's reference count is not increased, and the object remains in memory only if there is at least one strong reference to it. If all strong references to an object are removed, the reference count drops to 0, and the object is deallocated, regardless of whether there are any weak references to it.

The primary use case for weak references is to avoid retain cycles, which occur when two or more objects hold strong references to each other, creating a situation where their reference count never drops to zero. By using a weak reference to one of the objects, you break the retain cycle and ensure that the objects are deallocated when they are no longer needed.

Here's an example of how to use a weak reference in Swift:

```swift
class Person {
    var name: String
    weak var spouse: Person?
    init(name: String) {
        self.name = name
    }
}

var alice: Person? = Person(name: "Alice")
var bob: Person? = Person(name: "Bob")

alice?.spouse = bob
bob?.spouse = alice

alice = nil
bob = nil // both Person instances are now deallocated
```

In this example, two Person instances are created and assigned to the variables `alice` and `bob`. When the spouse property is set for each person, a weak reference is used to avoid creating a retain cycle. When `alice` and `bob` are set to `nil`, the reference count of each instance is decremented, and the `deinit` method is called for each instance, which prints a message indicating that the instance is being deallocated.

In summary, a strong reference increments the reference count of an object, and keeps the object in memory as long as there is at least one strong reference to it, while a weak reference does not increment the reference count, and does not prevent the object from being deallocated when all strong references to it are removed.

</details>

<details>
<summary>What the difference between a weak and an unowned reference?</summary>

In Swift, there are two types of reference that don't keep a strong hold on the object they reference: weak and unowned references. While both types of reference are used to break strong reference cycles and avoid memory leaks, they differ in how they behave when the object being referenced is deallocated.

A weak reference is used when the referenced object can be deallocated, and the reference must be set to nil automatically. The variable holding the weak reference is optional and can be set to nil at any time. If the object is deallocated, the weak reference is automatically set to `nil` to avoid accessing deallocated memory. In other words, _a weak reference is optional and can never be assumed to have a value_.

An unowned reference is used when it is known that the referenced object will never be deallocated before the reference is used. The variable holding the unowned reference is non-optional and is not set to nil automatically. If the object is deallocated before the reference is used, a runtime error will occur. In other words, _an unowned reference is non-optional and must have a value at all times_.

Here's an example that demonstrates the difference between weak and unowned references:

```swift
class Person {
    var name: String
    weak var spouse: Person?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deallocated")
    }
}

class Apartment {
    var unit: String
    unowned var tenant: Person
    init(unit: String, tenant: Person) {
        self.unit = unit
        self.tenant = tenant
    }
    deinit {
        print("Apartment \(unit) is being deallocated")
    }
}

var alice: Person? = Person(name: "Alice")
var bob: Person? = Person(name: "Bob")
alice?.spouse = bob
bob?.spouse = alice

var apartment: Apartment? = Apartment(unit: "101", tenant: alice!)

alice = nil
bob = nil
apartment = nil // Prints "Alice is being deallocated" and "Apartment 101 is being deallocated"
```

In this example, two `Person` instances are created and assigned to the variables `alice` and `bob`. A weak reference is used to break the strong reference cycle between the two instances. An `Apartment` instance is also created, with a non-optional unowned reference to the `alice` instance. When `alice`, `bob`, and `apartment` are set to nil, the reference count of each instance is decremented, and the `deinit` method is called for each instance, which prints a message indicating that the instance is being deallocated.

In summary, the difference between weak and unowned references is that a weak reference is optional and can be set to nil automatically, while an unowned reference is non-optional and can result in a runtime error if the referenced object is deallocated before the reference is used.
</details>

# Design Patterns

<details>
<summary>What is the delegate pattern?</summary>

The delegate pattern is a common design pattern used in iOS and other software platforms. It is used to define a one-to-one relationship between two objects, where one object acts as a delegate for the other object, and provides custom behavior in response to specific events or requests.

The delegate pattern can be implemented using protocols or closures. Here's an example of each approach:

$ Protocol-based delegate
In this example, we will define a protocol for a view controller delegate that can be used to customize the behavior of a custom view.

```swift
protocol CustomViewDelegate: AnyObject {
    func customViewDidTapButton(_ customView: CustomView)
}
```

The protocol defines a single method that will be called when a button in the custom view is tapped.

```swift
class CustomView: UIView {
    weak var delegate: CustomViewDelegate?
    
    @IBAction func buttonTapped() {
        delegate?.customViewDidTapButton(self)
    }
}
```

The CustomView class defines a weak reference to a delegate object, and calls the delegate method when the button is tapped.

```swift
class ViewController: UIViewController, CustomViewDelegate {
    @IBOutlet weak var customView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
    }
    
    func customViewDidTapButton(_ customView: CustomView) {
        print("Button tapped")
    }
}
```

The view controller implements the CustomViewDelegate protocol, and sets itself as the delegate for the custom view. When the button is tapped, the customViewDidTapButton method is called on the view controller.

# Closure-based delegate

In this example, we will define a closure property that can be used to customize the behavior of a custom view.

```swift
class CustomView: UIView {
    var buttonTapHandler: (() -> Void)?
    
    @IBAction func buttonTapped() {
        buttonTapHandler?()
    }
}
```

The CustomView class defines a closure property that will be called when the button is tapped.

```swift
class ViewController: UIViewController {
    @IBOutlet weak var customView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.buttonTapHandler = {
            print("Button tapped")
        }
    }
}
```

The view controller sets the closure property on the custom view, and defines the behavior to be executed when the button is tapped.

Overall, the choice between protocol-based and closure-based delegation depends on the specific requirements of your application. Protocol-based delegation can be more flexible and expressive, but requires more boilerplate code. Closure-based delegation can be more concise and easier to read, but may be less flexible in some cases.

</details>

<details>
<summary>What is the observer pattern?</summary>

The Observer pattern is a design pattern used to define a one-to-many dependency between objects, so that when one object changes state, all its dependents are notified and updated automatically. The subject maintains a list of its dependents (observers) and notifies them automatically of any changes, usually by calling a method on the observer.

In iOS, the Observer pattern is commonly used for event handling and notification mechanisms. Here are a few ways to implement the Observer pattern in iOS:

# Key-Value Observing (KVO)

Key-Value Observing (KVO) is a built-in mechanism provided by Cocoa and Cocoa Touch that allows objects to observe changes to the properties of another object. You can register an observer for a specific key path on an object, and the observer will be notified whenever the value of that key path changes.

Here's an example of using KVO to observe changes to a property on a view controller:

```swift
class MyViewController: UIViewController {
    @objc dynamic var myProperty: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver(self, forKeyPath: "myProperty", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "myProperty" {
            // do something when the property changes
        }
    }
}
```

In this example, the view controller's `myProperty` property is marked as dynamic and observed using the `addObserver(_:forKeyPath:options:context:)` method. When the property changes, the `observeValue(forKeyPath:of:change:context:)` method is called on the observer, and the observer can update its state or take other actions as needed.

# NotificationCenter

NotificationCenter is another built-in mechanism provided by Cocoa and Cocoa Touch that allows objects to communicate with each other without having to know about each other directly. Objects can register to receive notifications from the notification center, and can be notified automatically when a notification is posted.

Here's an example of using NotificationCenter to post and receive a notification:

```swift
// post a notification
NotificationCenter.default.post(name: Notification.Name("MyNotification"), object: nil)

// register to receive the notification
NotificationCenter.default.addObserver(forName: Notification.Name("MyNotification"), object: nil, queue: nil) { notification in
    // do something when the notification is received
}
```

In this example, the first line posts a notification with the name "MyNotification". The second line registers to receive the notification, and the closure is executed when the notification is received.

# Combine

In Combine, a Publisher emits values over time, and one or more Subscribers receive and handle those values. Publishers and Subscribers are generic types that can be used with a wide range of data types, and can be composed and combined in powerful ways to create complex data flow pipelines.

To implement the Observer pattern using Combine, you can mark a property of an object as `@Published`, which makes it a publisher. Then, you can use the `$` syntax to create a key path to the published property, which can be used to create a subscriber that will be notified when the property's value changes.

For example, here's how you could use Combine to observe changes to a property on an object:
```swift
import Combine

class MyObject {
    @Published var myProperty: String = ""
}

let myObject = MyObject()

let cancellable = myObject.$myProperty.sink { newValue in
    print("myProperty changed to \(newValue)")
}

myObject.myProperty = "new value"
```

In this example, the `MyObject` class has a property `myProperty` that is marked with `@Published`, which makes it a publisher. The `$myProperty` syntax creates a key path to the published property, which can be used to create a subscriber using the `sink` method. When the property is changed, the subscriber closure is called with the new value.

# Delegation

Delegation is a mechanism that allows **one object to customize the behavior of one other object**, often in response to specific events or requests. The delegate object conforms to a protocol that defines the methods that can be called by the other object.

Here's an example of using delegation to customize the behavior of a custom view:

```swift
protocol CustomViewDelegate: AnyObject {
    func customViewDidTapButton(_ customView: CustomView)
}

class CustomView: UIView {
    weak var delegate: CustomViewDelegate?
    
    @IBAction func buttonTapped() {
        delegate?.customViewDidTapButton(self)
    }
}

class MyViewController: UIViewController, CustomViewDelegate {
    let customView = CustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
    }
    
    func customViewDidTapButton(_ customView: CustomView) {
        // do something when the button is tapped
    }
}
```

In this example, the `CustomViewDelegate` protocol defines a method that will be called by the custom view when the button is tapped. The `CustomView` class defines a weak reference to a delegate object, and calls the delegate method when the button is tapped. The `MyViewController` class implements the `CustomViewDelegate` protocol, and sets itself as the delegate for the custom view. When the button is tapped, the `customViewDidTapButton` method is called on the view controller.

</details>

# Concurrency

<details>
<summary>What is concurrency?</summary>

Concurrency is a programming technique that involves executing multiple tasks or operations at the same time, in order to improve performance, responsiveness, and user experience. Concurrency is especially important in iOS development, where users expect apps to be fast, responsive, and able to handle multiple tasks simultaneously.

There are a variety of tools and techniques available for implementing concurrency in iOS, including:

1. Grand Central Dispatch (GCD): GCD is a low-level API provided by Apple for concurrent programming. It provides a simple and efficient way to execute code on a background thread, and can be used to perform tasks asynchronously and in parallel. GCD uses dispatch queues to manage the execution of tasks, and provides both serial and concurrent queues.
2. Operation and OperationQueue: The Operation and OperationQueue classes provide a higher-level abstraction for concurrent programming. They allow you to define and manage complex tasks as individual operations, which can be combined and scheduled on an operation queue. Operations can also be cancelled, paused, and resumed, and can be used to implement dependency chains and priorities.
3. Asynchronous Programming with Async/Await: Swift's Async/Await feature provides a declarative way to write asynchronous code, using familiar and intuitive syntax. Async/Await allows you to write code that looks and behaves like synchronous code, but is executed asynchronously on a background thread. Async/Await can be used in combination with other concurrency techniques, such as GCD and OperationQueue.
4. Combine: Combine is a reactive programming framework that provides a declarative and composable way to handle asynchronous events and data streams. Combine uses publishers and subscribers to create data flow pipelines that can handle complex asynchronous logic, and can be used to implement reactive user interfaces, network requests, and more.
</details>

<details>
<summary>What is a race condition?</summary>

A race condition is a common problem in concurrent programming where the behavior of an application is dependent on the timing or order of events, and where the outcome of those events is unpredictable or undefined. A race condition occurs when two or more threads or processes access a shared resource at the same time, and at least one of the accesses is a write operation. The order of these accesses is not deterministic or predictable, and the outcome of the program can be unpredictable or undefined.

Race conditions can result in a variety of problems, including data corruption, memory leaks, crashes, deadlocks, or unexpected behavior. For example, if two threads are both trying to increment the value of a shared variable, it's possible that the final value of the variable will not be the expected result, because the two threads may overwrite each other's changes.

Race conditions can be difficult to detect and reproduce, because their behavior is dependent on the timing and execution order of events, which can vary from run to run or from one system to another. To avoid race conditions, it's important to use appropriate synchronization techniques, such as locks, semaphores, and atomic operations, to ensure that only one thread or process can access a shared resource at a time. It's also important to write code that is resilient to race conditions, by using defensive programming techniques, error handling, and testing.

</details>

<details>
<summary>What is a deadlock?</summary>

A deadlock is a situation in concurrent programming where two or more threads or processes are waiting for each other to release a shared resource, such as a lock or a mutex. As a result, each thread is blocked, and unable to proceed with its execution, leading to a standstill or a "deadlock" situation.

Deadlocks can occur when two or more threads or processes have acquired different resources, and each one needs the other resource to proceed. For example, if thread A is holding a lock on resource X, and thread B is holding a lock on resource Y, but both threads need access to both resources X and Y to proceed, they can become deadlocked.

Deadlocks can also occur when one thread is waiting for another thread to complete, but the second thread is also waiting for the first thread to complete. This can occur if both threads are blocking on a condition variable or other synchronization mechanism, and neither one can proceed until the other does.

Circular waits such as this can occur in any system that uses locks or other forms of synchronization to manage concurrent access to shared resources. They can be especially common in distributed systems, where multiple nodes or processes are coordinating their activities, but can also occur in single-machine systems.

Deadlocks can be a serious problem in concurrent programming, because they can cause a program to hang or crash, and can be difficult to detect and diagnose. To avoid deadlocks, it's important to use appropriate synchronization techniques, such as locks, semaphores, and condition variables, to ensure that threads are not blocking each other indefinitely. It's also important to design your program to avoid circular dependencies or infinite loops that can lead to deadlocks.
</details>
