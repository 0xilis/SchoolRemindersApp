//
//  ReminderCell.m
//  SchoolReminders-App
//
//  Created by Zachary Keffaber on 2023/01/28.
//

#import "ReminderCell.h"
#import "RemindersViewController.h"

@implementation ReminderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)deleteCountConfig:(id)sender {
    deleteRowWithTitle(self.textLabel.text);
}

-(void)deleteCountConfig {
    deleteRowWithTitle(self.textLabel.text);
}

@end
