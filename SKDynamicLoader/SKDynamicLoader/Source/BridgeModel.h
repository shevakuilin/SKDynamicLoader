//
//  BridgeModel.h
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/2/8.
//

#import <Foundation/Foundation.h>

@interface BridgeResponseData : NSObject

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSDictionary *data;

@end

@interface BridgeModel : NSObject

@property (nonatomic, copy) NSString *responseId;
@property (nonatomic, copy) NSString *moduleName;   // 模块名
@property (nonatomic, copy) NSString *eventName;    // 方法名
@property (nonatomic, strong) BridgeResponseData *responseData;

@end

