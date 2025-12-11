//
//  PDFViewSub.m
//  Booklet-maker
//
//  Created by Dominik Schloesser on 2/16/12.
//  Updated to support drag-and-drop of PDF files.
//

#import "PDFViewSub.h"

@implementation PDFViewSub

- (void)awakeFromNib {
    [super awakeFromNib];
    // Register for file URL drags (modern pasteboard type). Fallback for older SDKs.
    if (@available(macOS 10.13, *)) {
        [self registerForDraggedTypes:@[ NSPasteboardTypeFileURL ]];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [self registerForDraggedTypes:@[ NSFilenamesPboardType ]];
#pragma clang diagnostic pop
    }
}

#pragma mark - NSDraggingDestination

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    if ([self canAcceptDraggingInfo:sender]) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    return [self canAcceptDraggingInfo:sender];
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *pb = [sender draggingPasteboard];

    NSURL *url = [self firstPDFURLFromPasteboard:pb];
    if (!url) {
        return NO;
    }

    PDFDocument *doc = [[PDFDocument alloc] initWithURL:url];
    if (!doc) {
        return NO;
    }

    [self setDocument:doc];
    return YES;
}

#pragma mark - Helpers

- (BOOL)canAcceptDraggingInfo:(id<NSDraggingInfo>)sender {
    NSPasteboard *pb = [sender draggingPasteboard];
    return [self firstPDFURLFromPasteboard:pb] != nil;
}

- (NSURL *)firstPDFURLFromPasteboard:(NSPasteboard *)pb {
    // Prefer modern file URL type
    if (@available(macOS 10.13, *)) {
        NSArray<NSURL *> *urls = [pb readObjectsForClasses:@[ NSURL.class ]
                                                   options:@{ NSPasteboardURLReadingFileURLsOnlyKey : @YES }];
        for (NSURL *u in urls) {
            if ([[u pathExtension].lowercaseString isEqualToString:@"pdf"]) {
                return u;
            }
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        NSArray *files = [pb propertyListForType:NSFilenamesPboardType];
        for (NSString *path in files) {
            if ([[path pathExtension].lowercaseString isEqualToString:@"pdf"]) {
                return [NSURL fileURLWithPath:path];
            }
        }
#pragma clang diagnostic pop
    }
    return nil;
}

@end
