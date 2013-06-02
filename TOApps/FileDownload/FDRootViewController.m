//
//  FDRootViewController.m
//  TOApps
//
//  Created by tomohiko on 2013/06/02.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "FDRootViewController.h"

@interface FDRootViewController ()

@end

@implementation FDRootViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setTitle:@"Downloader"];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  NSMutableArray *array = [self scanDocumentsDirectory];
  [self setFilePathArray:array];
  [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return YES;
}

#pragma mark - Table view data source

- (NSMutableArray *)scanDocumentsDirectory {
  NSString *docDirPath;
  docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSArray *contents;
  contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docDirPath error:NULL];
  
  NSMutableArray *filePathArray;
  filePathArray = [NSMutableArray arrayWithCapacity:0];

  for (NSString *path in contents) {
    path = [docDirPath stringByAppendingPathComponent:path];
    [filePathArray addObject:path];
  }
  return filePathArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.filePathArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell==nil) {
    cell = [[[UITableViewCell alloc]
             initWithStyle:UITableViewCellStyleDefault
             reuseIdentifier:CellIdentifier] autorelease];
  }
  
  NSString *filePath = [self.filePathArray objectAtIndex:indexPath.row];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *fileName = [fileManager displayNameAtPath:filePath];
  
  cell.textLabel.text = fileName;
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark Memory management

- (void)didReceiveMemoryWarning  {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  [_filePathArray release];
  [super dealloc];
}


@end
