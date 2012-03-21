//
//  ELCTextfieldCell.h
//  MobileWorkforce
//
//  Created by Collin Ruffenach on 10/22/10.
//  Copyright 2010 ELC Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELCTextfieldCell;

@protocol ELCTextFieldDelegate <NSObject>
@optional
-(BOOL)textField:(ELCTextfieldCell *)inCell shouldReturnForIndexPath:(NSIndexPath*)inIndexPath withValue:(NSString *)inValue;
-(void)textField:(ELCTextfieldCell *)inCell didReturnWithIndexPath:(NSIndexPath*)inIndexPath withValue:(NSString *)inValue;
-(void)textField:(ELCTextfieldCell *)inCell updateTextLabelAtIndexPath:(NSIndexPath *)inIndexPath string:(NSString *)inValue;
@end

@interface ELCTextfieldCell : UITableViewCell <UITextFieldDelegate> 
@property (nonatomic, assign) id<ELCTextFieldDelegate> delegate;
@property (nonatomic, retain) UILabel *leftLabel;
@property (nonatomic, retain) UITextField *rightTextField;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end

