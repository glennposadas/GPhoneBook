//
//  AddContactViewController.h
//  GPhoneBook
//
//  Created by Glenn on 05/04/2016.
//  Copyright © 2016 GlennPosadas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController
@property (nonatomic, strong) NSString *oldNameForReference;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *contactNumber;
@property (nonatomic, strong) NSString *contactCity;
@property (nonatomic, strong) NSString *contactEmail;

@property (strong, nonatomic) IBOutlet UITextField *contactNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactCityTextField;



@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
