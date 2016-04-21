//
//  AddContactViewController.m
//  GPhoneBook
//
//  Created by Glenn on 05/04/2016.
//  Copyright © 2016 GlennPosadas. All rights reserved.
//

#import "AddContactViewController.h"
#import "GlobalHeader.h"

@interface AddContactViewController ()

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    self.title = self.contactName;
    
    if ([self.contactName isEqualToString:@""]) {
        self.title = @"Add New Contact";
    }
    
    [self setupTextFieldsValues];
}

- (void)setupTextFieldsValues {
    _oldNameForReference = _contactName;
    _contactNameTextField.text = _contactName;
    _contactNumberTextField.text = _contactNumber;
    _contactEmailTextField.text = _contactEmail;
    _contactCityTextField.text = _contactCity;
}

- (void)viewDidLayoutSubviews {
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 270)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
- (void)saveContactBtnAction:(id)sender {
    NSLog(@"saveContactBtn");
    
    NSDictionary *userData = [[NSDictionary alloc] initWithObjectsAndKeys:  _oldNameForReference, oldNameObjectKey,
                                                                             _contactNameTextField.text , nameObjectKey,
                                                                             _contactNumberTextField.text , contactNumObjectKey,
                                                                             _contactEmailTextField.text , emailObjectKey,
                                                                             _contactCityTextField.text , cityObjectKey, nil];
    
    // Make a notification before we dismiss.
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidSaveContactNotification object:userData];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
