//
//  ResultModel.h
//  GeoLayer
//

#import "JSONModel.h"
#import "MetaModel.h"
#import "ResponseModel.h"
@class MetaModel;
@class ResponseModel;
@interface ResultModel : JSONModel

@property (nonatomic, strong) MetaModel *meta;
@property (nonatomic, strong) ResponseModel *response;


@end
