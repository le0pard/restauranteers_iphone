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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    if (0 == section){
        return 2;
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == [indexPath section]) {
        if (0 == indexPath.row) {
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
        } else if(1 == indexPath.row) {
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
    } else if (1 == [indexPath section]){
        UITableViewActivityCell *siginCell = nil;
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"UITableViewActivityCell" owner:nil options:nil];
		for(id currentObject in topLevelObjects)
		{
			if([currentObject isKindOfClass:[UITableViewActivityCell class]])
			{
				siginCell = (UITableViewActivityCell *)currentObject;
				break;
			}
		}
		siginCell.textLabel.text = @"Sign In";
		return siginCell;
    }
    return [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoCell"] autorelease];
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tv deselectRowAtIndexPath:indexPath animated:YES];
    
	switch (indexPath.section) {
		case 0:
        {
			UITableViewCell *cell = (UITableViewCell *)[tv cellForRowAtIndexPath:indexPath];
			for(UIView *subview in cell.subviews) {
				if([subview isKindOfClass:[UITextField class]] == YES) {
					UITextField *tempTextField = (UITextField *)subview;
					[tempTextField becomeFirstResponder];
					break;
				}
			}
			break;
        }
		case 1:
			for(int i = 0; i < 2; i++) {
				UITableViewCell *cell = (UITableViewCell *)[tv cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
				for(UIView *subview in cell.subviews) {
					if([subview isKindOfClass:[UITextField class]] == YES) {
						UITextField *tempTextField = (UITextField *)subview;
						[self textFieldDidEndEditing:tempTextField];
					}
				}
			}
            /*
			if(username == nil) {
				self.footerText = NSLocalizedString(@"Username is required.", @"");
				self.buttonText = NSLocalizedString(@"Sign In", @"");
				[tv reloadData];
			}
			else if(password == nil) {
				self.footerText = NSLocalizedString(@"Password is required.", @"");
				self.buttonText = NSLocalizedString(@"Sign In", @"");
				[tv reloadData];
			}
			else {
				self.footerText = @" ";
				self.buttonText = NSLocalizedString(@"Signing in...", @"");
				
				[NSThread sleepForTimeInterval:0.15];
				[tv reloadData];
				if (!isSigningIn){
					[self.navigationItem setHidesBackButton:YES animated:NO];
					isSigningIn = YES;
					[self performSelectorInBackground:@selector(signIn:) withObject:self];
				}
			}
             */
			break;
		default:
			break;
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    UITableViewCell *cell = (UITableViewCell *)[textField superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	/*
	switch (indexPath.row) {
		case 0:
			if((textField.text != nil) && ([textField.text isEqualToString:@""])) {
				self.footerText = NSLocalizedString(@"Username is required.", @"");
			}
			else {
				self.username = [[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
				textField.text = self.username;
			}
			break;
		case 1:
			if((textField.text != nil) && ([textField.text isEqualToString:@""])) {
				self.footerText = NSLocalizedString(@"Password is required.", @"");
			}
			else {
				self.password = textField.text;
			}
			break;
		default:
			break;
	}
	*/
    //	[self.tableView reloadData];
	[textField resignFirstResponder];
}


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
