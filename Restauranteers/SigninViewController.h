//
//  SigninViewController.h
//  Restauranteers
//
//  Created by Alex on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewTextFieldCell.h"
#import "UITableViewActivityCell.h"
#import "RestauranteersAppDelegate.h"

@interface SigninViewController : UIViewController <UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    IBOutlet UITableView *tableView;
	UITextField *emailTextField, *passwordTextField;
    NSString *footerText, *buttonText;
    RestauranteersAppDelegate *appDelegate;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UITextField *emailTextField, *passwordTextField;
@property (nonatomic, retain) UITableViewTextFieldCell *emailCell, *passwordCell;
@property (nonatomic, retain) NSString *footerText, *buttonText;

@end
