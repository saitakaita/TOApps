//
//  RootViewController.m
//  TOApps
//
//  Created by tomohiko on 2013/05/19.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "RootViewController.h"
#import "TOAppDelegate.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.title = @"Menu";
  self.lists = [NSArray arrayWithObjects:
                @"SampleForSubviews",
                @"SampleForWebview",
                @"WebViewController",
                @"SearchViewController",
                @"FDRootViewController",
                nil];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  NSString *title = [self.lists objectAtIndex:indexPath.row];
  cell.textLabel.text = [title stringByReplacingOccurrencesOfString:@"sampleFor" withString:@""];
  return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *className = [self.lists objectAtIndex:indexPath.row];
  Class class = NSClassFromString(className);
  id viewController = [[[class alloc] init] autorelease];
  if (!viewController) {
    localeconv();
  }
  [self.navigationController pushViewController:viewController animated:YES];
}

@end
