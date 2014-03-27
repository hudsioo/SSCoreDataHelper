//
//  DetailViewController.m
//  CoredataHelper
//
//  Created by hudsioo on 3/18/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "DetailViewController.h"
#import "User.h"
#import "CreditCrad.h"
#import "SSCoreDataHelper.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"name"] description];
        NSSet * cardSet = [self.detailItem valueForKey:@"user_cards"];
        self.cardArray = [NSMutableArray array];
        self.cardArray = [[cardSet allObjects] mutableCopy];
        [self.tableView reloadData];
    }
}

- (void) editUserAction:(id) sender{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editUserAction:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    [self configureView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cardArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    CreditCrad * cardObj = self.cardArray[indexPath.row];
    cell.textLabel.text = cardObj.type;
    cell.detailTextLabel.text = cardObj.card_id;
    
    if ([cardObj.type isEqualToString:@"VISA"]) {
        [cell.imageView setImage:[UIImage imageNamed:@"visa"]];
    }else if ([cardObj.type isEqualToString:@"MASTER"]){
        [cell.imageView setImage:[UIImage imageNamed:@"master"]];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Delete User
    if ([[SSCoreDataHelper sharedInstance] deleteEntity:@"CreditCrad" withObject:self.cardArray[indexPath.row]]){
        
        NSLog(@"Delete User Success!");
        // Reload Data
        self.cardArray = [[SSCoreDataHelper sharedInstance] getDataForEntity:@"CreditCrad" withSortKey:@"type" andSortAscending:YES];
        
        [self.tableView reloadData];
        
    }else{
        NSLog(@"Delete User Fails");
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
