
Notes Taking Modal is a modal view for the iPad that resembles a sheet of note paper.

It is designed to be fired and forgotten.


To create and show the notes view...


NotesViewController *notesView = [NotesViewController notesViewController];
notesView.delegate = self;
[self.navigationController presentViewController:notesView animated:YES completion:nil];


To get note text when view is dismissed implement one or both of the following delegate methods...

- (void)notesWillCloseWithContents:(id)notes;
- (void)notesDidCloseWithContents:(id)notes;