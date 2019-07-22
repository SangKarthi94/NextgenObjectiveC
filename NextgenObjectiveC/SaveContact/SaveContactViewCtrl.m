//
//  SaveContactViewCtrl.m
//  NextgenObjectiveC
//
//  Created by SangaviKarthik on 21/07/19.
//  Copyright © 2019 Cruzze. All rights reserved.
//

#import "SaveContactViewCtrl.h"

@interface SaveContactViewCtrl ()

@end

@implementation SaveContactViewCtrl
@synthesize contactdb;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Setting Seleted Value
    if (self.contactdb) {
        
        [self.txtName setText:[self.contactdb valueForKey:@"name"]];
        [self.txtEmail setText:[self.contactdb valueForKey:@"email"]];
        [self.txtPhoneNumber setText:[self.contactdb valueForKey:@"phone"]];
        
    }
    
}

-(NSManagedObjectContext *)managedObjectContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self];
}

- (IBAction)save:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.contactdb) {

        [self.contactdb setValue:self.txtName.text forKey:@"name"];
        [self.contactdb setValue:self.txtEmail.text forKey:@"email"];
        [self.contactdb setValue:self.txtPhoneNumber.text forKey:@"phone"];
        
    }else{
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:context];
        [newDevice setValue:self.txtName.text forKey:@"name"];
        [newDevice setValue:self.txtEmail.text forKey:@"email"];
        [newDevice setValue:self.txtPhoneNumber.text forKey:@"phone"];
        
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}
@end
