## Messages Plugin Bundle (Private API)

This is the repo for the bundle containing code to perform Sync messages via Socket connection.

### Features

- sync messages upon messages "sync-messages" received from Socket Server on port 28080.

See [here](https://docs.bluebubbles.app/helper-bundle/imcore-documentation) for more details on how these were implemented.

### Support

The bundle has been tested on MacOS 10.13 (High Sierra) - MacOS 13 (Ventura). It could work on higher or lower MacOS versions, but we do not know for sure.

### Build Yourself

Open the MacOS-xx folder (where xx corresponds with your current macOS version) within the cloned repository files
i.e. Messages/MacOS-11+

Open up Terminal and navigate to the same directory

Run: pod install
This should install the the dependencies for the project

Using finder, double click MessagesPlugin.xcworkspace to open inside Xcode
Make sure you do not open the MessagesPlugin.xcodeproj file

Select the MessagesPlugin project header in the primary side bar

Select the MessagesPlugin Dylib target (building icon) in the secondary sidebar. Then go to the Build Phases tab and expand the Copy Files section. Edit the Path to be where you want the dylib to output to.

Example:/{path_to_your_code}/MessagesPlugin.dylib

#### Pre-requirements:

1. MacOS and Xcode
2. Apple Developer account with a valid Team ID
3. **10.12 - 10.13**: [mySIMBL](https://github.com/w0lfschild/mySIMBL/releases) / **10.14+**: [MacForge](https://www.macenhance.com/macforge)

#### Instructions:

1. Run command: export DYLD_INSERT_LIBRARIES=/{path_to_your_code}/MessagesPlugin.dylib
2. Run command to start messages with dylib library included: /System/Applications/Messages.app/Contents/MacOS/Messages
