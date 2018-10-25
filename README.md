## :warning: Deprecated :warning:

This component relies on `UIPopoverController` which was deprecated in iOS9. As such the whole component has been deprecated and should not be used with any production code.

------------------------

# ARNoteTakingViewController

ARNoteTakingViewController is an iOS View Controller that provides a basic interface for taking a note.

The view controller can be used either modally, in a navigation controller, or in a popover controller.

## Using for modal or navigation controller
The view controller works like any other and can be created simply by calling `init`.

## Using the popover controller
There is a supplied method `+ (UIPopoverController *)notesViewPopoverWithContentSize:(CGSize)size;` that should be used when a popover is required as opposed to creating an ARNoteTakingViewController and embedding in a UIPopoverController yourself.

## Handling
ARNoteTakingViewController has a property that allows you to add a block to be notified when the view controller is dismiised.

`@property (copy, nonatomic) void (^dismissHandler)(BOOL cancelled, NSString *note);`

The `cancelled` argument informs if the note was cancelled or should be saved; if it is `YES` then ignore the note

The `note` argument contains whatever note the user has written.
