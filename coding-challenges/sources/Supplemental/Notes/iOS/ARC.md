

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
