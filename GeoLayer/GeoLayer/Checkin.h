//
//  Checkin.h
//  GeoLayer
//

#import <Foundation/Foundation.h>

@interface Checkin : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSNumber *createdAt;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSNumber *timeZoneOffset;

@end
