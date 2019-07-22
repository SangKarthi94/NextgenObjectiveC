//
//  ViewController.m
//  NextgenObjectiveC
//
//  Created by SangaviKarthik on 21/07/19.
//  Copyright © 2019 Cruzze. All rights reserved.
//

#import "ViewController.h"
#import "SaveContactViewCtrl.h"
#import "ContactTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

//Method to create context
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Fetch Data from Persistent Data Store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Contact"];
    self.contactsArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
    
    //For Loop example
    for (int i=0; i<self.contactsArray.count; i++) {
        NSManagedObject *data = [self.contactsArray objectAtIndex:i];
        NSLog(@"%@", [data valueForKey:@"name"]);
    }
    
    [self.contactTblView reloadData];
 
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"]){
        NSLog (@"Successfully received the test notification!");
    }
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ContactCell";
    
    NSManagedObject *data = [self.contactsArray objectAtIndex:indexPath.row];
    
    ContactTableViewCell *cell = (ContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell.lblName setText:[data valueForKey:@"name"]];
    [cell.lblPhome setText:[data valueForKey:@"phone"]];
    [cell.lblEmail setText:[data valueForKey:@"email"]];

    return cell;
}
- (IBAction)addBtn:(id)sender {
    [self performSegueWithIdentifier:@"UpdateContacts" sender:sender];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactsArray.count;
//    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    printf("%ld", (long)indexPath.row);
    [self performSegueWithIdentifier:@"UpdateContacts" sender:self.view];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.contactsArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.contactsArray removeObjectAtIndex:indexPath.row];
        [self.contactTblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"UpdateContacts"]) {
        NSManagedObject *selectedDevice = [self.contactsArray objectAtIndex:[[self.contactTblView indexPathForSelectedRow] row]];
        SaveContactViewCtrl *destViewController = segue.destinationViewController;
        destViewController.contactdb = selectedDevice;
    }
}
@end
