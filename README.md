## Anachronic

Anachronic is an application for Mac OS X (Windows later) that runs in your dock and watches what you do.

Ideally this is event based, and not subject to polling where accuracy could be lost (or noise reduced?)

Begin coding to see limitations/possibilities: http://stackoverflow.com/questions/1973554/how-do-i-find-information-on-other-applications-running-on-the-computer-on-mac-c

### Polling for a start

```objective-c
while (true) {
    sleep(1);
    NSDictionary *activeApp = [[NSWorkspace sharedWorkspace] activeApplication];
    NSLog(@"Active application is: %@", (NSString *)[activeApp objectForKey:@"NSApplicationName"] );
}
```

Well that works.

--

Anachronic spies on you because you want it to. You decide to what extent it does (e.g. additional functionality).

The magic happens when you go to review your the historical usage data and begin setting policy about how to make sense of this data.

--

### Digging deep about the process

Unfortunately it will be difficult to know what you're doing IN the application you're using without looking at clues. We'll use screen capture and post-process with OCR on the backend in select regions, also determined by further policy about how to process different applications (e.g. in iTerm, cross-reference project name lists. In Vim, use previous terminal context, else try to guess from the Vim screen). Ultimately Anachronic will try its best, with the guidance you give it, but many events will be marked Uncategorized.

```
From http://stackoverflow.com/questions/15446319/taking-screenshot-programmically-in-mac-only-for-application-window

To actually take a screenshot of your window, including its frame and shadow, get your window's windowNumber and pass that to the CGWindowListCreateImage function.
```
Well for starters then...
```objective-c
NSArray *wns = [NSWindow windowNumbersWithOptions:NSWindowNumberListAllApplications];
for (id wn in wns) {
  NSLog(@"%d", wn);
}
```

Other API...

```
http://cocoadev.com/ScreenShotCode

Apple's sample code has been deprecated. Exactly why it was deprecated is unclear, but it's now in their archive section at http://developer.apple.com/samplecode/Sample_Code/Archive/Graphics/glGrab.htm. "This sample shows how to use OpenGL to grab the contents of the screen via a DMA transfer to reduce the load on the CPU."

There's also the Snapshot ( http://developer.apple.com/samplecode/Sample_Code/Archive/Graphics/Snapshot.htm ) and Super Snapshot ( http://developer.apple.com/samplecode/Sample_Code/Archive/Graphics/SuperSnapshot.htm ) archived examples.
```

For example, when we detect MacVim, we can likely know which file you have open, thus we can know what your working directory is, and even then we can know which git repository you are under, if any. If you're working on a git repo, you're probably "Coding" -- is this leisure or work though? Looks like you were working on Project X: that's the project Client Z is paying you hourly for, let's set policy.

This all depends on the depth and quality of data that can be collected and the interface through which this policy-making is exposed.
