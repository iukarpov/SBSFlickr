//
//  SBSNotification.m
//  SBSFlickr
//
//  Created by Igor on 20/04/2019.
//  Copyright © 2019 Igor. All rights reserved.
//

#import "SBSNotification.h"
#import "AppDelegate.h"
#import "SBSFlickrViewController.h"
@import UserNotifications;
typedef NS_ENUM(NSInteger, SBSTriggerType) {
    SBSTriggerTypeInterval = 0,
    SBSTriggerTypeDate = 1,
    SBSTriggerTypeLocation = 2,
};


@implementation SBSNotification
- (void)sheduleLocalNotification
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    NSArray *requests = @[@"car", @"boat"];
    NSDictionary *bodies = @{
                             requests[0] : @"You haven't searched car's for a long time",
                             requests[1] : @"You haven't searched boat's for a long time"
                             };
    content.title = @"Notification";
    int randomNumber = arc4random_uniform(2);
    NSLog(@"random %d", randomNumber);
    content.body = bodies[requests[randomNumber]];
    content.sound = [UNNotificationSound defaultSound];
    NSDictionary *dict = @{@"request": requests[randomNumber]};
    content.userInfo = dict;
    content.badge = @(0);
    content.categoryIdentifier = @"SBSReminderCategory";
    UNNotificationTrigger *whateverTrigger = [self triggerWithType:SBSTriggerTypeInterval];
    NSString *identifier = @"NotificationId";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:whateverTrigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"%@",error);
         }
     }];
}

- (UNNotificationTrigger *)triggerWithType:(SBSTriggerType)triggerType
{
    switch (triggerType)
    {
        case SBSTriggerTypeInterval:
            return [self intervalTrigger];
        case SBSTriggerTypeLocation:
            return [self locationTrigger];
        case SBSTriggerTypeDate:
            return [self dateTrigger];
        default:
            break;
    }
    return nil;
}

- (UNTimeIntervalNotificationTrigger *)intervalTrigger
{
    return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
}

- (UNCalendarNotificationTrigger *)dateTrigger
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3600];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond fromDate:date];
    
    return [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
}

- (UNLocationNotificationTrigger *)locationTrigger
{
    return nil;
}

- (NSInteger)giveNewBadgeNumber
{
    return [UIApplication sharedApplication].applicationIconBadgeNumber;
}

- (void)addCustomActions
{
    UNNotificationAction *checkAction = [UNNotificationAction actionWithIdentifier:@"CheckID"
                                                                             title:@"Check" options:UNNotificationActionOptionNone];
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"DeleteID"
                                                                              title:@"Delete" options:UNNotificationActionOptionDestructive];
        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"SBSReminderCategory" actions:@[checkAction,deleteAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    NSSet *categories = [NSSet setWithObject:category];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setNotificationCategories:categories];
}


@end
