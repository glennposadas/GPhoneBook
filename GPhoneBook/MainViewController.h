//
//  MainTableViewController.h
//  GPhoneBook
//
//  Created by Glenn on 05/04/2016.
//  Copyright © 2016 GlennPosadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
- (IBAction)editBtnAction:(id)sender;
- (IBAction)searchBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MainViewController *mainVC;

@end
