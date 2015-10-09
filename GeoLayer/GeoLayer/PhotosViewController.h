//
//  PhotosViewController.h
//  GeoLayer
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
@interface PhotosViewController : UIViewController
@property (nonatomic, assign) Venue *selectedVenue;
@property (nonatomic, strong) NSArray<ItemModel *> *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UITextView *nameTextView;
@property (nonatomic, strong) UITextView *phoneTextView;
@property (nonatomic, strong) UITextView *twitterTextView;
@property (nonatomic, strong) UITextView *descriptionTextView;
@property (nonatomic, strong) UIButton *photosButton;
@end
