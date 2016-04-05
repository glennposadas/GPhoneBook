//
//  MainTableViewController.m
//  GPhoneBook
//
//  Created by Glenn on 05/04/2016.
//  Copyright © 2016 GlennPosadas. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) NSMutableArray *contactNames;
@property (nonatomic, strong) NSMutableArray *contactNumbers;
@property (nonatomic, strong) NSMutableArray *contactCities;
@property (nonatomic, strong) NSMutableArray *contactEmails;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupContactNames];
    [self setupViews];
}

- (void)setupContactNames {
    self.contactNames = [[NSMutableArray alloc] initWithObjects:@"Glenn", @"Krisp", @"Bj", @"Oscar", @"Clarence", nil];
    self.contactNumbers = [[NSMutableArray alloc] initWithObjects:@"+639055403068", @"+639091323193", @"+639238102231", @"+63918233271", @"+639172229183", nil];
    self.contactCities = [[NSMutableArray alloc] initWithObjects:@"Caloocan City", @"Muntinlupa City", @"Rizal City", @"Valenzuela City", @"Malabon City", nil];
    self.contactEmails = [[NSMutableArray alloc] initWithObjects:@"admin@glennvon.com", @"kris@smartwave.ph", @"bj@smartwave.ph", @"oscar@smartwave.ph", @"clarence@smartwave.ph", nil];
}

- (void)setupViews {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contactNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhonebookCellIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = [_contactNames objectAtIndex:indexPath.row];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_contactNames removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  
}


#pragma mark - Button Actions

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)editBtnAction:(id)sender {
    NSLog(@"editBtnAction");
    
    [self.talbleView setEditing:!self.talbleView.isEditing animated:YES];
}

- (IBAction)searchBtnAction:(id)sender {
    NSLog(@"searchBtnAction");
}

@end
