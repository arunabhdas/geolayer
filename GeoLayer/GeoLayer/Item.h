//
//  Item.h
//  GeoLayer
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSNumber *createdAt;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSString *visibility;

@end
