//
//  PSAppDelegate.m
//  Booklet-maker
//
//  Created by Dominik Schloesser on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "PSAppDelegate.h"
#import "document.h"

@implementation PSAppDelegate
@synthesize statusBar = _statusBar;
@synthesize MyPDFThumbs = _MyPDFThumbs;

@synthesize window = _window;
@synthesize calcOptions = _calcOptions;
@synthesize sortPages = _sortPages;
@synthesize buttonCalc = _buttonCalc;

@synthesize doc;
@synthesize PDFvs;
@synthesize MyPDFView = _MyPDFView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    document *ad = [[document alloc] init];
    [self setDoc:ad];
    
/*    NSString *path=@"~/Desktop/test.pdf";
    NSLog(@"Opening File %@",path);
  */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aPDFViewNewDoc:)
                                                 name:PDFViewDocumentChangedNotification object:nil];

    /*
     PDFDocument *pdfDoc = [[PDFDocument alloc] initWithURL:[NSURL fileURLWithPath:path]];
    [self.MyPDFView setDocument: pdfDoc]; 
    */
//    [self.numberPages setStringValue:[NSString stringWithFormat:@"%ld",[pdfDoc pageCount]]];

    /*
    [self.MyPDFView registerForDraggedTypes:
     [NSArray arrayWithObjects:NSFilenamesPboardType,nil]];
*/
    [self.MyPDFView setAllowsDragging:TRUE];
//    [self.MyPDFView setDelegate:PDFvs];
    [self.MyPDFThumbs setPDFView:self.MyPDFView];
}

- (void)aPDFViewNewDoc:(NSNotification *)notification
{
    PDFView *myPV = [notification object];
    PDFDocument *pdfDoc = [myPV document];
    
    [self.statusBar setStringValue:[NSString stringWithFormat:@"%ld pages",[pdfDoc pageCount]]];
    
    NSString* theFileName = [[[[[[myPV document] documentURL] filePathURL] path /*absoluteString*/] lastPathComponent] stringByDeletingPathExtension];
    [self.window setTitle:theFileName];
    // Retrieve information about the document and update the panel
}


