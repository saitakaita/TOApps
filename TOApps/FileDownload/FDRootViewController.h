//
//  FDRootViewController.h
//  TOApps
//
//  Created by tomohiko on 2013/06/02.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "SampleBaseController.h"

@interface FDRootViewController : UITableViewController {
  NSMutableArray *_filePathArray;
}

@property (nonatomic, retain) NSMutableArray *filePathArray;

- (NSMutableArray *)scanDocumentsDirectory;

@end
