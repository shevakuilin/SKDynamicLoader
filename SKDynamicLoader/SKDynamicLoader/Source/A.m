//
//  A.m
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/1/21.
//

#import "A.h"
#import <objc/runtime.h>
//#import "ViewController.h"

@implementation A

#pragma mark - Public

+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        IMP imp = nil;
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            imp = [class instanceMethodForSelector:sel];
        } else if ([class respondsToSelector:sel]) { // 类方法
            imp = [class methodForSelector:sel];
//            ((id(*)(id, SEL, UIView*, id))imp)(self, sel, [UIView new], @"DFD");
        }
        if (imp) {
            ((void(*)(void))imp)();
        }
    }
}

//+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(id)arg1, ...NS_REQUIRES_NIL_TERMINATION {
//    Class class = NSClassFromString(moduleName);
//    // 判断该类是否存在
//    if (class) {
//        SEL sel = NSSelectorFromString(methodName);
//        if ([class instancesRespondToSelector:sel]) { // 实例方法
////            IMP imp = [class instanceMethodForSelector:sel];
//            if (arg1) {
//                Method method = class_getInstanceMethod(class, sel);
//                unsigned int count = method_getNumberOfArguments(method);
//
//                id instanceObjc = [class new];
//                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[instanceObjc methodSignatureForSelector:sel]];
//                [inv setSelector:sel];
//                [inv setTarget:instanceObjc];
//                // 添加第一个参数
//                [inv setArgument:&(arg1) atIndex:2];
//
//                id eachObject;
//                // 参数列表指针
//                va_list args;
//                // 获取第一个可选参数的地址，使参数列表指针指向函数参数列表中的第一个可选参数
//                va_start(args, arg1);
//                int i = 3;
//                while ((eachObject = va_arg(args, id))) // As many times as we can get an argument of type "id"
//                    [inv setArgument:&(eachObject) atIndex:i];
//                    i++;
////                // 添加剩余参数
////                for (int i = 3; i < count; i++) {
////                    // 获取可变参数的当前参数，返回指定类型并将指针指向下一参数
////                    id otherArg = va_arg(args, id);
////                    [inv setArgument:&(otherArg) atIndex:i];
////                }
//                // 方法调用
//                [inv invoke];
//                // 清空参数列表，并置参数指针args无效。
//                va_end(args);
//
//                // 依次取得除第一个参数以外的参数
//                // 获取可变参数的当前参数，返回指定类型并将指针指向下一参数
////                while (va_arg(args, id)) {
////                    id otherArg = va_arg(args, id);
////                    NSLog(@"otherString %@", otherArg);
////                }
//            }
////            ((void(*)(id, SEL, id,...))imp)(self, sel, arg1);
////                        id instanceObjc = [class new];
////            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[instanceObjc methodSignatureForSelector:sel]];
////            [inv setSelector:sel];
////            [inv setTarget:instanceObjc];
//
////            [inv setArgument:&(indexPath) atIndex:2]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
////            [inv setArgument:&(dataSource) atIndex:3]; //arguments 0 and 1 are self and _cmd respectively, automatically set by NSInvocation
//
////            [inv invoke];
//
//        } else if ([class respondsToSelector:sel]) { // 类方法
//            IMP imp = [class methodForSelector:sel];
//            // 参数列表指针
//            va_list args;
//            // 获取第一个可选参数的地址，使参数列表指针指向函数参数列表中的第一个可选参数
//            va_start(args, arg1);
//            // 执行
//            ((void(*)(id, SEL, id,...))imp)(self, sel, va_arg(args, id));
//            // 清空参数列表，并置参数指针args无效。
//            va_end(args);
//        }
//    }
//}

+ (void)executeJSVoidMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(NSArray *)arguments {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        Method method = nil;
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            method = class_getInstanceMethod(class, sel);
            
        } else if ([class respondsToSelector:sel]) { // 类方法
            method = class_getClassMethod(class, sel);
        }
        
        if (method) {
            unsigned int count = method_getNumberOfArguments(method);
            // 参数存在，且参数数量与方法提供的入参数量相同
            if (arguments.count > 0 && (arguments.count + 2) == count) {
                id instanceObjc = [class new];
                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[instanceObjc methodSignatureForSelector:sel]];
                [inv setSelector:sel];
                [inv setTarget:instanceObjc];
                for (int i = 0; i < arguments.count; i++) {
                    id arg = arguments[i];
                    [A setArgumenWithInvocation:inv index:i + 2 value:arg];
                }
                // 方法调用
                [inv invoke];
            }
        }
    }
}

+ (id)executeJSReturnValueMethod:(NSString *)methodName moduleName:(NSString *)moduleName {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        IMP imp = nil;
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            imp = [class instanceMethodForSelector:sel];
        } else if ([class respondsToSelector:sel]) { // 类方法
            imp = [class methodForSelector:sel];
        }
        if (imp) {
            return ((id(*)(id, SEL))imp)(self, sel);
        }
    }
    return nil;
}

