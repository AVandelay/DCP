

# Automatic Reference Counting

<details>
<summary>What Is Automatic Reference Counting (ARC)</summary>

In the world of programming, there are two basic ways to handle data: value types and reference types. Value types, as the name suggests, store a value directly, while reference types store a reference to the value.

Let me give you an analogy. Imagine you have a book in your hand. That book is a value type. It exists in its own right, with its own content, pages, and cover. You can hold it, move it around, and even copy it, but each copy will be its own separate book with its own separate content.

Now, imagine you have a library card. That library card is a reference type. It doesn't contain any actual books, but it points to a specific book in the library. You can give the card to someone else and they can use it to access the same book. If you lose the card, you won't be able to access the book anymore, but the book itself will still be there.

When it comes to memory management, reference types can pose a challenge. If you have two objects that reference each other, and neither of them is referenced by anything else, you have what's called a strong reference cycle. Let me give you an example in code:

```swift
class Person {
    var name: String
    var car: Car?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Car {
    var model: String
    var owner: Person?
    
    init(model: String) {
        self.model = model
    }
    
    deinit {
        print("Car with model \(model) is being deinitialized")
    }
}

var john: Person?
var honda: Car?

john = Person(name: "John")
honda = Car(model: "Civic")

john?.car = honda
honda?.owner = john

john = nil
honda = nil
```

In this example, we have two classes: `Person` and `Car`. A Person can have a Car, and a Car can have an owner who is a Person. We create two optional variables, `john` and `honda`, and assign them to `nil`. Then, we create instances of `Person` and `Car`, and assign them to these variables.

Next, we set john's car property to honda, and honda's owner property to john. This creates a strong reference cycle between john and honda. Neither object can be deallocated because each object has a strong reference to the other.

To break this strong reference cycle, we can use `weak` or `unowned` references. These are types of references that don't create a strong reference count, which means they won't keep the object alive. 

To solve this problem, Swift uses Automatic Reference Counting (ARC). ARC is a mechanism that tracks the number of references to an object and automatically deallocates it when there are no more references to it.

ARC keeps a count of the number of strong references to an object. When the count goes to zero, the object is deallocated. ARC is able to handle strong reference cycles, but we need to be careful when using reference types to avoid creating these cycles.
</details>

<details>
<summary>What Are Strong Reference Cycles</summary>
In Swift, a strong reference is a reference that keeps an object alive. When you create a new instance of a class, a strong reference is automatically created to that instance. As long as there is at least one strong reference to an object, it will remain alive in memory.

However, this can lead to a problem called a strong reference cycle. A strong reference cycle occurs when two or more objects hold strong references to each other, creating a loop that prevents either object from being deallocated. Let's explore a few examples of how this can happen.

Delegation is a common design pattern in which one object delegates certain tasks or responsibilities to another object. Let's say we have a Person object that has a Car object, and we want to delegate the responsibility of driving the car to the Person. We might set up our code like this:
```swift
class Person {
    var car: Car?
    
    func drive() {
        car?.startEngine()
    }
    
    deinit {
        print("Person is being deinitialized")
    }
}

class Car {
    var owner: Person?
    
    func startEngine() {
        print("Engine started")
    }
    
    deinit {
        print("Car is being deinitialized")
    }
}

var john: Person?
var honda: Car?

john = Person()
honda = Car()

john?.car = honda
honda?.owner = john

john = nil
honda = nil
```
In this example, we have a Person object and a Car object. The Person object has a strong reference to the Car object via the car property, and the Car object has a strong reference to the Person object via the owner property. This creates a strong reference cycle between john and honda.

Another way strong reference cycles can occur is through dependencies. Let's say we have a Game object that depends on a Player object, and the Player object depends on the Game object. We might set up our code like this:
```swift
class Game {
    var player: Player?
    
    func start() {
        player?.play()
    }
    
    deinit {
        print("Game is being deinitialized")
    }
}

class Player {
    var game: Game?
    
    func play() {
        print("Playing the game")
    }
    
    deinit {
        print("Player is being deinitialized")
    }
}

var game: Game?
var player: Player?

game = Game()
player = Player()

game?.player = player
player?.game = game

game = nil
player = nil
```
In this example, we have a Game object and a Player object. The Game object has a strong reference to the Player object via the player property, and the Player object has a strong reference to the Game object via the game property. This creates a strong reference cycle between game and player.

Finally, closures can also create strong reference cycles. Let's say we have a ViewController object that has a closure that updates a label on the view controller. We might set up our code like this:

```swift
class ViewController {
    var updateLabelClosure: (() -> Void)?
    
    func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabelClosure = { [weak self] in
            self?.label.text = "Updated Label"
        }
    }
    
    deinit {
        print("ViewController is being deinitialized")
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Initial Label"
        return label
    }()
}

var viewController: ViewController?

viewController = ViewController()
viewController?.updateLabelClosure?()

viewController = nil
```
In this example, we have a ViewController object with a label property that is updated by a closure. The closure captures a weak reference to the ViewController object to avoid creating a strong reference cycle. By capturing a weak reference to self, we ensure that the ViewController can be deallocated even if the closure is still alive.

In order to break a strong reference cycle, we need to use weak or unowned references. A weak reference is a reference that doesn't increase the retain count of an object. If the object is deallocated, the weak reference becomes nil. An unowned reference is a reference that is assumed to always have a value, but doesn't increase the retain count of an object.

In the first example with delegation, we could break the strong reference cycle by using a weak reference instead of a strong reference for the car property in the Person class:
```swift
class Person {
    weak var car: Car?
    
    func drive() {
        car?.startEngine()
    }
    
    deinit {
        print("Person is being deinitialized")
    }
}

var john: Person?
var honda: Car?

john = Person()
honda = Car()

john?.car = honda
honda?.owner = john

john = nil
honda = nil
```

In the second example with dependencies, we could break the strong reference cycle by using an unowned reference instead of a strong reference for the player property in the Game class:

```swift
class Game {
    var player: Player?
    
    func start() {
        player?.play()
    }
    
    deinit {
        print("Game is being deinitialized")
    }
}

class Player {
    unowned var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func play() {
        print("Playing the game")
    }
    
    deinit {
        print("Player is being deinitialized")
    }
}

var game: Game?
var player: Player?

game = Game()
player = Player(game: game!)

game?.player = player
player?.game = game!

game = nil
player = nil
```

In the third example with closures, we could break the strong reference cycle by capturing a weak reference to self in the closure:

```swift
class ViewController {
    var updateLabelClosure: (() -> Void)?
    
    func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabelClosure = { [weak self] in
            self?.label.text = "Updated Label"
        }
    }
    
    deinit {
        print("ViewController is being deinitialized")
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Initial Label"
        return label
    }()
}

var viewController: ViewController?

viewController = ViewController()
viewController?.updateLabelClosure?()

viewController = nil
```
</details>
