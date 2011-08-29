//
//  SigninViewController.h
//  Restauranteers
//
//  Created by Alex on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigninViewController : UIViewController <UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    IBOutlet UITableView *tableView;
	UITextField *emailTextField, *passwordTextField;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) UITextField *emailTextField, *passwordTextField;

@end
