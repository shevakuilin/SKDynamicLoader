//
//  B.h
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/2/18.
//

#import <Foundation/Foundation.h>
@class BridgeModel;

@interface B : NSObject

/** 执行无返回值方法
 *
 * @param model 通信model
 *
 */
+ (void)executeJSVoidMethodWithModel:(BridgeModel *)model;

/** 执行有返回值方法
 *
 * @param model 通信model
 * @return 方法返回值
 *
 */
+ (id)executeJSReturnValueMethodWithModel:(BridgeModel *)model;

@end

