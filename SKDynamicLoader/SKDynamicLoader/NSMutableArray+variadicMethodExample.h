//
//  NSMutableArray+variadicMethodExample.h
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (variadicMethodExample)

- (void) appendObjects:(id) firstObject, ...; // This method takes a nil-terminated list of objects.

@end

NS_ASSUME_NONNULL_END
