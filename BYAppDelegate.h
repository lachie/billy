//
//  BYAppDelegate.h
//  Billy
//
//  Created by Lachie Cox on 22/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BYBill.h"


@interface BYAppDelegate : NSObject {
  NSMetadataQuery *query;
  IBOutlet NSTableColumn *tagColumn;
  IBOutlet PDFView *pdfView;
  IBOutlet NSArrayController *bills;

  BYBill *bill;
}

@property (retain) NSMetadataQuery *query;

@end
