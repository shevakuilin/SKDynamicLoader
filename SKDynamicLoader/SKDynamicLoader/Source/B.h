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
 * @note  方法的参数固定为 responseData.data
 *
 */
+ (void)executeJSVoidMethodWithModel:(BridgeModel *)model;

/** 执行无返回值方法
 *
 * @param model 通信model
 * @param arguments  指定方法的参数
 * @warning 注意 arguments 需要按照方法参数顺序传递，否则可能引发数据异常甚至崩溃
 *
 */
+ (void)executeJSVoidMethodWithModel:(BridgeModel *)model specifiedArguments:(NSArray *)arguments;


/** 执行有返回值方法
 *
 * @param model 通信model
 * @note  方法的参数固定为 responseData.data
 * @return 方法返回值
 *
 */
+ (id)executeJSReturnValueMethodWithModel:(BridgeModel *)model;

/** 执行有返回值方法
 *
 * @param model 通信model
 * @param arguments  指定方法的参数
 * @warning 注意 arguments 需要按照方法参数顺序传递，否则可能引发数据异常甚至崩溃
 * @return 方法返回值
 *
 */
+ (id)executeJSReturnValueMethodWithModel:(BridgeModel *)model specifiedArguments:(NSArray *)arguments;

@end