+ (id)executeJSReturnValueMethod:(NSString *)methodName moduleName:(NSString *)moduleName arguments:(NSArray *)arguments {
    Class class = NSClassFromString(moduleName);
    // 判断该类是否存在
    if (class) {
        SEL sel = NSSelectorFromString(methodName);
        Method method = nil;
        if ([class instancesRespondToSelector:sel]) { // 实例方法
            method = class_getInstanceMethod(class, sel);
            
        } else if ([class respondsToSelector:sel]) { // 类方法
            method = class_getClassMethod(class, sel);
        }
        
        if (method) {
            unsigned int count = method_getNumberOfArguments(method);
            // 参数存在，且参数数量与方法提供的入参数量相同
            if (arguments.count > 0 && (arguments.count + 2) == count) {
                id instanceObjc = [class new];
                NSMethodSignature *signature = [instanceObjc methodSignatureForSelector:sel];
                NSInvocation *inv = [NSInvocation invocationWithMethodSignature:signature];
                [inv setSelector:sel];
                [inv setTarget:instanceObjc];
                for (int i = 0; i < arguments.count; i++) {
                    id arg = arguments[i];
                    [A setArgumenWithInvocation:inv index:i + 2 value:arg];
                }
                // 方法调用
                [inv invoke];
                // 获取返回值
                id returnValue;
                if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
                    // 返回类型判断，比如返回值为常量需要包装成对象
                    returnValue = [A getReturnValueWithInvocation:inv returnValue:returnValue];
                }
                
                return returnValue;
            }
        }
    }
    return nil;
}

#pragma mark - Private

+ (void)setArgumenWithInvocation:(NSInvocation *)inv index:(int)index value:(id)value {
    // - Note: https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
    if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber *numberValue = (NSNumber *)value;
        const char *objCType = [((NSNumber*)value) objCType];
        if (strcmp(objCType, @encode(float)) == 0) {
            float f = [numberValue floatValue];
            [inv setArgument:&(f) atIndex:index];
        } else if (strcmp(objCType, @encode(double))  == 0) {
            double d = [numberValue doubleValue];
            [inv setArgument:&(d) atIndex:index];
        } else if (strcmp(objCType, @encode(int))  == 0) {
            int i = [numberValue intValue];
            [inv setArgument:&(i) atIndex:index];
        } else if (strcmp(objCType, @encode(BOOL)) == 0 || strcmp(objCType, @encode(Boolean)) == 0) {
            BOOL b = [numberValue boolValue];
            [inv setArgument:&(b) atIndex:index];
        } else if (strcmp(objCType, @encode(CFStringRef)) == 0 || strcmp(objCType, @encode(NSString)) == 0) {
            NSString *s = [numberValue stringValue];
            [inv setArgument:&(s) atIndex:index];
        } else {
            [inv setArgument:&(value) atIndex:index];
        }
    } else {
        [inv setArgument:&(value) atIndex:index];
    }
}

+ (id)getReturnValueWithInvocation:(NSInvocation *)inv returnValue:(id)returnValue {
    // 获取返回值
//    [inv getReturnValue:&returnValue];
    // 如果不是oc对象，将其包装成一个oc对象
//    if (strcmp(inv.methodSignature.methodReturnType, "@") != 0) {
//        __weak NSObject *objc = CFBridgingRelease(&returnValue);
//
//        return objc;
//    }
    if (strcmp(inv.methodSignature.methodReturnType, @encode(float)) == 0) {
        float f;
        [inv getReturnValue:&f];
        returnValue = [NSNumber numberWithFloat:f];
    } else if (strcmp(inv.methodSignature.methodReturnType, @encode(double))  == 0) {
        double d;
        [inv getReturnValue:&d];
        returnValue = [NSNumber numberWithDouble:d];
    } else if (strcmp(inv.methodSignature.methodReturnType, @encode(int))  == 0) {
        int i;
        [inv getReturnValue:&i];
        returnValue = [NSNumber numberWithInt:i];
    } else if (strcmp(inv.methodSignature.methodReturnType, @encode(BOOL)) == 0 || strcmp(inv.methodSignature.methodReturnType, @encode(Boolean)) == 0) {
        BOOL b;
        [inv getReturnValue:&b];
        returnValue = [NSNumber numberWithBool:b];
    } else {
        [inv getReturnValue:&returnValue];
    }
    
    return returnValue;
}

// 打印方法列表
//+ (void)printMethodList {
//    unsigned int count;
//    
//    Method *methodList = class_copyMethodList([ViewController class], &count);
//    for (unsigned int i = 0; i < count; i++) {
//        Method method = methodList[i];
//        NSLog(@"instanceMethod : %@", NSStringFromSelector(method_getName(method)));
//    }
//    Method *classMethodList = class_copyMethodList(object_getClass([ViewController class]), &count);
//    for (unsigned int i = 0; i < count; i++) {
//        Method classMethod = classMethodList[i];
//        NSLog(@"classMethod : %@", NSStringFromSelector(method_getName(classMethod)));
//    }
//    
//    free(methodList);
//}

@end
