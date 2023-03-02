

# Grand Central Dispatch

<details>
<summary>What Is Grand Central Dispatch?</summary>

Grand Central Dispatch (GCD) is a powerful technology that enables iOS developers to write multithreaded code easily and efficiently. In essence, GCD is a queue-based system that manages the execution of tasks on multicore hardware. By breaking down tasks into smaller, more manageable units of work and executing them concurrently, GCD can take full advantage of the power of modern processors, making your app run faster and smoother.

GCD is a technology that operates at the system level, making it easier for your app to execute tasks on multicore hardware. By leveraging GCD, your app can schedule work for execution through an easy-to-use API, leaving it to GCD to decide when and how the scheduled work is executed.

At the core of GCD are dispatch queues, which are queues onto which work can be scheduled for execution. GCD provides several options for scheduling work onto a dispatch queue, including submitting a block or a closure that takes no arguments and returns void or an empty tuple. Here's an example:

```swift
DispatchQueue.main.async {
    print("Hello World")
}
```

In this example, we're submitting a closure to the main dispatch queue, which is associated with the main thread of the application. Work submitted to the main dispatch queue is guaranteed to be executed on the main thread, which is important for updating the user interface.

GCD also manages a pool or collection of threads, making it easier to perform work in the background without having to worry about creating and managing threads. GCD decides which thread is used to execute a block, which is an implementation detail that the developer doesn't need to worry about.

In addition to dispatch queues, GCD provides several other convenient APIs, including dispatch groups and semaphores, to manage complexity and avoid threading issues. GCD also offers Quality of Service classes to inform the system about the importance of the tasks your app is performing.

It's important to understand why it's beneficial for your app to take advantage of GCD. Modern computing devices have a complex architecture, and they are incredibly performant. However, as developers, we need to be careful how the resources of these devices are used. By leveraging GCD, your app can be a good citizen on the platform it runs on, by efficiently using resources and responding to changes in device capabilities.
</details>

<details>
<summary>Working With Dispatch Queues</summary>

A dispatch queue is a queue onto which work can be scheduled for execution. It enqueues and dequeues work in FIFO (first in, first out) order. This means that the work submitted to a dispatch queue is executed in the order in which it was submitted.

There are two types of dispatch queues: serial and concurrent. A serial queue executes one task at a time, while a concurrent queue executes multiple tasks at the same time. It's important to understand the difference between these two types of queues because they behave differently and can have a significant impact on the performance of your application.

You can create a dispatch queue using the DispatchQueue class. Here's an example of how to create a serial and a concurrent queue:

```swift
// Serial queue
let serialQueue = DispatchQueue(label: "com.example.serialQueue")

// Concurrent queue
let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
```

In the example above, we create a serial queue with the label "com.example.serialQueue" and a concurrent queue with the label "com.example.concurrentQueue".

Once you have a dispatch queue, you can schedule work onto it using different methods. The most common method is using a closure, also known as a block, that contains the work you want to execute. Here's an example of how to schedule a closure onto a dispatch queue:

```swift
serialQueue.async {
    print("This code will be executed on a serial queue")
}

concurrentQueue.async {
    print("This code will be executed on a concurrent queue")
}
```

In this example, we schedule two different closures on the `serialQueue` and `concurrentQueue`, respectively. The first closure will be executed on a serial queue, which means that it will execute one task at a time. The second closure will be executed on a concurrent queue, which means that it can execute multiple tasks at the same time.

It's important to note that when you submit a closure to a dispatch queue, it's executed asynchronously. This means that the code that follows the `async` method will continue to execute, even if the closure hasn't finished executing yet.
</details>

<details>
<summary>Working with Dispatch Queues: Serial and Concurrent Queues</summary>

#Serial Queues
A serial queue executes one task at a time. Tasks are executed in the order in which they are submitted to the queue. A serial queue is useful when you want to ensure that tasks are executed in a predictable and deterministic order. If you submit three tasks to a serial queue, task A, task B, and task C, the tasks are executed in the following order:

```swift
queue.async {
    print("Task A")
}
queue.async {
    print("Task B")
}
queue.async {
    print("Task C")
}
```

Output:
```swift
Task A
Task B
Task C
```

In this example, task A is executed first, followed by task B, and finally task C. This is because the tasks are executed in the order in which they are submitted to the queue.

Serial queues are often used for tasks that are dependent on each other. For example, let's say you have an image processing application. You want to resize an image, then apply a filter, and finally save the result to disk. You would submit each task to a serial queue, ensuring that the tasks are executed in the correct order.

#Concurrent Queues

A concurrent queue, on the other hand, executes tasks concurrently. Tasks are executed in the order in which they are submitted to the queue, but because multiple tasks can be executed at the same time, the order in which they complete is not guaranteed.

Concurrent queues are useful when you have a set of independent tasks that can be executed in parallel. For example, let's say you have a list of images that need to be downloaded from a server. You can submit each download task to a concurrent queue, allowing multiple downloads to happen at the same time.

```swift
let queue = DispatchQueue(label: "com.myapp.concurrent", attributes: .concurrent)

for i in 1...10 {
    queue.async {
        print("Task \(i)")
    }
}
```
Output:
```swift
Task 2
Task 3
Task 1
Task 4
Task 5
Task 6
Task 7
Task 8
Task 9
Task 10
```
In this example, the tasks are executed concurrently, and because the order in which they complete is not guaranteed, the output is not in numerical order.
</details>
