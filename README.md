# SwiftUI Concurrency With async/await

Swift 5.5 introduced a significant set of concurrency features, with a standout addition being the async/await pattern. This pattern enables developers to execute intricate asynchronous code in a manner that closely resembles synchronous code execution. Implementing this pattern involves two key steps: first, identifying async functions by using the 'async' keyword, and second, invoking these functions using the 'await' keyword. This approach aligns with conventions seen in other programming languages like **C# and JavaScript**.

### Do, Try, Catch, Throws
#### DoTryCatchThrowsView: 
**do**: This keyword is used to define a block of code that may cause an error. It is followed by a block of code enclosed in curly braces {}. Inside this block, you can write code that might throw an error.  
**try**: This keyword is used to call a throwing function or method. You must use try before calling a function that is marked with the throws keyword.  
**catch**: This keyword is used to catch and handle any errors thrown within the do block. It is followed by a block of code that will be executed if an error is thrown.  
**throws**: This keyword is used in the declaration of a function or method to indicate that it can throw an error. When a function is marked with throws, it means that the function can potentially generate an error that needs to be handled by the caller.  

```
func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("Get Title 2!")
        } else {
            return .failure(URLError(.badURL))
        }
    }

```
This method returns a Result<String, Error> type. The Result type is an enumeration that can represent either success with an associated value or failure with an associated error. This approach provides better error handling by allowing you to handle specific errors and access error details. However, it can make your code more complex, especially if you need to handle multiple error cases.

```
func getTitle3() throws ->  String {
        if isActive {
            return "Get title 3!!"
        } else {
            throw URLError(.badURL)
        }
    }
```
This method uses the throws keyword to indicate that it can throw an error. The caller uses do, try, and catch to handle the error. This approach has the following benefits:

1. Clear error handling: By using throws, you explicitly indicate that the function can throw an error. This makes it clear to the caller that error handling is required.
   
2. Fine-grained error handling: You can catch specific errors and handle them differently using multiple catch blocks. This enables better error handling and allows you to provide more useful feedback to the user.
   
3. Better documentation: Using throws in the function signature documents the fact that the function can generate an error. This makes your code more readable and easier to understand for other developers.

### @escaping closure, Combine and async/await
#### DownloadImageAsyncView
class demonstrates three different techniques for downloading images asynchronously: using a completion handler with escaping closure, employing Combine, and leveraging the new async/await pattern introduced in Swift 5.5.

##### Completion Handler with Escaping Closure (downloadWithEscaping):

This method uses a traditional completion handler with an escaping closure.        
It initiates a data task to download the image and then invokes the closure when the task completes.        
To prevent retain cycles, the [weak self] capture list is used when accessing self.        

##### Combine (downloadWithCombine):

This method demonstrates image downloading using Combine, a powerful framework for working with asynchronous data streams.        
It creates a publisher using dataTaskPublisher and processes the data using Combine operators.        
The result is a Combine publisher that emits the downloaded image or an error.        

##### Async/Await (downloadWithAsync):

This method showcases Swift's new concurrency features with async/await.        
It asynchronously downloads the image data and processes the response in a more synchronous-looking fashion.        
Errors are thrown in case of issues during the download.   

### Task and .task

