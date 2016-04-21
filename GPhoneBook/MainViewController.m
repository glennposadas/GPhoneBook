//
//  MainTableViewController.m
//  GPhoneBook
//
//  Created by Glenn on 05/04/2016.
//  Copyright © 2016 GlennPosadas. All rights reserved.
//

#import "MainViewController.h"
#import "AddContactViewController.h"
#import "GlobalHeader.h"

@interface MainViewController () <UISearchControllerDelegate, UISearchResultsUpdating> {
    
}
@property (nonatomic, strong) UISearchController *searchResultsController;
@property (nonatomic, strong) NSMutableArray *searchResultsArray;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *contactNames;
@property (nonatomic, strong) NSMutableArray *contactNumbers;
@property (nonatomic, strong) NSMutableArray *contactCities;
@property (nonatomic, strong) NSMutableArray *contactEmails;

@property (nonatomic) BOOL searchControllerIsActive;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupContactNames];
    [self setupNotificationCenter];
}

- (void)setupContactNames {
    self.contactNames = [[NSMutableArray alloc] initWithObjects:@"Glenn", @"Krisp", @"Bj", @"Oscar", @"Clarence", nil];
    self.contactNumbers = [[NSMutableArray alloc] initWithObjects:@"+639055403068", @"+639091323193", @"+639238102231", @"+63918233271", @"+639172229183", nil];
    self.contactCities = [[NSMutableArray alloc] initWithObjects:@"Caloocan City", @"Muntinlupa City", @"Rizal City", @"Valenzuela City", @"Malabon City", nil];
    self.contactEmails = [[NSMutableArray alloc] initWithObjects:@"admin@glennvon.com", @"kris@smartwave.ph", @"bj@smartwave.ph", @"oscar@smartwave.ph", @"clarence@smartwave.ph", nil];
}

- (void)setupNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:UserDidSaveContactNotification object:nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self.searchController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    [_mainVC performSegueWithIdentifier:@"dataContactSegue" sender:indexPath];
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
    // Make sure your segue name in storyboard is the same as this line
    if (!_searchControllerIsActive) {
        if ([[segue identifier] isEqualToString:@"dataContactSegue"])
        {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            
            // Get reference to the destination view controller
            AddContactViewController *addContactVC = [segue destinationViewController];
            
            // Pass any objects to the view controller here, like...
            addContactVC.contactName = [_contactNames objectAtIndex:indexPath.row];
            addContactVC.contactNumber = [_contactNumbers objectAtIndex:indexPath.row];
            addContactVC.contactCity = [_contactCities objectAtIndex:indexPath.row];
            addContactVC.contactEmail = [_contactEmails objectAtIndex:indexPath.row];
            
        }
    }
}

- (IBAction)editBtnAction:(id)sender {
    NSLog(@"editBtnAction");
    
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

- (IBAction)searchBtnAction:(id)sender {
    NSLog(@"searchBtnAction");
    [self doSearch];
}

#pragma mark - Search Function

- (void)doSearch {
    
    UINavigationController *searchResultsController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    // Create the search controller and make it perform the results updating.
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    self.searchController.searchBar.placeholder = @"Search for contacts.";
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    _searchControllerIsActive = YES;
    // Present the view controller.
    [self.navigationController presentViewController:self.searchController animated:YES completion:nil];

}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    _searchControllerIsActive = NO;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (!self.searchController.active) {
        return;
    }
    
    if (searchController.searchBar.text.length > 0)
    {
        // BEGIN SEARCH HERE!
        NSLog(@"Updating search results...");
        
        NSString *searchString = searchController.searchBar.text;
        
        NSString *filter = @"SELF contains[cd] %@";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter, searchString];
        
        self.searchResultsArray = [[_contactNames filteredArrayUsingPredicate:predicate] mutableCopy];
        
        self.contactNames = self.searchResultsArray;
        [self.tableView reloadData];
    }
    
    
}

#pragma mark - Notificaitons
- (void)didReceiveNotification:(id)sender {
    NSLog(@"didReceiveNotification %@", [sender object]);
    
    NSString *oldName = [[sender object] objectForKey:oldNameObjectKey];
    NSString *newName = [[sender object] objectForKey:nameObjectKey];
    NSString *newContactNumber = [[sender object] objectForKey:contactNumObjectKey];
    NSString *newEmail = [[sender object] objectForKey:emailObjectKey];
    NSString *newCity = [[sender object] objectForKey:cityObjectKey];

    // check if existing, if so, overwrite!
    if ([_contactNames containsObject:oldName]) {
        
        NSUInteger arrayIndex = 0;
        NSUInteger finalArrayIndex = 0;
        
        for (NSString *name in _contactNames) {
            if ([name isEqualToString:oldName]) {
                finalArrayIndex = arrayIndex;
            }
            arrayIndex++;
        }
        
        // place the new data:
        _contactNames[finalArrayIndex] = newName;
        _contactNumbers[finalArrayIndex] = newContactNumber;
        _contactEmails[finalArrayIndex] = newEmail;
        _contactCities[finalArrayIndex] = newCity;
        
    } else {
        [_contactNames addObject:newName];
        [_contactNumbers addObject:newContactNumber];
        [_contactEmails addObject:newEmail];
        [_contactCities addObject:newCity];
    }
    
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
