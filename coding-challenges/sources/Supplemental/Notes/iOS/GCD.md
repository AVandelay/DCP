

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

<details>
<summary>Main and Global Dispatch Queues</summary>

#Main Queue

The main queue is the default queue that is created for an application. It is the queue that is associated with the main thread of the application. Work submitted to the main queue is executed on the main thread. This is important because all user interface updates should be performed on the main thread.

Let's take a look at an example:

```swift
DispatchQueue.main.async {
    self.myLabel.text = "Hello World"
}
```

In this example, we ask the `DispatchQueue` class for a reference to the main queue. We then submit a closure to the main queue using the `async` method. Inside the closure, we update a label on the user interface. Because we're submitting the closure to the main queue, we're guaranteed that the label is updated on the main thread.

#Global Queues

In addition to the main queue, Grand Central Dispatch provides several global queues. A global queue is a queue that is shared across the system. There are four different quality of service (QoS) levels for global queues:

- `.userInteractive`: for tasks that require immediate attention, such as animating user interface elements.
- `.userInitiated`: for tasks that are initiated by the user, such as opening a file.
- `.utility`: for long-running tasks that the user is aware of, such as exporting a large file.
- `.background`: for tasks that are not visible to the user, such as downloading a file in the background.

Let's take a look at an example:

```swift
DispatchQueue.global(qos: .userInitiated).async {
    // Perform a long-running task
}
```

In this example, we ask the `DispatchQueue` class for a reference to a global queue with the `.userInitiated` quality of service. We then submit a closure to the global queue using the async method. Inside the closure, we perform a long-running task.

Global queues are useful when you need to perform work that doesn't require immediate attention or that is not tied to the user interface. By using global queues with the appropriate quality of service, you can ensure that the work is performed in a timely manner without negatively impacting the user experience.

#Choosing the Right Dispatch Queue

Choosing the right dispatch queue for the task at hand is important. The main dispatch queue should be used for tasks that update the user interface. The global dispatch queue should be used for tasks that can be executed in the background.

It's important to remember that the global dispatch queue is a concurrent queue. This means that tasks that are submitted to the global dispatch queue can be executed concurrently. If the tasks depend on each other, a serial queue should be used instead.
</details>

<details>
<summary>Synchronous and Asynchronous Execution</summary>

#Asynchronous Execution

When you dispatch work asynchronously, the block is submitted to the dispatch queue and the method returns immediately. The block is then executed on a background thread. This means that the block is executed concurrently with the rest of your application. The thread that is used to execute the block is managed by Grand Central Dispatch.

Here's an example of how to dispatch work asynchronously:

```swift
DispatchQueue.global(qos: .userInitiated).async {
    // Perform work here
}
```

This dispatches the block to a global queue with the user-initiated QoS (Quality of Service) class. The block is executed on a background thread and the method returns immediately.

#Synchronous Execution

When you dispatch work synchronously, the method blocks until the block has been executed. This means that the block is executed on the current thread, which can be either the main thread or a background thread. The method doesn't return until the block has been executed.

Here's an example of how to dispatch work synchronously:

```swift
DispatchQueue.main.sync {
    // Perform work here
}
```

This dispatches the block to the main queue and blocks the current thread until the block has been executed. The block is executed on the main thread.

#Choosing Between Asynchronous and Synchronous Execution

So, when should you choose to dispatch work asynchronously or synchronously? As a rule of thumb, you should choose to dispatch work asynchronously when the work doesn't need to block the current thread. This allows your application to continue executing while the work is being performed in the background.

On the other hand, you should choose to dispatch work synchronously when the work needs to block the current thread. This is useful when you need to wait for the work to complete before continuing execution. For example, you might need to wait for a file to be downloaded before displaying it to the user.
</details>

<details>
<summary>Adding Flexibility with Dispatch Work Items</summary>

What is a Dispatch Work Item?

A dispatch work item is a block of code that is executed on a dispatch queue. It's a more flexible alternative to submitting blocks directly to a dispatch queue because it allows us to perform additional operations before or after the block executes. We can also use a dispatch work item to cancel a task or add dependency between tasks.

Let's look at an example. Suppose we have two tasks to execute: downloading an image from the internet and applying a filter to that image. We can represent each task as a dispatch work item and submit them to a concurrent queue:

```swift
let downloadWorkItem = DispatchWorkItem {
    // Download the image from the internet
}

let filterWorkItem = DispatchWorkItem {
    // Apply a filter to the image
}

let queue = DispatchQueue.global(qos: .userInitiated)
queue.async(execute: downloadWorkItem)
queue.async(execute: filterWorkItem)
```

In this example, we create two dispatch work items for downloading and filtering the image. We then submit them to a global queue with the `.userInitiated` quality of service (QoS) class, which indicates that the tasks are user-initiated and should be executed with a higher priority than the default QoS class.

Managing Dispatch Work Items

Once we create a dispatch work item, we can manage it in a few ways. For example, we can cancel a work item using the `cancel()` method:

```swift
let workItem = DispatchWorkItem {
    // Execute some task
}

// Submit the work item to a queue
let queue = DispatchQueue.global(qos: .background)
queue.async(execute: workItem)

// Cancel the work item after 5 seconds
let deadline = DispatchTime.now() + .seconds(5)
queue.asyncAfter(deadline: deadline) {
    workItem.cancel()
}
```
In this example, we create a dispatch work item and submit it to a background queue. We then schedule a block to execute after 5 seconds, which calls the cancel() method on the work item.

We can also use dispatch work items to add dependencies between tasks. For example, suppose we have three tasks: task A, task B, and task C. We want to execute task A first, followed by task B and C in parallel. We can use dispatch work items to achieve this:

```swift
let taskA = DispatchWorkItem {
    // Execute task A
}

let taskB = DispatchWorkItem {
    // Execute task B
}

let taskC = DispatchWorkItem {
    // Execute task C
}

let queue = DispatchQueue.global(qos: .default)
taskB.notify(queue: queue) {
    queue.async(execute: taskC)
}

queue.async(execute: taskA)
queue.async(execute: taskB)
```

In this example, we create three dispatch work items for tasks A, B, and C. We submit task A to the queue first, followed by task B. We then use the `notify(queue:execute:)` method on task B to specify that task C should execute after task B completes.

</details>
