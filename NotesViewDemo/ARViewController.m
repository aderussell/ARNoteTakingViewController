//
//  ARViewController.m
//  NotesViewDemo
//
//  Created by Adrian Russell on 03/12/2012.
//  Copyright (c) 2012 Adrian Russell. All rights reserved.
//

#import "ARViewController.h"
#import "NotesViewController.h"

@interface ARViewController () <NotesViewControllerDelegate>

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (IBAction)showNotes:(id)sender
{
    NSLog(@"should show");
    NotesViewController *notesView = [NotesViewController notesViewController];
    NSLog(@"%@", notesView);
    notesView.delegate = self;
    [self.navigationController presentViewController:notesView animated:YES completion:nil];
}

//--------------------------------------------------------------------------------------------------------------------------
#pragma mark - NotesViewController Delegate Methods

- (void)notesWillCloseWithContents:(id)notes
{
}

- (void)notesDidCloseWithContents:(id)notes
{
    self.outputText.text = (NSString *)notes;
}

@end
