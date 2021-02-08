//
//  BridgeModel.h
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BridgeModel : NSObject

@property (nonatomic, copy) NSString *callId;
@property (nonatomic, copy) NSString *moduleName;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, strong) NSDictionary *callData;

@end

NS_ASSUME_NONNULL_END
