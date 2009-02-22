//
//  BYBill.m
//  Billy
//
//  Created by Lachie Cox on 22/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BYBill.h"


@implementation BYBill

@synthesize basename, path, comment, tags, pdfAttributes;

- (id)initWithMetadataItem:(NSMetadataItem *)metadataItem {

  if(self = [super init]) {
    self.path       = [metadataItem valueForAttribute: kMDItemPath];

    // comment 
    NSString *strComment = [metadataItem valueForAttribute: kMDItemFinderComment];
    if(strComment == nil) {
      strComment = @"";
    }

    self.comment    = [[NSAttributedString alloc] initWithString: strComment];
    originalComment = [self.comment copy];

    self.basename = [self.path lastPathComponent];

    // self.title   = [metadataItem valueForAttribute: kMDItemDisplayName];
    // self.tags    = [[metadataItem valueForAttribute: kMDItemKeywords] componentsJoinedByString: @","];
    // self.tags    = [metadataItem valueForAttribute: kMDItemKeywords];
  }

  return self;
}

- (PDFDocument *)pdfDocument {

  if(pdfDocument== nil) {
    NSURL *url = [NSURL fileURLWithPath: self.path];
    pdfDocument = [[PDFDocument alloc] initWithURL: url];
  }

  return pdfDocument;
}

- (NSDictionary *)pdfAttributes {
  if(pdfAttributes == nil) {
	  pdfAttributes = [[NSMutableDictionary dictionaryWithDictionary: self.pdfDocument.documentAttributes] retain];
  }

  return pdfAttributes;
}

- (BOOL)save {
  NSLog(@"saving old bill");
  PDFDocument *doc = [self pdfDocument];

  if(![self.pdfAttributes isEqualToDictionary: [pdfDocument documentAttributes]]) {
    NSLog(@"saving pdf");

    NSAttributedString *fancyString = [self.pdfAttributes objectForKey: PDFDocumentSubjectAttribute];
    NSString *plainString;

    if([fancyString isKindOfClass: [NSAttributedString class]]) {
      if(fancyString == nil) {
        plainString = @"";
      } else {
        plainString = [fancyString string];
      }

      [doc setDocumentAttributes: self.pdfAttributes];
    }

    [self.pdfAttributes setObject: plainString forKey: PDFDocumentSubjectAttribute];
    return [doc writeToURL: [doc documentURL]];
  }

  /* save comment */
  /*
  if(![self.comment isEqualTo: originalComment]) {
    [originalComment release];
    originalComment = [self.comment copy];

    NSString* path = [[doc documentURL] path];
    const char *cPath = [path fileSystemRepresentation];
    const char *cKey = [@"com.apple.metadata:kMDItemFinderComment" UTF8String];

    NSString *strComment = [self.comment string];

    if([strComment length] > 0) {
      const char *cComment = [strComment UTF8String];
      NSUInteger length = [strComment lengthOfBytesUsingEncoding: NSUTF8StringEncoding] + 1;

      setxattr(cPath, cKey, cComment, length, 0, XATTR_NOFOLLOW);
    } else {
    }

  }
  */

  return YES;
}

@end
