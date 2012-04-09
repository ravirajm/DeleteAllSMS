#import <ChatKit/ChatKit.h>


%hook CKConversationListController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	%orig;
	
	if (editing) {
		UIBarButtonItem *deleteAll = [[UIBarButtonItem alloc] initWithTitle:@"Delete All" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAll:)];
		self.navigationItem.rightBarButtonItem = deleteAll;
		[deleteAll release];
	}
	else {
		UIBarButtonItem *compose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeButtonClicked:)];
		self.navigationItem.rightBarButtonItem = compose;
		[compose release];
	}
}
%new
- (void)deleteAll:(id)sender {
	CKConversationList *list = MSHookIvar<CKConversationList *>(self, "_conversationList");
	UITableView *messages = MSHookIvar<UITableView *>(self, "_table");
	if ([[list conversations] count] != 0) {
		for (unsigned int i = 0; i < [[list conversations] count]; i++) {
			[list deleteConversationAtIndex:i];
		}
	}
	if ([[list conversations] count] > 0) { 
		[self deleteAll:nil];	
	}
	[messages reloadData];
	[self setEditing:NO animated:NO];
}
%end