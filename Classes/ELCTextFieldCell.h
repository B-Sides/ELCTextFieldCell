//
//  ELCTextFieldCell.h
//  ELC Utility
//
//  Copyright 2012 ELC Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELCTextFieldCell;

@interface ELCInsetTextField : UITextField

@property (nonatomic, assign) UIEdgeInsets inset;

@end

@protocol ELCTextFieldDelegate <NSObject>

@optional
//Called to the delegate whenever return is hit when a user is typing into the rightTextField of an ELCTextFieldCell
- (BOOL)textFieldCell:(ELCTextFieldCell *)inCell shouldReturnForIndexPath:(NSIndexPath*)inIndexPath withValue:(NSString *)inValue;
//Called to the delegate whenever the text in the rightTextField is changed
- (void)textFieldCell:(ELCTextFieldCell *)inCell updateTextLabelAtIndexPath:(NSIndexPath *)inIndexPath string:(NSString *)inValue;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

@end

@interface ELCTextFieldCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, assign) id<ELCTextFieldDelegate> delegate;
@property (nonatomic, retain) UILabel *leftLabel;
@property (nonatomic, retain) ELCInsetTextField *rightTextField;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end

@interface ELCInsetTextFieldCell : ELCTextFieldCell
@property (nonatomic, assign) UIEdgeInsets inset;
@end