- (IBAction)clickCalc:(id)sender {
    NSLog(@"Calc click");
    int pages = (int)[[self.MyPDFView document] pageCount];

    int opages; opages=pages;
    int n,p,i,j,k;
    int nr, n1, no;
    bool bPortrait=true;
    NSString *nsCount;
    int nx=0; int ny=0;
    NSString *tout,*tnew;
    NSString *filePostfix;
    
    NSString* theFileName = [[[[[[self.MyPDFView document] documentURL] filePathURL] path] lastPathComponent] stringByDeletingPathExtension];
    
    NSString *myHomeDir=NSHomeDirectoryForUser(NSUserName());

    
    NSLog(@"A6 %d",pages);
    n = pages;
    tout = @"";
    
    switch ([self.doc method])
    {
        case 0:// A6
        {
            filePostfix=@"-A6x4";
            bPortrait=true; nx=2; ny=2;
            if (n % 8 != 0 || n < 7)
            {
                n = (n + 8) / 8; n = n * 8;
                opages=n;
                [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
            }
            p = n / 4;
            for (i = 0; i < p / 2; i++)
            {
                for (j = 0; j < 8; j++)
                {
                    nr = i * 8 + j;
                    n1 = j % 4;
                    if (j > 3) n1 = (n1 ^ 1);
                    no=(n1 * p + ((nr / 4)) + 1);
                    tnew = [NSString stringWithFormat:@"%d,",no];
                    tout = [tout stringByAppendingString:tnew];
                }
            }            
        }
        break;
        case 1:// A5 2x1
        {
            filePostfix=@"-A5x2";
            bPortrait=false; nx=2; ny=1;
            if (n % 4 != 0 || n < 3)
            {
                n = (n + 4) / 4; n = n * 4;
                opages=n;
                [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
            }
            
            p = n / 2;
            for (i = 0; i < p/2; i++)
            {
                no = i*2+1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i*2 + p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = (i*2 + p + 1 + 1);
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = (i*2 + 1 + 1);
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
            }
        }
            break;
        case 2:// A5 booklet
        {
            filePostfix=@"-A5-Booklet";
            bPortrait=false; nx=2; ny=1;
            if (n % 4 != 0 || n < 3)
            {
                n = (n + 4) / 4; n = n * 4;
                opages=n;
                [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
            }
            
            p = n / 2;
            n1 = n;
            for (i = 1; i < p; i = i + 2)
            {
                no = n1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = (i + 1);
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = (n1 - 1);
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                n1 = n1 - 2;
            }
        }
            break;
        case 3: // A4 pecha 3x1
        {
            filePostfix=@"-PechaPrint";
            bPortrait=false; nx=1; ny=3;
            if (n % 6 != 0 || n < 5)
            {
                n = (n + 6) / 6; n = n * 6;
                opages=n;
                [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
            }
            
            p = n / 3; // piles of pechas
            
            for (i = 0; i < n/6; i++)
            {
                no = i * 2 + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 2 * p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                
                no = i * 2 + 2 * p + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + p + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
            }
        }
            break;
        case 4: // A4 pecha 1x6
        {
            filePostfix=@"-PechaSmallPrint";
            bPortrait=true; nx=1; ny=6;
            if (n % 12 != 0 || n < 11)
            {
                n = (n + 12) / 12; n = n * 12;
                opages=n;
                [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
            }
            
            p = n / 6; // piles of pechas
            
            for (i = 0; i < n / 12; i++)
            {
                no = i * 2 + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 2 * p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 3 * p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 4 * p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 5 * p + 1;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                
                no = i * 2 + 5 * p + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 4 * p + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 3 * p + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 2 * p + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + p + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = i * 2 + 2;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
            }
        }
            break;
        case 5: // A4 pecha 6x2
        {
            filePostfix=@"-PechaPrint6x2";
            bPortrait=true; nx=2; ny=6;
            if (n % 24 != 0 || n < 23)
            {
                n = (n + 24) / 24; n = n * 24;
                opages=n;
                [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
            }
            p = n / 12;
            for (i = 0; i < p / 2; i++)
            {
                for (j = 0; j < 24; j++)
                {
                    nr = i * 24 + j;
                    n1 = j % 12;
                    if (j > 11) n1 = (n1 ^ 1);
                    no = (n1 * p + ((nr / 12)) + 1);
                    tnew = [NSString stringWithFormat:@"%d,",no];
                    tout = [tout stringByAppendingString:tnew];
                }
            }
            
        }
            break;
        case 6: // Sort odd and even
        {
            filePostfix=@"-OddEven";
            bPortrait=true; nx=1; ny=1;
            if (n % 2 != 0)
            {
                n = n + 1;
                opages=n;
                [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
            }
            
            p = n / 2;
            for (i = 1; i <= p; i++)
            {
                no = i;
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
                no = (p+i);
                tnew = [NSString stringWithFormat:@"%d,",no];
                tout = [tout stringByAppendingString:tnew];
            }
        }
            break;
        case 7: // A6-layered
        {
            nsCount=[self.layerCount stringValue];
            NSLog(@"lCount=%@",nsCount);
        }
            break;
        case 8: // A5-layered
        {
            nsCount=[self.layerCount stringValue];
            NSLog(@"lCount=%@",nsCount);
        }
            break;
        default:
        {
            filePostfix=@"-STRANGE";
           NSLog(@"Strange things happened! ");
        }
            break;
    }
    
    tout = [tout substringWithRange: NSMakeRange(0, [tout length]-1)];
    [self.sortPages setStringValue:tout];
    
    NSPasteboard *pasteBoard = [NSPasteboard generalPasteboard];
    [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
    [pasteBoard setString: tout forType:NSStringPboardType];
    
    NSLog(@"opages=%d pages=%d",opages,pages);
    PDFDocument *dc;
    dc=[self.MyPDFView document];
    if (opages != pages)
    {
        int i;
        for (i=pages; i<=opages-1; i++)
        {
            PDFPage *pg; 
            pg=[dc pageAtIndex:i-1];
            NSRect rs=[pg boundsForBox:kPDFDisplayBoxMediaBox];
            PDFPage *pn = [[PDFPage alloc] init];
            [pn setBounds:rs forBox:kPDFDisplayBoxMediaBox];
            rs=[pn boundsForBox:kPDFDisplayBoxMediaBox];
            NSRectFill(rs);
            
            [dc insertPage:pn atIndex:i];
            n=(int)[dc pageCount];
            NSLog(@"Added page, now: %d",n);
        }
        [self.MyPDFView setDocument:dc];
        [self.statusBar setStringValue:[NSString stringWithFormat:@"%d pages",n]];
    }
    
    NSString *outPath1=[NSString stringWithFormat:@"%@/%@", myHomeDir, @"temp1-bm23"];

    [dc writeToFile:outPath1];
    PDFDocument *pdfDoc2 = [[PDFDocument alloc] initWithURL:[NSURL fileURLWithPath:outPath1]];
    [self.MyPDFView setDocument: pdfDoc2]; 
    
    NSLog(@"Start scramble");
    
    NSArray *li=[tout componentsSeparatedByString:@","];
    n=(int)[pdfDoc2 pageCount];
    PDFDocument *pdfDS = [[PDFDocument alloc] init];
    PDFPage *pi;
    for (i=0; i<n; i++)
    {
        PDFPage *pt;
        NSUInteger iu=i;
        j=[[li objectAtIndex:iu] intValue]-1;
        pt=[dc pageAtIndex:j];
        NSImage *ni=[[NSImage alloc] initWithData:[pt dataRepresentation]];
        pi=[[PDFPage alloc] initWithImage:ni];
        [pdfDS insertPage:pi atIndex:i];
        NSLog(@"Page %d from org added to new page %d",j,i);
    }

    NSString *outPath2=[NSString stringWithFormat:@"%@/%@", myHomeDir, @"temp2-bm23"];
    [pdfDS writeToFile:outPath2];
    PDFDocument *pdfDoc3 = [[PDFDocument alloc] initWithURL:[NSURL fileURLWithPath:outPath2]];
    [self.MyPDFView setDocument: pdfDoc3]; 
    NSLog(@"Done scramble - begin page merge");
    
    NSRect rs=[pi boundsForBox:kPDFDisplayBoxMediaBox];
    rs.size.width=rs.size.width*nx;
    rs.size.height=rs.size.height*ny;
    
    NSString *outName=[NSString stringWithFormat:@"%@%@.pdf", theFileName, filePostfix];
    NSString *outPath=[NSString stringWithFormat:@"%@/Desktop/%@", myHomeDir, outName];
    
    CGContextRef ctx;
    ctx=CGPDFContextCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:outPath], &rs, nil);
    CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh); 
    CGContextSetRenderingIntent(ctx, kCGRenderingIntentDefault); 
    for (i=0; i<n/nx/ny; i++)
    {
        NSLog(@"TargetPage %d",i+1);
        CGContextBeginPage(ctx, &rs);
        for (j=0; j<ny; j++)
        {
            for (k=0; k<nx; k++)
            {
                NSLog(@"SourcePage %d",i*ny+j);
                NSRect rsd=rs;
                rsd.origin.x=k*rs.size.width/nx;
                rsd.origin.y=(ny-(j+1))*rs.size.height/ny;
                rsd.size.height=rs.size.height/ny;
                rsd.size.width=rs.size.width/nx;
                CGContextSaveGState(ctx);
                CGPDFPageRef pdfPage = CGPDFDocumentGetPage([pdfDoc3 documentRef], i*ny*nx+j*nx+k+1);
                CGAffineTransform pdfXfm = CGPDFPageGetDrawingTransform( pdfPage, kCGPDFMediaBox, rsd, 0, true );
                CGContextConcatCTM( ctx, pdfXfm );
                CGContextDrawPDFPage( ctx, pdfPage );
                CGContextRestoreGState(ctx);
            }
        }
        CGContextEndPage(ctx);
    }    
    CGPDFContextClose(ctx);
    PDFDocument *pdfDoc4 = [[PDFDocument alloc] initWithURL:[NSURL fileURLWithPath:outPath]];
    [self.MyPDFView setDocument: pdfDoc4]; 
    NSLog(@"Done all");

    }




- (IBAction)clickMatrix:(id)sender {
    NSLog(@"Matrix click");
    NSButtonCell *selCell = [sender selectedCell];
    long tag = [selCell tag];
    [self.doc setMethod:tag];
    NSLog(@"Selected cell is %ld", tag);
    long tag2 = [self.doc method];
    NSLog(@"Method: %ld",tag2);
}

- (IBAction)clickExit:(id)sender {
    NSLog(@"Exit button");
    exit(0);
}

- (IBAction)mFileOpen:(id)sender {
    NSOpenPanel *op = [NSOpenPanel openPanel];
    NSArray *fta=[NSArray arrayWithObjects:@"pdf", nil];
    [op setAllowedFileTypes:fta];
    [op setAllowsOtherFileTypes:NO];
    [op setAllowsMultipleSelection:NO];
    if ([op runModal] == NSOKButton)
    {
        NSURL *nu =  [op URL];   //[op filename]; // XXX
        PDFDocument *pdfDoc = [[PDFDocument alloc] initWithURL:nu];
                               //[NSURL fileURLWithPath:filenameX]];
        [self.MyPDFView setDocument: pdfDoc]; 
    }
}

- (IBAction)mFilePrint:(id)sender {
    NSPrintInfo *pi=[[NSPrintInfo alloc] init];
    
 //   PMPrintSettings *pm=[pi PMPrintSettings];
    
    [self.MyPDFView printWithInfo:pi autoRotate:YES pageScaling:kPDFPrintPageScaleToFit];
}

- (IBAction)mSave:(id)sender {
    NSSavePanel *sp=[NSSavePanel savePanel];
    NSArray *fta=[NSArray arrayWithObjects:@"pdf", nil];
    [sp setAllowedFileTypes:fta];
    [sp setAllowsOtherFileTypes:NO];
    if ([sp runModal]==NSOKButton)
    {
        [[self.MyPDFView document] writeToURL:[sp URL]];
    }
}
@end
