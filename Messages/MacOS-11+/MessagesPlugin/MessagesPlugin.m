@import AppKit;

#import <Foundation/Foundation.h>

#import "NetworkController.h"
#import "Logging.h"
#import "IMCloudKitEventNotificationManager.h"


@interface MessagesPlugin : NSObject
+ (instancetype)sharedInstance;
@end

// This can be used to dump the methods of any class
@interface NSObject (Private)
- (NSString*)_methodDescription;
@end

MessagesPlugin *plugin;
NSMutableArray* vettedAliases;


@implementation MessagesPlugin

// MessagesPlugin is a singleton
+ (instancetype)sharedInstance {
    static MessagesPlugin *plugin = nil;
    @synchronized(self) {
        if (!plugin) {
            plugin = [[self alloc] init];
        }
    }
    return plugin;
}

// Helper method to log a long string
-(void) logString:(NSString*)logString{

        int stepLog = 800;
        NSInteger strLen = [@([logString length]) integerValue];
        NSInteger countInt = strLen / stepLog;

        if (strLen > stepLog) {
        for (int i=1; i <= countInt; i++) {
            NSString *character = [logString substringWithRange:NSMakeRange((i*stepLog)-stepLog, stepLog)];
            DLog("MessagesPlugin: %{public}@", character);

        }
        NSString *character = [logString substringWithRange:NSMakeRange((countInt*stepLog), strLen-(countInt*stepLog))];
            DLog("MessagesPlugin: %{public}@", character);
        } else {

            DLog("MessagesPlugin: %{public}@", logString);
        }

}

// Called when macforge initializes the plugin
+ (void)load {
    // Create the singleton
    plugin = [MessagesPlugin sharedInstance];

    // Get OS version for debugging purposes
    NSUInteger major = [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion;
    NSUInteger minor = [[NSProcessInfo processInfo] operatingSystemVersion].minorVersion;
    DLog("MessagesPlugin: %{public}@ loaded into %{public}@ on macOS %ld.%ld", [self className], [[NSBundle mainBundle] bundleIdentifier], (long)major, (long)minor);

    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.MobileSMS"]) {
        // Delay by 5 seconds so the server has a chance to initialize all the socket services
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            DLog("MessagesPlugin: Initializing Connection...");
            [plugin initializeNetworkController];
        });
    } else {
        DLog("MessagesPlugin: Injected into non-iMessage process %@, aborting.", [[NSBundle mainBundle] bundleIdentifier]);
        return;
    }
}

// Private method to initialize all the things required by the plugin to communicate with the main
// server over a tcp socket
-(void) initializeNetworkController {
    // Get the network controller
    NetworkController *controller = [NetworkController sharedInstance];
    [controller connect];

    // Upon receiving a message
    controller.messageReceivedBlock =  ^(NetworkController *controller, NSString *data) {
        [self handleMessage:controller message: data];
    };

}


// Run when receiving a new message from the tcp socket
-(void) handleMessage: (NetworkController*)controller  message:(NSString *)message {

    DLog("MessagesPlugin: Received message: %{public}@", message);


        if([message isEqualToString: @"sync-messages"]) {
            DLog("MessagesPlugin: tyszkiewicz.jakub. syncing.");
            [[IMCloudKitEventNotificationManager sharedInstance] startPeriodicSync];
    
        
    // If the event is something that hasn't been implemented, we simply ignore it and put this log
    } else {
        DLog("MessagesPlugin: Not implemented %{public}@", message);
    }

}

@end
