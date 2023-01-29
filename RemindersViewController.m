//
//  RemindersViewController.m
//  SchoolReminders-App
//
//  Created by Zachary Keffaber on 2023/01/20.
//

#import "RemindersViewController.h"
#import "FHSPrefHandler.h"
#import "ReminderCell.h"

id _param;

@interface RemindersViewController ()

@end

@implementation RemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _param = self;
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ReminderCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ReminderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *reminders = [NSDictionary dictionaryWithContentsOfFile:[FHSPrefHandler preferencesDirectory]];
    if ([[reminders allKeys]objectAtIndex:indexPath.row]) {
        cell.textLabel.text = [[reminders allKeys]objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = @"Texrt";
    }
    [cell.textLabel setAdjustsFontSizeToFitWidth:1];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[NSDictionary dictionaryWithContentsOfFile:[FHSPrefHandler preferencesDirectory]]count];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ReminderCell* reminderCell = (ReminderCell*)[tableView cellForRowAtIndexPath:indexPath];
        [reminderCell deleteCountConfig];
    }
}
-(void)deleteRowWithTitle:(NSString *)rowTitle {
    [[[FHSPrefHandler alloc]init]removeReminder:rowTitle];
    [self.myTableView reloadData];
}
@end

void deleteRowWithTitle(NSString *rowTitle) {
    [_param deleteRowWithTitle:rowTitle];
}
