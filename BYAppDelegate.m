//
//  BYAppDelegate.m
//  Billy
//
//  Created by Lachie Cox on 22/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BYAppDelegate.h"


@implementation BYAppDelegate

@synthesize query;


- (void)applicationDidFinishLaunching:(NSNotification *)n {
}

- (id)init {
  if (self = [super init]) {
    self.query = [[NSMetadataQuery alloc] init];
    NSLog(@"initting!");

    [query setDelegate: self];

    NSArray *scopes = [NSArray arrayWithObject: @"/Users/lachie/Documents"];
    [query setSearchScopes: scopes];

    NSArray *vla = [NSArray arrayWithObject: kMDItemKeywords];
    [query setValueListAttributes: vla];


    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(finishedGathering:) name: NSMetadataQueryDidFinishGatheringNotification object: query];
    [self startSearching];
  }

  return self;
}

- (void)awakeFromNib {
	[tagColumn setDataCell: [[NSTokenFieldCell alloc] init]];

  [bills addObserver:self
          forKeyPath:@"selection"
             options: (NSKeyValueObservingOptionOld | NSKeyValueObservingOptionPrior)
             context:NULL];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
  return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{

  NSArrayController *arrayController = (NSArrayController *)object;
  BYBill *newBill = [[arrayController selectedObjects] objectAtIndex: 0];

  if(bill != nil && newBill != bill) {
    [bill save];
    [bill release];
  }

  bill = [newBill retain];

  NSLog(@"change: %@", change);

  if(bill != nil) {
    [pdfView setDocument: bill.pdfDocument];
  }
}

- (void)finishedGathering:(NSNotification *)notification {
  NSLog(@"finishedGathering... %d", [query resultCount]);
}

- (id)metadataQuery:(NSMetadataQuery *)query replacementObjectForResultObject:(NSMetadataItem *)result {
  return [[BYBill alloc] initWithMetadataItem: result];
}


- (void)startSearching {
	NSPredicate *p = [NSPredicate predicateWithFormat:@"kMDItemContentType == \"com.adobe.pdf\""];
  [query setPredicate: p];

  //  && kMDItemKeywords == \"itinerary\" && kMDItemKeywords == \"railscamp\"
  //&&  == \"itinerary\"


  [query startQuery];
}


@end
