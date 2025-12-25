//
//  UseCase.h
//  xzwblue
//
//  Created by 肖中旺 on 2021/9/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KmCase : NSObject


#pragma mark - TSPL
+ (NSData *)tspl_case1;
+ (NSData *)tspl_case2;
+ (NSData *)tspl_caseImage:(UIImage *)image;

#pragma mark - CPCL
+ (NSData *)cpcl_case1;
+ (NSData *)cpcl_case2:(UIImage *)image;


#pragma mark - ESC
+ (NSData *)esc_case1;
+ (NSData *)esc_case2;

@end

NS_ASSUME_NONNULL_END
