//
//  ELCTextFieldCellDemoAppDelegate.h
//  ELCTextFieldCellDemo
//
//  Created by Collin Ruffenach on 1/4/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELCTextFieldCellDemoAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;

@end

