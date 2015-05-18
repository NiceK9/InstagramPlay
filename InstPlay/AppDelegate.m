//
//  AppDelegate.m
//  InstPlay
//
//  Created by son hoang on 5/16/15.
//  Copyright (c) 2015 son hoang. All rights reserved.
//

#import "GoogleMaps/GoogleMaps.h"

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
	[GMSServices provideAPIKey:@"AIzaSyAJPs5iCdHVk4TA5NIzMIs8LcifnavQhHI"];[GMSServices provideAPIKey:@"AIzaSyAJPs5iCdHVk4TA5NIzMIs8LcifnavQhHI"];    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *master = [[ViewController alloc] init];
    master.appDelegate = self;
    
    self.navigationController =
    [[UINavigationController alloc] initWithRootViewController:master];
    
    // Force non-translucent navigation bar for consistency of demo between
    // iOS 6 and iOS 7.
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
