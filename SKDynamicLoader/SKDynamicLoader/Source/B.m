//
//  B.m
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/2/18.
//

#import "B.h"
#import "A.h"
#import "BridgeModel.h"

#define kStringIsEmpty(str) (str == nil || [str isKindOfClass:[NSNull class]] || [str length] < 1 ? YES : NO )

@implementation B

#pragma mark - Public

+ (void)executeJSVoidMethodWithModel:(BridgeModel *)model {
    [B executeJSVoidMethodWithModel:model arguments:nil];
}

+ (void)executeJSVoidMethodWithModel:(BridgeModel *)model specifiedArguments:(NSArray *)arguments {
    [B executeJSVoidMethodWithModel:model arguments:arguments];
}

+ (id)executeJSReturnValueMethodWithModel:(BridgeModel *)model {
    return [B executeJSReturnValueMethodWithModel:model specifiedArguments:nil];
}

+ (id)executeJSReturnValueMethodWithModel:(BridgeModel *)model specifiedArguments:(NSArray *)arguments {
    return [B executeJSReturnValueMethodWithModel:model specifiedArguments:arguments];
}

#pragma mark - Private

+ (void)executeJSVoidMethodWithModel:(BridgeModel *)model arguments:(NSArray *)arguments {
    if (!model) { return; }
    if (kStringIsEmpty(model.eventName) || kStringIsEmpty(model.moduleName)) { return; }
    
    if (arguments.count > 0) { // 指定参数
        [A executeJSVoidMethod:model.eventName moduleName:model.moduleName arguments:arguments];
    } else { // 固定参数
        if (model.responseData) {
            if (model.responseData.data.allValues.count > 0) { // 方法带参数
                [A executeJSVoidMethod:model.eventName moduleName:model.moduleName arguments:@[model.responseData.data]];
            } else { // 方法不带参数
                [A executeJSVoidMethod:model.eventName moduleName:model.moduleName];
            }
        }
    }
}

+ (id)executeJSReturnValueMethodWithModel:(BridgeModel *)model arguments:(NSArray *)arguments {
    if (!model) { return nil; }
    if (kStringIsEmpty(model.eventName) || kStringIsEmpty(model.moduleName)) { return nil; }
    
    if (arguments.count > 0) {  // 指定参数
        return [A executeJSReturnValueMethod:model.eventName moduleName:model.moduleName arguments:arguments];
    } else {
        if (model.responseData) {
            if (model.responseData.data.allValues.count > 0) { // 方法带参数
                return [A executeJSReturnValueMethod:model.eventName moduleName:model.moduleName arguments:@[model.responseData.data]];
            } else { // 方法不带参数
                return [A executeJSReturnValueMethod:model.eventName moduleName:model.moduleName];
            }
        }
    }
    return nil;
}

@end
