// (c) 2011 by Anton Korenyushkin

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "SearchWindowController.j"

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var window = [[CPWindow alloc] initWithContentRect:CGRectMake(100, 100, 250, 70) styleMask:CPTitledWindowMask],
        contentView = [window contentView],
        textField = [[CPTextField alloc] initWithFrame:CGRectMake(25, 20, 200, 30)];

    [textField setEditable:YES];
    [textField setBezeled:YES];

    [textField setTarget:self];
    [textField setAction:@selector(didSubmitTextField:)];

    [contentView addSubview:textField];
    [window makeFirstResponder:textField];

    [window center];
    [window setTitle:"Twitter Search"];
    [window orderFront:self];
}

- (void)didSubmitTextField:(CPTextField)textField
{
    var searchString = [textField stringValue];
    if (!searchString)
        return;
    [[[SearchWindowController alloc] initWithSearchString:searchString] showWindow:nil];
    [textField setStringValue:""];
    [[textField window] makeKeyAndOrderFront:nil];
}

@end
