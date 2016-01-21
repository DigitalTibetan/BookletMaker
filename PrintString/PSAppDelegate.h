//
//  PSAppDelegate.h
//  Booklet-maker
//
//  Created by Dominik Schloesser on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class document;
@class PDFViewSub;

@interface PSAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSMatrix *calcOptions;
@property (strong) IBOutlet NSTextFieldCell *sortPages;
@property (strong) IBOutlet NSTextField *layerCount;
@property (strong) IBOutlet NSButton *buttonCalc;
- (IBAction)clickCalc:(id)sender;
- (IBAction)clickMatrix:(id)sender;
- (IBAction)clickExit:(id)sender;
@property (strong) document *doc;
@property (strong) PDFViewSub *PDFvs;
@property (strong) IBOutlet PDFView *MyPDFView;
- (IBAction)mFileOpen:(id)sender;
- (IBAction)mFilePrint:(id)sender;
- (IBAction)mSave:(id)sender;
@property (strong) IBOutlet NSTextField *statusBar;
@property (strong) IBOutlet PDFThumbnailView *MyPDFThumbs;
@end
