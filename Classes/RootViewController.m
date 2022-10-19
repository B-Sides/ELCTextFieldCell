//
//  RootViewController.m
//  ELCTextFieldCellDemo
//
//  Created by Collin Ruffenach on 1/4/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController (Private)
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController

@synthesize labels;
@synthesize placeholders;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.labels = [NSArray arrayWithObjects:@"First Name", 
											@"Last Name", 
											@"Email", 
											@"Phone Number", 
											nil];
	
	self.placeholders = [NSArray arrayWithObjects:@"Enter First Name", 
												  @"Enter Last Name", 
												  @"Enter Email", 
												  @"Phone Number (Optional)", 
												  nil];
}

#pragma mark -
#pragma mark Table view data source

- (void)configureCell:(ELCTextFieldCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	cell.leftLabel.text = [self.labels objectAtIndex:indexPath.row];
	cell.rightTextField.placeholder = [self.placeholders objectAtIndex:indexPath.row];
	cell.indexPath = indexPath;
	cell.delegate = self;
    //Disables UITableViewCell from accidentally becoming selected.
    cell.selectionStyle = UITableViewCellEditingStyleNone;

	
	if (indexPath.row == 3) {
        [cell.rightTextField setKeyboardType:UIKeyboardTypeNumberPad];        
	}
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ELCTextFieldCell *cell = (ELCTextFieldCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ELCTextFieldCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
	
	[self configureCell:cell atIndexPath:indexPath];

    return cell;
}


#pragma mark ELCTextFieldCellDelegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    ELCTextFieldCell *textFieldCell = (ELCTextFieldCell*)textField.superview;
    if (![textFieldCell isKindOfClass:ELCTextFieldCell.class]) {
        return;
    }
    //It's a better method to get the indexPath like this, in case you are rearranging / removing / adding rows,
    //the set indexPath wouldn't change
    NSIndexPath *indexPath = [self.tableView indexPathForCell:textFieldCell];
	if(indexPath != nil && indexPath.row < [labels count]-1) {
		NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
		[[(ELCTextFieldCell*)[self.tableView cellForRowAtIndexPath:path] rightTextField] becomeFirstResponder];
		[self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}
	else {
		[[(ELCTextFieldCell*)[self.tableView cellForRowAtIndexPath:indexPath] rightTextField] resignFirstResponder];
	}
}

- (void)textFieldCell:(ELCTextFieldCell *)inCell updateTextLabelAtIndexPath:(NSIndexPath *)indexPath string:(NSString *)string {

    NSLog(@"See input: %@ from section: %ld row: %ld, should update models appropriately", string, (long)indexPath.section, (long)indexPath.row);
}

@end

