//
//  AddNewUserViewController.h
//  CoredataHelper
//
//  Created by hudsioo on 3/21/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewUserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    UITextField * typeTF;
    UITextField * cardIDTF;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *idTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSMutableDictionary * dicToSave;
@property (strong, nonatomic) NSMutableArray * cardArray;

- (IBAction)addNewCreditCardAction:(id)sender;
@end
