//
//  ARNoteTakingViewController.m
//
//  Created by Adrian Russell on 30/01/2012.
//  Copyright (c) 2014 Adrian Russell. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import "ARNoteTakingViewController.h"
#import "NSLayoutConstraint+ARConvenientAdditions.h"


#pragma mark - Class Implementation

@interface ARNoteTakingViewController ()

/** The title label in titlebar that displays self.title. */
@property () UILabel *titleLabel;

/** The contraint setting the height of the titlebar */
@property () NSLayoutConstraint *titleBarHeightConstraint;

/** The popover controller containing note taking view, if used. */
@property (weak) UIPopoverController *popover;

// private redefinition to make readwrite
@property (strong, nonatomic, readwrite) UITextView *textArea;
@end


//--------------------------------------------------------//
#pragma mark - Class Implementation

@implementation ARNoteTakingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        // create the topbar
        UIView *topBarView = [UIView new];
        topBarView.tintColor = [UIColor whiteColor];
        topBarView.translatesAutoresizingMaskIntoConstraints = NO;
        topBarView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:topBarView];
        CGFloat height = ([[UIApplication sharedApplication] isStatusBarHidden]) ? 44 : 64;
        self.titleBarHeightConstraint = [NSLayoutConstraint heightConstraintForView:topBarView height:height];
        [topBarView addConstraint:self.titleBarHeightConstraint];
        [self.view addConstraint:[NSLayoutConstraint constraintToTopLockView:topBarView   toView:self.view]];
        [self.view addConstraint:[NSLayoutConstraint constraintToLeftLockView:topBarView  toView:self.view]];
        [self.view addConstraint:[NSLayoutConstraint constraintToRightLockView:topBarView toView:self.view]];
        
        
        // add close button
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        closeButton.translatesAutoresizingMaskIntoConstraints = NO;
        [closeButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:closeButton];
        [topBarView addConstraint:[NSLayoutConstraint heightConstraintForView:closeButton height:44]];
        [topBarView addConstraint:[NSLayoutConstraint widthConstraintForView:closeButton  width:70]];
        [topBarView addConstraint:[NSLayoutConstraint constraintToLeftLockView:closeButton   toView:topBarView]];
        [topBarView addConstraint:[NSLayoutConstraint constraintToBottomLockView:closeButton toView:topBarView]];
        
        // add done button
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        doneButton.translatesAutoresizingMaskIntoConstraints = NO;
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:doneButton];
        [topBarView addConstraint:[NSLayoutConstraint heightConstraintForView:doneButton height:44]];
        [topBarView addConstraint:[NSLayoutConstraint widthConstraintForView:doneButton  width:70]];
        [topBarView addConstraint:[NSLayoutConstraint constraintToRightLockView:doneButton  toView:topBarView]];
        [topBarView addConstraint:[NSLayoutConstraint constraintToBottomLockView:doneButton toView:topBarView]];
        
        
        // add title label to topbar
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel = titleLabel;
        [topBarView addSubview:titleLabel];
        [topBarView addConstraint:[NSLayoutConstraint heightConstraintForView:titleLabel height:44]];
        [topBarView addConstraint:[NSLayoutConstraint constraintToBottomLockView:titleLabel toView:topBarView]];
        [topBarView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:closeButton
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:0.0]];
        [topBarView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:doneButton
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:0.0]];
        
        
        UITextView *text = [UITextView new];
        text.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
        text.font = [UIFont systemFontOfSize:16.0];
        text.translatesAutoresizingMaskIntoConstraints = NO;
        text.alwaysBounceVertical = YES;
        [self.view addSubview:text];
        text.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        text.scrollEnabled = YES;
        self.textArea = text;
        
        [self.view addConstraint:[NSLayoutConstraint constraintToLeftLockView:text   toView:self.view]];
        [self.view addConstraint:[NSLayoutConstraint constraintToRightLockView:text  toView:self.view]];
        [self.view addConstraint:[NSLayoutConstraint constraintToBottomLockView:text toView:self.view]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:text
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:topBarView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
    }
    return self;
}


//--------------------------------------------------------//
#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (((self.presentingViewController && self.modalPresentationStyle == UIModalPresentationFullScreen) || self.navigationController) && ![[UIApplication sharedApplication] isStatusBarHidden]) {
        self.titleBarHeightConstraint.constant = 64;
    } else {
        self.titleBarHeightConstraint.constant = 44;
    }
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textArea becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

//--------------------------------------------------------//
#pragma mark - Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//--------------------------------------------------------//
#pragma mark - Setters & Getters

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.titleLabel.text = title;
}



//--------------------------------------------------------//
#pragma mark - Actions


- (void)done:(id)sender
{
    if (self.dismissHandler) {
        self.dismissHandler(NO, self.textArea.text);
    }
    [self close];
}

- (void)cancel:(id)sender
{
    if (self.dismissHandler) {
        self.dismissHandler(YES, self.textArea.text);
    }
    
    [self close];
}

- (void)close
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else if (self.popover) {
        [self.popover dismissPopoverAnimated:YES];
    }
}

@end


//--------------------------------------------------------//
#pragma mark - Class Popover Addition

@implementation ARNoteTakingViewController (PopoverController)

+ (UIPopoverController *)notesViewPopoverWithContentSize:(CGSize)size
{
    ARNoteTakingViewController *viewController = [self new];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:viewController];
    popover.popoverContentSize = size;
    viewController.popover = popover;
    return popover;
}

@end


