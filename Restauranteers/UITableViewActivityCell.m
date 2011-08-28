//
//  UITableViewActivityCell.m
//  Restauranteers
//
//  Created by Alex on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITableViewActivityCell.h"

@implementation UITableViewActivityCell
@synthesize textLabel, spinner, viewForBackground;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
	[viewForBackground release];
	[textLabel release];
	[spinner release];
    [super dealloc];
}


@end
