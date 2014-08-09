//
//  ARViewController.m
//  NotesViewDemo
//
//  Created by Adrian Russell on 03/12/2012.
//  Copyright (c) 2012 Adrian Russell. All rights reserved.
//

#import "ARViewController.h"
#import "ARNoteTakingViewController.h"

@interface ARViewController ()
@property UIPopoverController *popover;
@property IBOutlet UITextView *outputArea;
@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.outputArea.layer.borderWidth = 1.0;
}

- (IBAction)showNotes:(id)sender
{
    ARNoteTakingViewController *notesView = [ARNoteTakingViewController new];
    notesView.title = @"Add a Note (Formsheet Modal)";
    notesView.modalPresentationStyle = UIModalPresentationFormSheet;
    
    notesView.dismissHandler = ^(BOOL cancelled, NSString *note) {
        if (!cancelled)
            self.outputArea.text = [@"Formsheet Modal: " stringByAppendingString:note];
    };
    
    [self.navigationController presentViewController:notesView animated:YES completion:nil];
}

- (IBAction)showNotesModalFullscreen:(id)sender
{
    ARNoteTakingViewController *notesView = [ARNoteTakingViewController new];
    notesView.title = @"Add a Note (Fullscreen Modal)";
    notesView.modalPresentationStyle = UIModalPresentationFullScreen;
    
    notesView.dismissHandler = ^(BOOL cancelled, NSString *note) {
        if (!cancelled)
            self.outputArea.text = [@"Fullscreen Modal: " stringByAppendingString:note];
    };
    
    [self presentViewController:notesView animated:YES completion:nil];
}

- (IBAction)showInNavigationController:(id)sender
{
    ARNoteTakingViewController *notesView = [ARNoteTakingViewController new];
    notesView.title = @"Add a Note (Navigation Controller)";
    
    notesView.dismissHandler = ^(BOOL cancelled, NSString *note) {
        if (!cancelled)
            self.outputArea.text = [@"Navigation Controller: " stringByAppendingString:note];
    };
    
    
    [self.navigationController pushViewController:notesView animated:YES];
}


- (IBAction)showPopover:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.popover = [ARNoteTakingViewController notesViewPopoverWithContentSize:CGSizeMake(400, 300)];
        ARNoteTakingViewController *vc = (ARNoteTakingViewController *)self.popover.contentViewController;
        vc.title = @"Add a Note (Popover)";
        
        vc.dismissHandler = ^(BOOL cancelled, NSString *note) {
            if (!cancelled)
                self.outputArea.text = [@"Popover: " stringByAppendingString:note];
        };
        
        vc.modalInPopover = YES;
        
        [self.popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nope" message:@"Popovers not on iPhone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
