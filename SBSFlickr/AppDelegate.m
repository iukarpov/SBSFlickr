//
//  AppDelegate.m
//  SBSFlickr
//
//  Created by Igor on 14/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//


#import "AppDelegate.h"
#import "SBSFlickrViewController.h"
#import "SBSNetworkService.h"
#import "SBSNotification.h"
@import UserNotifications;


@interface AppDelegate () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) SBSFlickrViewController *initialFlickrViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.initialFlickrViewController = [SBSFlickrViewController new];
    UINavigationController *flickrNavigationController = [[UINavigationController alloc] initWithRootViewController:self.initialFlickrViewController];
    flickrNavigationController.navigationBar.topItem.title = @"Flickr Search";
    self.window.rootViewController = flickrNavigationController;
    [self.window makeKeyAndVisible];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    
    center.delegate = self;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"Something went wrong");
        }
    }];
    
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
            NSLog(@"Access denied");
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    SBSNotification *notification = [SBSNotification new];
    [notification sheduleLocalNotification];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    if (completionHandler) {
        completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    }
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    if (content.userInfo[@"request"])
    {
        NSString *request = content.userInfo[@"request"];
        self.initialFlickrViewController.searchBar.text = request;
        [self.initialFlickrViewController searchBarSearchButtonClicked:self.initialFlickrViewController.searchBar];
    }
    if (completionHandler)
    {
        completionHandler();
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}


- (void)applicationWillEnterForeground:(UIApplication *)application
{

}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    
    [self saveContext];
}


#pragma mark - Core Data stack


@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer
{
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self)
    {
        if (_persistentContainer == nil)
        {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SBSFlickr"];
            
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error)
            {
                if (error != nil)
                {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSError *error = nil;
    
    if ([context hasChanges] && ![context save:&error])
    {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        
        abort();
    }
}

@end
