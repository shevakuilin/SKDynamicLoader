//
//  ViewController.h
//  SKDynamicLoader
//
//  Created by ShevaKuilin on 2021/1/21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

+ (void)classMethodTest1;
- (void)instanceMethodTest1;
+ (void)classMethodTest2;
- (void)instanceMethodTest2;

- (void)logWithContent:(NSString *)content;

@end

