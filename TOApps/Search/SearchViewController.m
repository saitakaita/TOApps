//
//  SearchViewController.m
//  TOApps
//
//  Created by tomohiko on 2013/05/25.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "SearchViewController.h"
#import "WebViewController.h"

@interface SearchViewController ()

@property (retain, nonatomic) UITableView *tableView;

@end

@implementation SearchViewController {
  @private
  UITextField *tf;
  NSMutableArray *wArray;
  NSMutableArray *tArray;
  
  NSMutableArray *dateSection;
  NSString *iData;
}

@synthesize tableView = _tableView;

- (void)dealloc {
  
  
  [super dealloc];
}

- (void)viewDidLoad {
  [super viewDidLoad];
 
//  self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  [self.view addSubview:tableView];
  tf = [[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250, 30)] autorelease];
  tf.center = CGPointMake(self.view.bounds.size.width /2, 65);
  tf.borderStyle = UITextBorderStyleRoundedRect;
  tf.returnKeyType = UIReturnKeySearch;
  tf.placeholder = @"検索";
  tf.clearButtonMode = UITextFieldViewModeAlways;
  [tf addTarget:self action:@selector(hoge:) forControlEvents:UIControlEventEditingDidEndOnExit];
  [self.view addSubview:tf];
  
  _tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 100, 300, 365) style:UITableViewStyleGrouped] autorelease];
//  _tableView.center = CGPointMake(self.view.bounds.size.width /2, 100);
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.view addSubview:_tableView];
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *dir  = [paths objectAtIndex:0];
  FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"searchLog.sqlite"]];
  
  dateSection = [[NSMutableArray alloc] init];

  [db open];
  
  FMResultSet *fResult = [db executeQuery:@"select distinct date from words order by id desc"];
  while ([fResult next]) {
    iData = [fResult stringForColumn:@"date"];
    [dateSection addObject:iData];
  }
  [db close];
  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [tf resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return dateSection.count;
}

//セクションタイトル
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  for (int i=0; i < [dateSection count]; i++) {
    if (section == i) {
      NSString *str = [[NSString alloc] initWithFormat:@"%@ 検索履歴",[dateSection objectAtIndex:i]];
      return str;
    }
  }
  return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *dir  = [paths objectAtIndex:0];
  FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"searchLog.sqlite"]];
  wArray = [[[NSMutableArray alloc] init] autorelease];
  [db open];
  for (int i=0; i < [dateSection count]; i++) {
    if (section == i) {
    
      FMResultSet *fResult = [db executeQuery:@"select * from words where date = ?",[dateSection objectAtIndex:i]];
      while ([fResult next]) {
        iData = [fResult stringForColumn:@"words"];
        [wArray addObject:iData];
      }
      return [wArray count];
    }
  }
  [db close];
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  }
  wArray = [[[NSMutableArray alloc] init] autorelease];
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *dir   = [paths objectAtIndex:0];
  FMDatabase *db  = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"searchLog.sqlite"]];
  [db open];
  
  for (int i=0; i < [dateSection count]; i++) {
    if (indexPath.section == i) {
      FMResultSet *fResult = [db executeQuery:@"select * from words where date = ? order by id desc",[dateSection objectAtIndex:i]];
      while ([fResult next]) {
        iData = [fResult stringForColumn:@"words"];
        [wArray addObject:iData];
      }
      cell.textLabel.text = [wArray objectAtIndex:indexPath.row];
    }
  }
  [db close];
  return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  wArray = [[[NSMutableArray alloc] init] autorelease];
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *dir  = [paths objectAtIndex:0];
  FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"searchLog.sqlite"]];
  [db open];
  
  for (int i=0; i < [dateSection count]; i++) {
    if (indexPath.section == i) {
      FMResultSet *fResult = [db executeQuery:@"select * from words where date = ? order by id desc",[dateSection objectAtIndex:i]];
      while ([fResult next]) {
        iData = [fResult stringForColumn:@"words"];
        [wArray addObject:iData];
      }
      for (int m=0; m < [wArray count]; m++) {
        if (indexPath.row == m) {
          WebViewController *dialog = [[WebViewController alloc] init];
          dialog.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
          dialog.encode_word = [NSString stringWithString:[Util urlencode:[wArray objectAtIndex:m]]];
          [self presentViewController:dialog animated:YES completion:NULL];
        }
      }
    }
  }
  [db close];
}

- (void)hoge:(UITextField *)textField {
  LOG(@"hoge>text:%@",textField);
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *dir  = [paths objectAtIndex:0];
  LOG(@"dir:%@",dir);
  FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"searchLog.sqlite"]];
  
  NSString *strWords = [[NSString alloc] initWithFormat:@"%@",tf.text];
  
  NSString *sqll = @"CREATE TABLE IF NOT EXISTS words (id INTEGER PRIMARY KEY AUTOINCREMENT, words TEXT, date TEXT)";
  
  NSDate *today = [NSDate date];
  NSLocale *local_ja = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
  NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
  [formatter setDateStyle:NSDateFormatterMediumStyle];
  [formatter setLocale:local_ja];
  NSString *strTime = [[NSString alloc] initWithFormat:@"%@", [formatter stringFromDate:today]];
  
  [db open];
  [db executeUpdate:sqll];
  [db beginTransaction];
  [db executeUpdate:@"INSERT INTO words (words,date) VALUES (?,?)",strWords, strTime];
  [db commit];
  [db close];
  
  WebViewController *dialog = [[WebViewController alloc] init];
  dialog.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  dialog.encode_word = [NSString stringWithString:[Util urlencode:strWords]];
  [self presentViewController:dialog animated:YES completion:NULL];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
