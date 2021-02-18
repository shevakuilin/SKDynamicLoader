//
//  ViewController.h
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/1/21.
//

#import <UIKit/UIKit.h>
@class BridgeModel;

typedef void (^MyBlock)(NSString *string);

@interface ViewController : UIViewController

+ (void)classMethodTest1;
- (void)instanceMethodTest1;
+ (void)classMethodTest2;
- (void)instanceMethodTest2;

- (void)logWithContent:(NSString *)content;

- (NSString *)getValue;

- (void)toDetailedWithVCName:(NSString *)vcName hiddenBottom:(BOOL)hiddenBottom width:(CGFloat)width data:(NSDictionary *)data;

- (CGFloat)calculateHeightWithModel:(BridgeModel *)model;

- (void)getCallBack:(MyBlock)block;

@end

