//
//  SchoolRemindersPrefHandler.m
//  SchoolReminders-App
//
//  Created by Zachary Keffaber on 2023/01/27.
//

#import "SchoolRemindersPrefHandler.h"

@implementation SchoolRemindersPrefHandler
-(void)addReminder:(NSString*)reminder directory:(NSString*)directory {
    
    const char *dirChr = [directory UTF8String];
    
    FILE *file;
    
    if ((file = fopen(dirChr,"r"))) {
        fclose(file);
    } else {
        [self setUpPrefPlist:directory];
    }
    
    NSMutableDictionary *SchoolRemindersPrefs = [NSMutableDictionary dictionaryWithContentsOfFile:directory];
    [SchoolRemindersPrefs setObject:@"" forKey:reminder];
    NSError* error=nil;
    NSPropertyListFormat format=NSPropertyListXMLFormat_v1_0; //NSPropertyListBinaryFormat_v1_0
    NSData* data =  [NSPropertyListSerialization dataWithPropertyList:SchoolRemindersPrefs format:format options:NSPropertyListImmutable error:&error];
    [data writeToFile:directory atomically:YES];
    
}
-(void)setUpPrefPlist:(NSString*)directory {
    NSDictionary *blankPrefs = [[NSDictionary alloc]init];
    NSError* error=nil;
    NSPropertyListFormat format=NSPropertyListXMLFormat_v1_0; //NSPropertyListBinaryFormat_v1_0
    NSData* data =  [NSPropertyListSerialization dataWithPropertyList:blankPrefs format:format options:NSPropertyListImmutable error:&error];
    [data writeToFile:directory atomically:YES];
}
-(void)removeReminder:(NSString*)reminder directory:(NSString*)directory {
    const char *dirChr = [directory UTF8String];
    
    FILE *file;
    
    if ((file = fopen(dirChr,"r"))) {
        fclose(file);
        NSMutableDictionary *SchoolRemindersPrefs = [NSMutableDictionary dictionaryWithContentsOfFile:directory];
        [SchoolRemindersPrefs removeObjectForKey:reminder];
        NSError* error=nil;
        NSPropertyListFormat format=NSPropertyListXMLFormat_v1_0; //NSPropertyListBinaryFormat_v1_0
        NSData* data =  [NSPropertyListSerialization dataWithPropertyList:SchoolRemindersPrefs format:format options:NSPropertyListImmutable error:&error];
        [data writeToFile:directory atomically:YES];
    }
}
+(NSString*)preferencesDirectory {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Reminders.plist"];
}
-(void)addReminder:(NSString*)reminder {
    [self addReminder:reminder directory:[SchoolRemindersPrefHandler preferencesDirectory]];
}
-(void)removeReminder:(NSString*)reminder {
    [self removeReminder:reminder directory:[SchoolRemindersPrefHandler preferencesDirectory]];
}
@end
