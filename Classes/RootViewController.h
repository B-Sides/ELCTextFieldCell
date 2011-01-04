//
//  RootViewController.h
//  ELCTextFieldCellDemo
//
//  Created by Collin Ruffenach on 1/4/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCTextfieldCell.h"

@interface RootViewController : UITableViewController <ELCTextFieldDelegate> {
	
	NSArray *labels;
	NSArray *placeholders;
}

@property (nonatomic, retain) NSArray *labels;
@property (nonatomic, retain) NSArray *placeholders;

@end
