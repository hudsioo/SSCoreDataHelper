//
//  MasterViewController.m
//  CoredataHelper
//
//  Created by hudsioo on 3/18/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "SSCoreDataHelper.h"

#import "User.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.userArray = [[NSMutableArray alloc]init];
    
    //Set ManageObjectContext
    [[SSCoreDataHelper sharedInstance] managedObjectContext];
    
    //Load Data
    [self loadCoreData];

}

- (void)loadCoreData{
    self.userArray = [[SSCoreDataHelper sharedInstance] getDataForEntity:@"User" withSortKey:@"createDate" andSortAscending:YES];
    [self.tableView reloadData];
}


- (void)insertNewObject:(id)sender
{
  
    NSMutableDictionary * tempDic = [NSMutableDictionary dictionary];
    [tempDic setValue:@"Somsak" forKey:@"name"];
    [tempDic setValue:@"12345212345" forKey:@"user_id"];
    [tempDic setValue:@"somsak@me.com" forKey:@"email"];
    [tempDic setValue:[NSDate date] forKey:@"createDate"];

    if ([[SSCoreDataHelper sharedInstance] insertToEntity:@"User" withObject:tempDic]){
        NSLog(@"Insert Success!");
        [self loadCoreData];
    }else{
        NSLog(@"Insert Abort!!");
    }
   
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    User * userObj = self.userArray[indexPath.row];
    cell.textLabel.text = userObj.name;
    cell.detailTextLabel.text = [userObj.createDate debugDescription];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        User * object = self.userArray[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
  

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
