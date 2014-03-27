//
//  AddNewUserViewController.m
//  CoredataHelper
//
//  Created by hudsioo on 3/21/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import "AddNewUserViewController.h"

#import "SSCoreDataHelper.h"

#import "User.h"
#import "CreditCrad.h"

@interface AddNewUserViewController ()

@end

@implementation AddNewUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)saveNewUserAction:(id)sender{
    
    [self.dicToSave setValue:self.nameTF.text forKey:@"name"];
    [self.dicToSave setValue:self.idTF.text forKey:@"user_id"];
    [self.dicToSave setValue:self.emailTF.text forKey:@"email"];
    [self.dicToSave setValue:[NSDate date] forKey:@"createDate"];
    
    NSSet * cardSet = [NSSet setWithArray:self.cardArray];
    [self.dicToSave setValue:cardSet forKeyPath:@"user_cards"];
    
    if ([[SSCoreDataHelper sharedInstance] insertToEntity:@"User" withObject:self.dicToSave]){
        NSLog(@"Insert Success!");
        [self cancelAction:nil];
        
    }else{
        NSLog(@"Insert Abort!!");
    }
}

- (void)cancelAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"New User";
    
    UIBarButtonItem * saveBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(saveNewUserAction:)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    UIBarButtonItem * cancelBtn = [[UIBarButtonItem alloc]initWithTitle:@"Cancle" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    [[SSCoreDataHelper sharedInstance] managedObjectContext];
    
    self.dicToSave = [[NSMutableDictionary alloc]init];
    self.cardArray = [[NSMutableArray alloc]init];
}

- (IBAction)addNewCreditCardAction:(id)sender {
    UIAlertView * addCardAlertView = [[UIAlertView alloc]initWithTitle:@"Add Credit Card" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    addCardAlertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    typeTF = [addCardAlertView textFieldAtIndex:0];
    typeTF.placeholder = @"VISA or MASTER";
    cardIDTF = [addCardAlertView textFieldAtIndex:1];
    cardIDTF.placeholder = @"ID Credit Card";
    
    [addCardAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"Type %@ , ID %@",typeTF.text,cardIDTF.text);
        CreditCrad * cardObj = [NSEntityDescription insertNewObjectForEntityForName:@"CreditCrad" inManagedObjectContext:[[SSCoreDataHelper sharedInstance] managedObjectContext]];
        [cardObj setValue:typeTF.text forKey:@"type"];
        [cardObj setValue:cardIDTF.text forKey:@"card_id"];
        [self.cardArray addObject:cardObj];
        [self.tableView reloadData];
    }
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
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
