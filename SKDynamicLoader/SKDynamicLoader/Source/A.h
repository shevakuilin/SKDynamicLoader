//
//  A.h
//  SKDynamicLoader
//
//  动态执行最底层，不与数据对接，只负责执行
//
//  Created by ShevaKuilin on 2021/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface A : NSObject

/** 执行JS「无返回值 & 无参数」方法
 *
 * @param methodName    方法名
 * @param moduleName    模块名
 *
 */
+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName;

/** 执行JS「无返回值 & 带参数」方法
 *
 * @param methodName    方法名
 * @param moduleName    模块名
 * @param arg1                 参数值，不限制数量
 * @warning 注意 arg1, ... 传入的参数类型必须相同，否则会导致参数列表访问错误内存，从而抛出EXC_BAD_ACCESS
 *
 */
//+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(id)arg1, ...NS_REQUIRES_NIL_TERMINATION;

/** 执行JS「无返回值 & 带参数」方法
 *
 * @param methodName    方法名
 * @param moduleName    模块名
 * @param arguments      参数值，不限制数量
 * @warning 注意 arguments 需要按照方法参数顺序传递，否则可能引发崩溃
 *
 */
+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(NSArray *)arguments;

/** 执行JS「有返回值 & 无参数」方法
 *
 * @param methodName    方法名
 * @param moduleName    模块名
 *
 */
+ (id)executeJSReturnValueMethod:(NSString *)methodName moduleName:(NSString *)moduleName;

@end

NS_ASSUME_NONNULL_END
