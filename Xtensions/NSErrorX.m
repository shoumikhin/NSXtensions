//
// Created by Petr Korolev on 08/05/14.
// Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSErrorX.h"


@implementation NSError (X)

-(void)showAlertView
{
    [self showAlertViewWithTitle:@"Error" andMessage:self.localizedFailureReason ?: self.localizedDescription];
}

-(void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        [alertView show];
    });
}

@end
