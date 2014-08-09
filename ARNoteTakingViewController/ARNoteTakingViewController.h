//
//  ARNoteTakingViewController.h
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

#import <UIKit/UIKit.h>

/** A class that provides a note taking interface that can be used modally, in a navigation controller or in a popover controller. */
@interface ARNoteTakingViewController : UIViewController

/** The textview where notes are entered. This can be used to change fonts or insert text. */
@property (strong, readonly, nonatomic) UITextView *textArea;

/** A block that is called when the note taking view is dismissed. If cancelled is `YES` then the note should be ignored. */
@property (copy, nonatomic) void (^dismissHandler)(BOOL cancelled, NSString *note);

@end

@interface ARNoteTakingViewController (PopoverController)

/** 
 Creates and returns a popover controller containing a note taking view controller.
 @param size The size of the note taking view controller.
 @return A `UIPopoverController` containing a note taking view controller sized as specified.
 @discussion This method should be used if a popover controller is needed for iOS7 else the buttons will not work.
 */
+ (UIPopoverController *)notesViewPopoverWithContentSize:(CGSize)size;

@end
