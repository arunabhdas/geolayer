//
//  ItemCell.h
//  ContacList
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *mainLabel;
@property (nonatomic, strong) IBOutlet UILabel *secondaryLabel;
@property (nonatomic, strong) IBOutlet UIImageView *photoView;

@end
