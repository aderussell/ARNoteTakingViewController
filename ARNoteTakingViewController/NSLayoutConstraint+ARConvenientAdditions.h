//
//  NSLayoutConstraint+ARConvenientAdditions.h
//  NotesViewDemo
//
//  Created by Adrian Russell on 09/08/2014.
//  Copyright (c) 2014 Adrian Russell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (ARConvenientAdditions)

+ (NSLayoutConstraint *)heightConstraintForView:(UIView *)view height:(CGFloat)height;

+ (NSLayoutConstraint *)widthConstraintForView:(UIView *)view width:(CGFloat)width;

+ (NSLayoutConstraint *)constraintToTopLockView:(UIView *)viewA toView:(UIView *)viewB;
+ (NSLayoutConstraint *)constraintToLeftLockView:(UIView *)viewA toView:(UIView *)viewB;
+ (NSLayoutConstraint *)constraintToRightLockView:(UIView *)viewA toView:(UIView *)viewB;
+ (NSLayoutConstraint *)constraintToBottomLockView:(UIView *)viewA toView:(UIView *)viewB;


+ (NSLayoutConstraint *)constraintAligningHorizontalCenterOfView:(UIView *)view withSuperview:(UIView *)superview;

+ (NSLayoutConstraint *)constraintAligningVerticalCenterOfView:(UIView *)view withSuperview:(UIView *)superview;


@end
