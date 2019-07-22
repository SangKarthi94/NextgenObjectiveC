//
//  ViewController.h
//  NextgenObjectiveC
//
//  Created by SangaviKarthik on 21/07/19.
//  Copyright © 2019 Cruzze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//TableView Declaration
@property (weak, nonatomic) IBOutlet UITableView *contactTblView;

//Declare Contacts Array
@property (strong) NSMutableArray *contactsArray;

@end

