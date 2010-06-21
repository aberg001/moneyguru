/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import "MGMainWindow.h"
#import "MGConst.h"
#import "NSEventAdditions.h"
#import "MGMainWindowController.h"

@implementation MGMainWindow
- (void)performClose:(id)sender
{
    if ([sender tag] == MGCloseWindowMenuItem) {
        // Force the close of the whole window.
        [super performClose:sender];
    }
    else {
        // Close tab if there's more than one.
        MGMainWindowController *delegate = [self delegate];
        if ([delegate openedTabCount] > 1) {
            [delegate closeActiveTab];
        }
        else {
            [super performClose:sender];
        }
    }
}

- (BOOL)performKeyEquivalent:(NSEvent *)event 
{
    SEL action = nil;
    if ([event modifierKeysFlags] == (NSCommandKeyMask | NSShiftKeyMask)) {
        if ([event isLeft]) {
            action = @selector(showPreviousView:);
        }
        else if ([event isRight]) {
            action = @selector(showNextView:);
        }
    }
    else if ([event modifierKeysFlags] == NSCommandKeyMask) {
        if ([event isLeft]) {
            action = @selector(navigateBack:);
        }
        else if ([event isRight]) {
            action = @selector(showSelectedAccount:);
        }
    }
    MGMainWindowController *delegate = [self delegate];
    if ((action != nil) && ([delegate validateAction:action])) {
        [delegate performSelector:action withObject:delegate];
        return YES;
    }
    return [super performKeyEquivalent:event];
}
@end
