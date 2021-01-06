# case_study_leanscale

A new Flutter project.

I have used Flutter to complete this case study as my cross-platform framework of choice because I am more familiar with languages like C# and Java as opposed to JavaScript, I did not choose React Native. Flutter also has Skia, a graphics engine that actually draws pixels on the screen natively, unlike React Native that has an API to call native components. Although of course, native will still have a performance advantage over Flutter, without the convenience of working in both IOS and Android with one codebase. 

In my project I have used the Provider package as my dependency injector as well as a state manager, for bigger projects provider may not be suitable, I also worked with the RxDart package, which makes more sense when you're working with streams. 

My project has a mock data that I have imported through my pubspec yaml, I have an init screen that calls to this mock data before the actual screens are initialized. This is not a good decision as some calls may depend on other calls, but it is the first thing that came into my mind so I went with it.

I have used Hive as my local data storage solution, I believe it is superior to shared preferences, as it can even store objects of data. You also don't have to worry about future calls, you just init your hive "box" in the main, and the box becomes accesssible anywhere in the app.

TODO
- [ ] Checking food category makes me repeat myself, but I don't know how to map JSON data to enum