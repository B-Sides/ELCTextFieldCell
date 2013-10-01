//
//  ELCTextFieldCell.m
//  ELC Utility
//
//  Copyright 2012 ELC Tech. All rights reserved.
//

#import "ELCTextFieldCell.h"

#pragma mark ELCInsetTextField

@implementation ELCInsetTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, _inset);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, _inset);
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, _inset);
}

@end

#pragma mark - ELCTextFieldCell

@implementation ELCTextFieldCell

//using auto synthesizers

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		self.leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_leftLabel setBackgroundColor:[UIColor clearColor]];
		[_leftLabel setTextColor:[UIColor colorWithRed:.285 green:.376 blue:.541 alpha:1]];
		[_leftLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
		[_leftLabel setTextAlignment:NSTextAlignmentCenter];
		[self addSubview:_leftLabel];
		
		self.rightTextField = [[ELCInsetTextField alloc] initWithFrame:CGRectZero];
		_rightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		[_rightTextField setDelegate:self];
		[_rightTextField setFont:[UIFont systemFontOfSize:17]];
		
        //Use Done for all of them.
		[_rightTextField setReturnKeyType:UIReturnKeyDone];
		
		[self addSubview:_rightTextField];
    }
	
    return self;
}

//Layout our fields in case of a layoutchange (fix for iPad doing strange things with margins if width is > 400)
- (void)layoutSubviews
{
	[super layoutSubviews];
	CGRect origFrame = self.contentView.frame;
	if (_leftLabel.text != nil) {
        _leftLabel.hidden = NO;
		_leftLabel.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y, 125, origFrame.size.height-1);
		_rightTextField.frame = CGRectMake(origFrame.origin.x+130, origFrame.origin.y, origFrame.size.width-140, origFrame.size.height);
	} else {
		_leftLabel.hidden = YES;
		NSInteger imageWidth = 0;
		if (self.imageView.image != nil) {
			imageWidth = self.imageView.image.size.width + 5;
		}
		_rightTextField.frame = CGRectMake(origFrame.origin.x+imageWidth+10, origFrame.origin.y, origFrame.size.width-imageWidth-20, origFrame.size.height-1);
	}
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
    BOOL ret = YES;
	if([_delegate respondsToSelector:@selector(textFieldCell:shouldReturnForIndexPath:withValue:)]) {
        ret = [_delegate textFieldCell:self shouldReturnForIndexPath:_indexPath withValue:self.rightTextField.text];
	}
    if(ret) {
        [textField resignFirstResponder];
    }
    return ret;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *textString = self.rightTextField.text;
	textString = [textString stringByReplacingCharactersInRange:range withString:string];
	
	if([_delegate respondsToSelector:@selector(textFieldCell:updateTextLabelAtIndexPath:string:)]) {
		[_delegate textFieldCell:self updateTextLabelAtIndexPath:_indexPath string:textString];
	}
	
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(updateTextLabelAtIndexPath:string:)]) {
		[_delegate performSelector:@selector(updateTextLabelAtIndexPath:string:) withObject:_indexPath withObject:nil];
	}
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {		
		return [_delegate textFieldShouldBeginEditing:(UITextField *)textField];
	}
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {		
		return [_delegate textFieldShouldEndEditing:(UITextField *)textField];
	}
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
		return [_delegate textFieldDidBeginEditing:(UITextField *)textField];
	}   
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_delegate textFieldDidEndEditing:(UITextField*)textField];
    }
}

- (void)dealloc
{
    _delegate = nil;
    [_rightTextField resignFirstResponder];
}

@end

#pragma mark - ELCInsetTextFieldCell
@implementation ELCInsetTextFieldCell
- (void)setFrame:(CGRect)frame
{
    [super setFrame:UIEdgeInsetsInsetRect(frame, _inset)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.rightTextField.frame = CGRectInset(self.rightTextField.frame, 0, 4);
}
@end

