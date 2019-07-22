//
//  ContactTableViewCell.h
//  NextgenObjectiveC
//
//  Created by SangaviKarthik on 21/07/19.
//  Copyright © 2019 Cruzze. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhome;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@end

NS_ASSUME_NONNULL_END
