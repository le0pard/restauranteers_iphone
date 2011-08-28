//
//  SigninViewController.m
//  Restauranteers
//
//  Created by Alex on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SigninViewController.h"
#import "UITableViewTextFieldCell.h"
#import "UITableViewActivityCell.h"

@implementation SigninViewController

@synthesize emailTextField, passwordTextField;
@synthesize tableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_wporg.png"]];
    logoView.frame = CGRectMake(0, 0, 320, 60);
    logoView.contentMode = UIViewContentModeCenter;
    logoView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    tableView.tableHeaderView = logoView;
    [logoView release];
    
    self.navigationItem.title = NSLocalizedString(@"Sign In", @"");
    signinButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = signinButton;
    
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
    [emailTextField release];
    [passwordTextField release];
    [tableView release];
	[super dealloc];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        if (indexPath.row == 0) {
            UITableViewTextFieldCell *emailCell = [[[UITableViewTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmailCell"] autorelease];
            emailCell.textLabel.text = NSLocalizedString(@"Email", @"");
            emailTextField = [emailCell.textField retain];
            emailTextField.placeholder = NSLocalizedString(@"Email", @"");
            emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
            emailTextField.returnKeyType = UIReturnKeyNext;
            emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            emailTextField.delegate = self;
            
            return emailCell;
        } else if(indexPath.row == 1) {
            UITableViewTextFieldCell *passwordCell = [[[UITableViewTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"] autorelease];
            passwordCell.textLabel.text = NSLocalizedString(@"Password", @"");
            passwordTextField = [passwordCell.textField retain];
            passwordTextField.placeholder = NSLocalizedString(@"Password", @"");
            passwordTextField.secureTextEntry = YES;
            passwordTextField.keyboardType = UIKeyboardTypeDefault;
            passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            passwordTextField.delegate = self;
            
            return passwordCell;
        }
    }
    return [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoCell"] autorelease];
    
}

#pragma mark -
#pragma mark Table view delegate
/*
- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tv cellForRowAtIndexPath:indexPath];
	if (indexPath.section == 0) {
        for(UIView *subview in cell.subviews) {
            if(subview.class == [UITextField class]) {
                [subview becomeFirstResponder];
                break;
            }
        }
	} else if (indexPath.section == 2) {
        WPWebViewController *webViewController;
        if (DeviceIsPad()) {
            webViewController = [[WPWebViewController alloc] initWithNibName:@"WPWebViewController-iPad" bundle:nil];
        }
        else {
            webViewController = [[WPWebViewController alloc] initWithNibName:@"WPWebViewController" bundle:nil];
        }
        NSString *dashboardUrl = [blog.xmlrpc stringByReplacingOccurrencesOfString:@"xmlrpc.php" withString:@"wp-admin/"];
        [webViewController setUrl:[NSURL URLWithString:dashboardUrl]];
        [webViewController setUsername:self.username];
        [webViewController setPassword:self.password];
        if (DeviceIsPad())
            [self presentModalViewController:webViewController animated:YES];
        else
            [self.navigationController pushViewController:webViewController animated:YES];
        
    }
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}
*/

#pragma mark -
#pragma mark UITextField methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyNext) {
        UITableViewCell *cell = (UITableViewCell *)[textField superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:indexPath.section];
        UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:nextIndexPath];
        if (nextCell) {
            for (UIView *subview in [nextCell subviews]) {
                if ([subview isKindOfClass:[UITextField class]]) {
                    [subview becomeFirstResponder];
                    break;
                }
            }
        }
    }
	[textField resignFirstResponder];
	return NO;
}


@end
