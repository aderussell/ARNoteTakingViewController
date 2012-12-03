//
//  NotesViewController.m
//  ACE-R
//
//  Created by Adrian Russell on 30/01/2012.
//  Copyright (c) 2012 Adrian Russell. All rights reserved.
//

#import "NotesViewController.h"

#define ORIENTATION_HEIGHT(x) ((UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) ? x.size.height : x.size.width)


@interface NotesViewController () <UITextViewDelegate>
{
    CGRect _originalRect;
}
@end


@implementation NotesViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//--------------------------------------------------------------------------------------------
#pragma mark - device rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


//--------------------------------------------------------------------------------------------
#pragma mark - View lifecycle

+ (NotesViewController *)notesViewController
{
    static dispatch_once_t pred;
    static NotesViewController *viewController = nil;
    
    dispatch_once(&pred, ^(void)
                  {
                      viewController = [[NotesViewController alloc] initWithNibName:@"NotesView" bundle:[NSBundle mainBundle]];
                  });
    viewController.viewText.text = @"";
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    return viewController;
}


- (void)viewDidAppear:(BOOL)animated
{
    _originalRect = self.viewText.frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)  name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.viewText.delegate = self;
    [self.viewText becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)didRotate:(NSNotification *)notification
{
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // KEYBOARD HEIGHT
    NSDictionary *keyboardInfo    = [notification userInfo];
    CGRect keyboardFrameBeginRect = [[keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight  = ORIENTATION_HEIGHT(keyboardFrameBeginRect);
    
    // SCREEN HEIGHT
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat screenHeight = ORIENTATION_HEIGHT(screenRect);
    
    // MODAL POP UP HEIGHT
    CGRect modalRect = self.view.superview.frame;
    CGFloat modalRectHeight = ORIENTATION_HEIGHT(modalRect);
    
    // DISTANCE FROM TOP OF SCREEN
    CGFloat distanceFromTopOfScreen  = (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) ? modalRect.origin.y : modalRect.origin.x;
    
    // DISTANCE FROM BOTTOM OF MODAL VIEW TO BOTTOM OF SCREEN
    CGFloat distanceFromBottom = screenHeight - (modalRectHeight + distanceFromTopOfScreen);
    
    // HOW MUCH THE KEYBOARD WILL OVERLAP THE MODAL VIEW
    CGFloat offsetAmount = (keyboardHeight - distanceFromBottom);

    // reduce the size of the textview so that it sits on top of the keyboard so we can see all the contents.
    CGRect frame = _originalRect;
    frame.size.height -= offsetAmount;
    self.viewText.frame = frame;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.viewText.frame = _originalRect;
}


//---------------------------------------------------------------------------------------------------------

#pragma mark - UITextViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.viewText setNeedsDisplay];
}

//---------------------------------------------------------------------------------------------------------

#pragma mark - IBActions


- (IBAction)done:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(notesWillCloseWithContents:)])
    {
        [self.delegate notesWillCloseWithContents:self.viewText.text];
    }
    
    [self dismissViewControllerAnimated:YES completion:^
     {
         if ([self.delegate respondsToSelector:@selector(notesDidCloseWithContents:)])
         {
             [self.delegate notesDidCloseWithContents:self.viewText.text];
         }
     }];
}



@end
