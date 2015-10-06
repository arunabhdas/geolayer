//
//  ItemCell.m
//  ContactList
//

#import "ItemCell.h"

@implementation ItemCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // self.iconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10.0, 0.0, 40.0, 40.0)];
        
        // UIGraphicsBeginImageContextWithOptions(CGSizeMake(20.0, 20.0), NO, kNilOptions);
        // self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        // UIGraphicsEndImageContext();
        
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 10.0, self.frame.size.width, 50.0)];
        self.mainLabel.font = [UIFont fontWithName:@"Helvetica-Neue" size:24.0f];
        // self.mainLabel.textAlignment = UITextAlignmentLeft;
        self.mainLabel.textColor = [UIColor blackColor];
        // self.mainLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.mainLabel];
        
        self.secondaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 40.0, self.frame.size.width, 50.0)];
        self.secondaryLabel.font = [UIFont fontWithName:@"Helvetica-Neue" size:24.0f];
        // self.secondaryLabel.textAlignment = UITextAlignmentLeft;
        self.secondaryLabel.textColor = [UIColor darkGrayColor];
        // self.secondaryLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.secondaryLabel];
        
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 25.0, 50.0, 50.0)];
        // self.photoView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.photoView.image = [UIImage imageNamed:@"martini"];
        [self addSubview:self.photoView];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
