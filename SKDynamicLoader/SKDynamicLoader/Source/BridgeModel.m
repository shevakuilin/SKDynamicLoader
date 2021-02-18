//
//  BridgeModel.m
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/2/8.
//

#import "BridgeModel.h"
#import "MJExtension.h"

@implementation BridgeModel

#pragma mark - 字段映射

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"responseData" : [BridgeResponseData class],
             };
}

@end
