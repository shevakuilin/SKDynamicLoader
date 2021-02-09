//
//  NSMutableArray+variadicMethodExample.m
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/2/9.
//

#import "NSMutableArray+variadicMethodExample.h"

@implementation NSMutableArray (variadicMethodExample)

- (void) appendObjects:(id) firstObject, ... {
    id eachObject;
    va_list argumentList;
    if (firstObject) // The first argument isn't part of the varargs list,
    {                                   // so we'll handle it separately.
        [self addObject: firstObject];
        va_start(argumentList, firstObject); // Start scanning for arguments after firstObject.
        while ((eachObject = va_arg(argumentList, id))) // As many times as we can get an argument of type "id"
            [self addObject: eachObject]; // that isn't nil, add it to self's contents.
        va_end(argumentList);
    }
}

@end
