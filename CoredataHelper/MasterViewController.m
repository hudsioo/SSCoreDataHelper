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

#import "AddNewUserViewController.h"

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
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //Load Data
    [self loadCoreData];
}

- (void)loadCoreData{
    self.userArray = [[SSCoreDataHelper sharedInstance] getDataForEntity:@"User" withSortKey:@"createDate" andSortAscending:YES];
    
    [self.tableView reloadData];
}


- (void)insertNewObject:(id)sender
{
    
    AddNewUserViewController * addVC = [[AddNewUserViewController alloc]initWithNibName:@"AddNewUserViewController" bundle:nil];
    UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:addVC];
    [self presentViewController:nv animated:YES completion:nil];
    
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



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    User * userObj = self.userArray[indexPath.row];
    NSSet * cardSet = [userObj valueForKey:@"user_cards"];
    NSMutableArray * cardArray = [NSMutableArray array];
    cardArray = [[cardSet allObjects] mutableCopy];
    
    //Delete all Cards
    if (cardSet != NULL) {
        for (NSManagedObject * c in cardArray){
            if ([[SSCoreDataHelper sharedInstance] deleteEntity:@"CreditCrad" withObject:c]) {
                 NSLog(@"Delete Card Success!");
            }else{
                 NSLog(@"Delete Card Fails");
            }
        }
    }
    
    //Delete User
    if ([[SSCoreDataHelper sharedInstance] deleteEntity:@"User" withObject:self.userArray[indexPath.row]]){
    
        NSLog(@"Delete User Success!");
        // Reload Data
        [self loadCoreData];
    }else{
        NSLog(@"Delete User Fails");
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
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
