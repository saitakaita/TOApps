//
//  Util.m
//  TOApps
//
//  Created by tomohiko on 2013/05/25.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSString *)urlencode:(NSString *)text {
// ARCのキャスト
//  CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)text, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]~", kCFStringEncodingUTF8);
//
//  NSString *str = [NSString stringWithString:(__bridge NSString *)strRef];
//  CFRelease(strRef);

  NSString *str = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)text, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]~", kCFStringEncodingUTF8);

  return str;
}

//decode

+ (NSString *)urldecode:(NSString *)text {
// ARCのキャスト
//  CFStringRef strRef = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
//                                                                               NULL,
//                                                                               (__bridge CFStringRef)text,
//                                                                               CFSTR(""),
//                                                                               kCFStringEncodingUTF8);
//  NSString *str = [NSString stringWithString:(__bridge NSString *)strRef];
//  CFRelease(strRef);
  
  NSString *str = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)text, CFSTR(""), kCFStringEncodingUTF8);
  
  return str;
}

@end
