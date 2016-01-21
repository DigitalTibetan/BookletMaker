//
//  document.h
//  Booklet-maker
//
//  Created by Dominik Schloesser on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface document : NSObject

@property (assign) long pages;
@property (assign) long method;
@property (assign) NSString *sortString;

@end
