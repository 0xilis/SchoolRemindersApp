//
//  ViewController.m
//  SchoolReminders-App
//
//  Created by Zachary Keffaber on 2023/01/20.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RemindersViewController.h"
#import "SchoolRemindersPrefHandler.h"

#define offset 20

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id (*objc_msgSendTyped)(id self, SEL _cmd, ...) = (void*)objc_msgSend;
    id objLabel = objc_msgSendTyped(objc_msgSendTyped(objc_getClass("UILabel"), sel_getUid("alloc")), sel_getUid("init"));
    //id ansstring = objc_msgSendTyped(objc_msgSendTyped(objc_getClass("NSString"), sel_getUid("alloc")), sel_getUid("initWithUTF8String:"),"Test");
    //objLabel = objc_msgSendTyped(objLabel, sel_getUid("setText:"),ansstring);
    
    
    //UILabel *objcLabel = [[UILabel alloc]init];
    [objLabel setText:@"Hi"];
    [objLabel setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width / 2, [UIScreen mainScreen].applicationFrame.size.height + offset)];
    
    NSLog(@"%@",objLabel);
    
    //[self.view addSubview:objLabel];
    UIButton *button = [[UIButton alloc]init];
    
    [button setFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width / 2, [UIScreen mainScreen].applicationFrame.size.height + offset)];
    [button setTitle:@"Add reminder" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTintColor:[UIColor whiteColor]];
    UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addButton)];
    [button addGestureRecognizer:buttonTap];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc]init];
    [button2 setFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width / 2, 0, [UIScreen mainScreen].applicationFrame.size.width / 2, [UIScreen mainScreen].applicationFrame.size.height + offset)];
    [button2 setTitle:@"See reminders" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor systemPinkColor]];
    [button2 setTintColor:[UIColor whiteColor]];
    UITapGestureRecognizer *button2Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showReminders)];
    [button2 addGestureRecognizer:button2Tap];
    [self.view addSubview:button2];
    
}
-(void)addButton {
    NSLog(@"Add Button Pressed!");
    if (@available(iOS 8.0, *)) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"School Reminders"
                                                                       message:@"Input your reminder:"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Reminder here...";
        }];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Adding reminder...");
            [[[SchoolRemindersPrefHandler alloc]init]addReminder:[[alert textFields][0] text]];
            
        }];
        [alert addAction:confirmAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        // Fallback on earlier versions
    }
}

-(void)showReminders {
    RemindersViewController *remindersVC = [[RemindersViewController alloc]init];
    [self presentViewController:remindersVC animated:YES completion:nil];
}

@end
