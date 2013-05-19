//
//  RootViewController.h
//  TOApps
//
//  Created by tomohiko on 2013/05/19.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
  NSArray *_lists;
}

@property (nonatomic, retain) NSArray *lists;

@end
