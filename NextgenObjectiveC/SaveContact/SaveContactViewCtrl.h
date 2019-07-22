//
//  SaveContactViewCtrl.h
//  NextgenObjectiveC
//
//  Created by SangaviKarthik on 21/07/19.
//  Copyright © 2019 Cruzze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveContactViewCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)btnBack:(id)sender;
- (IBAction)save:(id)sender;
@property (strong) NSManagedObject *contactdb;
@end

NS_ASSUME_NONNULL_END
