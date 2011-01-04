//
//  ELCTextfieldCell.m
//  MobileWorkforce
//
//  Created by Collin Ruffenach on 10/22/10.
//  Copyright 2010 ELC Tech. All rights reserved.
//

#import "ELCTextfieldCell.h"


@implementation ELCTextfieldCell

@synthesize delegate;
@synthesize leftLabel;
@synthesize rightTextField;
@synthesize indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		
		leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[leftLabel setBackgroundColor:[UIColor clearColor]];
		[leftLabel setTextColor:[UIColor colorWithRed:.285 green:.376 blue:.541 alpha:1]];
		[leftLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
		[leftLabel setTextAlignment:UITextAlignmentRight];
		[leftLabel setText:@"Left Field"];
		[self addSubview:leftLabel];
		
		rightTextField = [[UITextField alloc] initWithFrame:CGRectZero];
		rightTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		[rightTextField setDelegate:self];
		[rightTextField setPlaceholder:@"Right Field"];
		[rightTextField setFont:[UIFont systemFontOfSize:17]];
		
		// FOR MWF USE DONE
		[rightTextField setReturnKeyType:UIReturnKeyDone];
		
		[self addSubview:rightTextField];
    }
	
    return self;
}

//Layout our fields in case of a layoutchange (fix for iPad doing strange things with margins if width is > 400)
- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect origFrame = self.contentView.frame;
	if (leftLabel.text != nil) {
		leftLabel.frame = CGRectMake(origFrame.origin.x, origFrame.origin.y, 90, origFrame.size.height-1);
		rightTextField.frame = CGRectMake(origFrame.origin.x+105, origFrame.origin.y, origFrame.size.width-120, origFrame.size.height-1);
	} else {
		leftLabel.hidden = YES;
		NSInteger imageWidth = 0;
		if (self.imageView.image != nil) {
			imageWidth = self.imageView.image.size.width + 5;
		}
		rightTextField.frame = CGRectMake(origFrame.origin.x+imageWidth+10, origFrame.origin.y, origFrame.size.width-imageWidth-20, origFrame.size.height-1);
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	if([delegate respondsToSelector:@selector(textFieldDidReturnWithIndexPath:)]) {
		
		[delegate performSelector:@selector(textFieldDidReturnWithIndexPath:) withObject:indexPath];
	}
	
	return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

	NSString *textString = self.rightTextField.text;
	
	if (range.length > 0) {
		
		textString = [textString stringByReplacingCharactersInRange:range withString:@""];
	} 
	
	else {
		
		if(range.location == [textString length]) {
			
			textString = [textString stringByAppendingString:string];
		}

		else {
			
			textString = [textString stringByReplacingCharactersInRange:range withString:string];	
		}
	}
	
	if([delegate respondsToSelector:@selector(updateTextLabelAtIndexPath:string:)]) {		
		[delegate performSelector:@selector(updateTextLabelAtIndexPath:string:) withObject:indexPath withObject:textString];
	}
	
	return YES;
}

- (void)dealloc {
	
	[leftLabel release];
	[rightTextField release];
	[indexPath release];
    [super dealloc];
}

@end
