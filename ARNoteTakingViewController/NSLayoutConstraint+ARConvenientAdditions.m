//
//  NSLayoutConstraint+ARConvenientAdditions.m
//  NotesViewDemo
//
//  Created by Adrian Russell on 09/08/2014.
//  Copyright (c) 2014 Adrian Russell. All rights reserved.
//

#import "NSLayoutConstraint+ARConvenientAdditions.h"

@implementation NSLayoutConstraint (ARConvenientAdditions)

+ (NSLayoutConstraint *)heightConstraintForView:(UIView *)view height:(CGFloat)height
{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeHeight
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.0
                                         constant:height];
}

+ (NSLayoutConstraint *)widthConstraintForView:(UIView *)view width:(CGFloat)width
{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:nil
                                        attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.0
                                         constant:width];
}

+ (NSLayoutConstraint *)constraintToTopLockView:(UIView *)viewA toView:(UIView *)viewB
{
    return [NSLayoutConstraint constraintWithItem:viewA
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:viewB
                                        attribute:NSLayoutAttributeTop
                                       multiplier:1.0
                                         constant:0.0];
}

+ (NSLayoutConstraint *)constraintToLeftLockView:(UIView *)viewA toView:(UIView *)viewB
{
    return [NSLayoutConstraint constraintWithItem:viewA
                                        attribute:NSLayoutAttributeLeft
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:viewB
                                        attribute:NSLayoutAttributeLeft
                                       multiplier:1.0
                                         constant:0.0];
}

+ (NSLayoutConstraint *)constraintToRightLockView:(UIView *)viewA toView:(UIView *)viewB
{
    return [NSLayoutConstraint constraintWithItem:viewA
                                        attribute:NSLayoutAttributeRight
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:viewB
                                        attribute:NSLayoutAttributeRight
                                       multiplier:1.0
                                         constant:0.0];
}


+ (NSLayoutConstraint *)constraintToBottomLockView:(UIView *)viewA toView:(UIView *)viewB
{
    return [NSLayoutConstraint constraintWithItem:viewA
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:viewB
                                        attribute:NSLayoutAttributeBottom
                                       multiplier:1.0
                                         constant:0.0];
}

+ (NSLayoutConstraint *)constraintAligningHorizontalCenterOfView:(UIView *)view withSuperview:(UIView *)superview
{
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superview
                                        attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                         constant:0.0];
}

+ (NSLayoutConstraint *)constraintAligningVerticalCenterOfView:(UIView *)view withSuperview:(UIView *)superview {
    return [NSLayoutConstraint constraintWithItem:view
                                        attribute:NSLayoutAttributeCenterY
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:superview
                                        attribute:NSLayoutAttributeCenterY
                                       multiplier:1.0
                                         constant:0.0];
}


@end
