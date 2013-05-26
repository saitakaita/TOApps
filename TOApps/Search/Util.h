//
//  Util.h
//  TOApps
//
//  Created by tomohiko on 2013/05/25.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject {
  
}

+ (NSString *)urlencode:(NSString *)text;
+ (NSString *)urldecode:(NSString *)text;

@end
