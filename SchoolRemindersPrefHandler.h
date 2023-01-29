//
//  SchoolRemindersPrefHandler.h
//  SchoolReminders-App
//
//  Created by Zachary Keffaber on 2023/01/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHSPrefHandler : NSObject
-(void)addReminder:(NSString*)reminder directory:(NSString*)directory;
-(void)setUpPrefPlist:(NSString*)directory;
-(void)removeReminder:(NSString*)reminder directory:(NSString*)directory;
+(NSString*)preferencesDirectory;
-(void)addReminder:(NSString*)reminder;
-(void)removeReminder:(NSString*)reminder;
@end

NS_ASSUME_NONNULL_END
