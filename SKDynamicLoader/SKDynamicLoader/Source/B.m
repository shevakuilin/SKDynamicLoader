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

#pragma mark - 执行无返回值方法

+ (void)executeJSVoidMethodWithModel:(BridgeModel *)model {
    if (model) {
        if (!kStringIsEmpty(model.eventName) && !kStringIsEmpty(model.moduleName) && model.responseData) {
            if (model.responseData.data.allValues.count > 0) { // 方法带参数
                [A executeJSVoidMethod:model.eventName moduleName:model.moduleName arguments:@[model.responseData.data]];
            } else { // 方法不带参数
                [A executeJSVoidMethod:model.eventName moduleName:model.moduleName];
            }
        }
    }
}

#pragma mark - 执行有返回值方法

+ (id)executeJSReturnValueMethodWithModel:(BridgeModel *)model {
    if (model) {
        if (!kStringIsEmpty(model.eventName) && !kStringIsEmpty(model.moduleName) && model.responseData) {
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
