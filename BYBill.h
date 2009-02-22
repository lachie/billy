//
//  BYBill.h
//  Billy
//
//  Created by Lachie Cox on 22/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PDFKit/PDFKit.h>
#import <sys/xattr.h>


@interface BYBill : NSObject {
  NSString *basename;
  NSString *path;

  NSString *comment;
  NSString *originalComment;

  NSString *tags;
  NSDictionary *pdfAttributes;

  PDFDocument *pdfDocument;
}

@property (copy) NSString *basename;
@property (copy) NSString *path;
@property (copy) NSString *comment;
@property (copy) NSString *tags;

@property (readonly) NSDictionary *pdfAttributes;
@property (readonly) PDFDocument *pdfDocument;


- (id)initWithMetadataItem:(NSMetadataItem *)metadataItem;

@end
