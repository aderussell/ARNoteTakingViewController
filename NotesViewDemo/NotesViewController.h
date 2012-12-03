//
//  NotesViewController.h
//  ACE-R
//
//  Created by Adrian Russell on 30/01/2012.
//  Copyright (c) 2012 Adrian Russell. All rights reserved.
//

#import <UIKit/UIKit.h>

/** The NotesViewControllerDelegate protocol defines the mothods that a NotesViewController instance calls for its delegate. A subclass of TaskViewController that wants the notes view should implement these functions*/
@protocol NotesViewControllerDelegate <NSObject>
@optional
/** @name Responding to Actions */

/** Sent to the delegate when the notes view is dismissed and about to close.
 @param notes A string containing the notes entered in the view.
 */
- (void)notesWillCloseWithContents:(id)notes;

/** Sent to the delegate when the notes view is dismissed and has closed.
 @param notes A string containing the notes entered in the view.
 */
- (void)notesDidCloseWithContents:(id)notes;

@end

//----------------------------------------------------------------------------------------------------------

/** This class is the controller for the note taking view. There is no reason to subclass this class.
 */
@interface NotesViewController : UIViewController

/** */
+ (NotesViewController *)notesViewController;

/** The delegate. */
@property(weak, nonatomic) id<NotesViewControllerDelegate>delegate;

/** The textview where notes are entered. */
@property (strong, nonatomic) IBOutlet UITextView *viewText;


/**
 @param sender The object that called the method.
 */
- (IBAction)done:(id)sender;


@end
