//
//  SampleForWebview.m
//  TOApps
//
//  Created by tomohiko on 2013/05/19.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "SampleForWebview.h"

@interface SampleForWebview ()

@end

@implementation SampleForWebview

- (void)dealloc {
  [_activityIndicator release];
  if (_webView.loading) [_webView stopLoading];
  _webView.delegate = nil;
  [_webView release];
  [_reloadButton release];
  [_stopButton release];
  [_backButton release];
  [_fowardButton release];
  
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"UIWebView";
  _webView = [[UIWebView alloc] init];
  _webView.delegate = self;
  _webView.frame = self.view.bounds;
  _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _webView.scalesPageToFit = YES;
  [self.view addSubview:_webView];
  //ツールバーボタン
  _reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadDidPush)];
  _stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopDidPush)];
  _backButton = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(backDidPush)];
  _fowardButton = [[UIBarButtonItem alloc] initWithTitle:@"forward" style:UIBarButtonItemStyleBordered target:self action:@selector(forwardDidPush)];
  _activityIndicator = [[UIActivityIndicatorView alloc] init];
  _activityIndicator.frame = CGRectMake(0, 0, 20, 20);
  
  UIBarButtonItem *indicator = [[[UIBarButtonItem alloc] initWithCustomView:_activityIndicator] autorelease];
//  UIBarButtonItem *adjustment = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]autorelease];
  NSArray *buttons = [NSArray arrayWithObjects:_backButton,_fowardButton, _reloadButton, _stopButton, indicator, nil];
  [self setToolbarItems:buttons animated:YES];
  [self.navigationController setToolbarHidden:NO];
}

- (void)reloadDidPush {
  [_webView reload];
}

- (void)stopDidPush {
  if (_webView.loading) {
    [_webView stopLoading];
  }
}

- (void)backDidPush {
  if (_webView.canGoBack) {
    [_webView goBack];
  }
}

- (void)forwardDidPush {
  if (_webView.canGoForward) {
    [_webView goForward];
  }
}

- (void)updateControlEnabled {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = _webView.loading;
  _stopButton.enabled = _webView.loading;
  _backButton.enabled = _webView.canGoBack;
  _fowardButton.enabled = _webView.canGoForward;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com/"]];
  [_webView loadRequest:request];
  [self updateControlEnabled];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [self updateControlEnabled];
//  [_activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self updateControlEnabled];
//  [_activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  [self updateControlEnabled];
//  [_activityIndicator stopAnimating];
}


@end
