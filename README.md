# ArchitectureDemo
A demo example of how we can adopt an architecture in SwiftUI

### Highlights
The aim of this demo is to mainly hightlight the following:
- Clean separation of view from viewModel to form MVVM (therefore views can easily be used independenly in previews or other places)
- Make use of namespaces. A screen defines our namespace and within it are its View and ViewModel
- Handling asynchronous tasks and cancellation with `task(id:)`, based on the task [documentation](https://developer.apple.com/documentation/swiftui/view/task(id:priority:_:)) this can help us with few things: 
    - Task(id:) will cancel a running task if the screen gets deallocated
    - Providing an equatable value will ensure that its triggered by unique actions only and a new action will cancel the previous tasks if its still running.
- Tests can derive from the actions defined in the screen, so therefore can make tests easy to follow and simple to create.
 
### Some nice to have
- onAppear happens once or can happen every time you enter the screen
- Viewmode changed to loadingstate
- Factory dependencies can still be added
- Redux pattern example
