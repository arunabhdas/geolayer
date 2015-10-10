//
//  Item.h
//  GeoLayer
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Source.h"
#import "User.h"
#import "Checkin.h"
@class Source;
@class User;
@class Checkin;
@interface Item : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSNumber *createdAt;
@property (nonatomic, strong) Source *source;
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *suffix;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Checkin *checkin;
@property (nonatomic, strong) NSString *visibility;

@end
