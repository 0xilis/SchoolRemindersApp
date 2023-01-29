//
//  RemindersViewController.h
//  SchoolReminders-App
//
//  Created by Zachary Keffaber on 2023/01/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RemindersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (readwrite) UITableView* myTableView;
void deleteRowWithTitle(NSString *rowTitle);
void resetDefault(NSString *rowTitle);
-(void)deleteRowWithTitle:(NSString *)rowTitle;
@end

NS_ASSUME_NONNULL_END
