//
//  A.h
//  SKDynamicLoader
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

@end

NS_ASSUME_NONNULL_END
