//
//  SampleForWebview.h
//  TOApps
//
//  Created by tomohiko on 2013/05/19.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "SampleBaseController.h"

@interface SampleForWebview : SampleBaseController <UIWebViewDelegate> {
  @private
  UIWebView *_webView;
  UIActivityIndicatorView *_activityIndicator;
  UIBarButtonItem *_reloadButton;
  UIBarButtonItem *_stopButton;
  UIBarButtonItem *_backButton;
  UIBarButtonItem *_fowardButton;
}

@end
