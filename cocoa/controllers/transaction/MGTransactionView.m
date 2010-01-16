/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import "MGTransactionView.h"
#import "MGTransactionPrint.h"
#import "MGUtils.h"

@implementation MGTransactionView
- (id)initWithDocument:(MGDocument *)aDocument
{
    self = [super init];
    [NSBundle loadNibNamed:@"TransactionTable" owner:self];
    transactionTable = [[MGTransactionTable alloc] initWithDocument:aDocument view:tableView];
    filterBar = [[MGFilterBar alloc] initWithDocument:aDocument view:filterBarView forEntryTable:NO];
    NSArray *children = [NSArray arrayWithObjects:[transactionTable py], [filterBar py], nil];
    Class pyClass = [MGUtils classNamed:@"PyTransactionView"];
    py = [[pyClass alloc] initWithCocoa:self pyParent:[aDocument py] children:children];
    return self;
}
        
- (void)dealloc
{
    [py release];
    [transactionTable release];
    [filterBar release];
    [super dealloc];
}

- (oneway void)release
{
    if ([self retainCount] == 2)
        [py free];
    [super release];
}

- (PyTransactionView *)py
{
    return (PyTransactionView *)py;
}

- (MGPrintView *)viewToPrint
{
    return [[[MGTransactionPrint alloc] initWithPyParent:[transactionTable py] 
        tableView:[transactionTable tableView]] autorelease];
}

- (id)fieldEditorForObject:(id)asker
{
    return [transactionTable fieldEditorForObject:asker];
}

// Python --> Cocoa
-(void)refreshTotals
{
    [totalsLabel setStringValue:[py totals]];
}
@end