//
//  PhotosModel.h
//  GeoLayer
//

#import "JSONModel.h"
#import "ItemModel.h"
@class ItemModel;
@interface PhotosModel : JSONModel

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSArray<ItemModel *> *items;
@property (nonatomic, strong) NSNumber *dupesRemoved;


@end
