//
//  WebViewController.h
//  TOApps
//
//  Created by tomohiko on 2013/05/25.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate> {
  UIWebView *_wv;
  UIActivityIndicatorView *_activityIndicator;
  UIBarButtonItem *_reloadButton;
  UIBarButtonItem *_backButton;
  UIBarButtonItem *_fowardButton;
  UIBarButtonItem *_homeButton;
}

@property (strong, nonatomic) UIWebView *wv;
@property (nonatomic, retain) NSString *encode_word;

- (void)toHome:(id)sender;
- (void)reloadDidPush;
- (void)backDidPush;
- (void)fowardDidPush;

@end
