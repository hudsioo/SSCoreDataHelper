//
//  CardsViewController.m
//  CoredataHelper
//
//  Created by hudsioo on 3/24/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "CardsViewController.h"
#import "SSCoreDataHelper.h"
#import "CreditCrad.h"
#import "User.h"
@interface CardsViewController ()

@end

@implementation CardsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cardsArray = [[NSMutableArray alloc]init];
    
    //Set ManageObjectContext
    [[SSCoreDataHelper sharedInstance] managedObjectContext];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //Load Data
    [self loadCoreData];
}

- (void)loadCoreData{
    self.cardsArray = [[SSCoreDataHelper sharedInstance] getDataForEntity:@"CreditCrad" withSortKey:@"type" andSortAscending:YES];
    
    [self.tableView reloadData];
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cardsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CreditCrad * cardObj = self.cardsArray[indexPath.row];
    cell.textLabel.text = cardObj.type;
    User * userObj = cardObj.user;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)",cardObj.card_id,userObj.name];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
