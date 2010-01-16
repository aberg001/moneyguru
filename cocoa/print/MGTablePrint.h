/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import <Cocoa/Cocoa.h>
#import "MGPrintView.h"

@interface MGTablePrint : MGPrintView
{
    NSTableView *tableView;
    
    CGFloat columnHeaderY;
    NSFont *rowFont;
    NSDictionary *rowAttributes;
    CGFloat rowTextHeight;
    CGFloat typicalRowHeight;
    CGFloat lastRowYOnLastPage;
    NSInteger rowCount;
    NSMutableArray *cellData;
    NSMutableArray *columnWidths;
    NSMutableArray *rowHeights;
    NSMutableArray *visibleColumns;
}

- (id)initWithPyParent:(id)pyParent tableView:(NSTableView *)aTableView;

- (id)objectValueForTableColumn:(NSTableColumn *)aColumn row:(NSInteger)aRow;
- (void)willDisplayCell:(NSCell *)aCell forTableColumn:(NSTableColumn *)aColumn row:(NSInteger)aRow;
- (CGFloat)indentForTableColumn:(NSTableColumn *)aColumn row:(NSInteger)aRow;
- (CGFloat)heightForRow:(NSInteger)aRow;
- (NSArray *)unresizableColumns;
- (void)drawRow:(NSInteger)aRow inRect:(NSRect)aRect;
- (CGFloat)columnsTotalWidth;
@end