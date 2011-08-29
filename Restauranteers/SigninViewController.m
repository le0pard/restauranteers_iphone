//
//  SigninViewController.m
//  Restauranteers
//
//  Created by Alex on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SigninViewController.h"

@implementation SigninViewController

@synthesize emailTextField, passwordTextField;
@synthesize tableView;
@synthesize emailCell, passwordCell;
@synthesize footerText, buttonText;

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
    
    self.footerText = @" ";
	self.buttonText = NSLocalizedString(@"Sign In", @"");
    
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
    self.footerText = nil;
    self.buttonText = nil;
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
    if (0 == section){
        return self.footerText;
    } else {
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == [indexPath section]) {
        if (0 == indexPath.row) {
            self.emailCell = (UITableViewTextFieldCell *)[tableView dequeueReusableCellWithIdentifier:@"EmailCell"];
            if (nil == self.emailCell) {
                self.emailCell = [[[UITableViewTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmailCell"] autorelease];
                self.emailCell.textLabel.text = NSLocalizedString(@"Email", @"");
                emailTextField = [self.emailCell.textField retain];
                emailTextField.placeholder = NSLocalizedString(@"Email", @"");
                emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
                emailTextField.returnKeyType = UIReturnKeyNext;
                emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
                emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                emailTextField.delegate = self;
            }
            return self.emailCell;
        } else if(1 == indexPath.row) {
            self.passwordCell = (UITableViewTextFieldCell *)[tableView dequeueReusableCellWithIdentifier:@"PasswordCell"];
            if (nil == self.passwordCell) {
                self.passwordCell = [[[UITableViewTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"] autorelease];
                self.passwordCell.textLabel.text = NSLocalizedString(@"Password", @"");
                passwordTextField = [self.passwordCell.textField retain];
                passwordTextField.placeholder = NSLocalizedString(@"Password", @"");
                passwordTextField.secureTextEntry = YES;
                passwordTextField.keyboardType = UIKeyboardTypeDefault;
                passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
                passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                passwordTextField.delegate = self;
            }
            return self.passwordCell;
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
		siginCell.textLabel.text = self.buttonText;
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
			if(emailTextField.text == nil || emailTextField.text.length < 1) {
				self.footerText = NSLocalizedString(@"Email is required.", @"");
				self.buttonText = NSLocalizedString(@"Sign In", @"");
				[tv reloadData];
			}
			else if(passwordTextField.text == nil || passwordTextField.text.length < 1) {
				self.footerText = NSLocalizedString(@"Password is required.", @"");
				self.buttonText = NSLocalizedString(@"Sign In", @"");
				[tv reloadData];
			} else {
                self.footerText = @"";
                self.buttonText = NSLocalizedString(@"Signing in...", @"");
                [tv reloadData];
            }
			break;
		default:
			break;
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    /*
    UITableViewCell *cell = (UITableViewCell *)[textField superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
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
