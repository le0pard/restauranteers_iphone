//
//  UITableViewActivityCell.h
//  Restauranteers
//
//  Created by Alex on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewActivityCell : UITableViewCell {
	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UILabel *textLabel;
	IBOutlet UIView *viewForBackground;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UIView *viewForBackground;

@end
