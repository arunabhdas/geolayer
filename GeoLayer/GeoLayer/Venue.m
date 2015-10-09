//
//  Venue.m
//  GeoLayer
//
//

#import "Venue.h"

@implementation Venue

+ (NSDictionary *)JSONKeyPathByPropertyKey {
    return @{
             @"id" : @"id",
             @"name" : @"name",
             @"verified" : @"verified",
             @"url" : @"url",
             @"hasMenu" : @"hasMenu",
             @"location" : @"location",
             @"contact" : @"contact"
             };
}

+(NSString *)managedObjectEntityName {
    return @"Venue";
}
//We return an empty dictionary because the property names are identical in the class and entity
+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

@end