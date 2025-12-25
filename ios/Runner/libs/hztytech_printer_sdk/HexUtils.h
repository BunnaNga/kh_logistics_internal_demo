//
//  HexUtils.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/19.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HexUtils : NSObject


/**
 *16进制转NSData
 */
+ (NSData *)hexStrToData:(NSString *)str;

/**字符串转16进制字符串
 *
 */
+ (NSString *)hexStringFromString:(NSString *)string;

+ (NSData *)strToData:(NSString *)str;
+ (NSString *)dataToStr:(NSData *)data;
+ (NSString *)dataToHexStr:(NSData *)data;



/// base64转图片
/// @param base64 base64字符串
+ (UIImage *)getImageWithBase64:(NSString *)base64;


/// 从文件中取出字符串
/// @param filePath 文件路径不带后缀
+ (NSString *)getStringWithFilePath:(NSString *)filePath;


/// 计算时差
/// @param date1 开始时间
/// @param date2 结束时间
+ (float)subTime:(NSDate *)date1 end:(NSDate *)date2;


///data转b64
+ (NSString *)dataTob64:(NSData *)data;


///b64转data
+ (NSData *)b64ToData:(NSString *)b64;

@end

NS_ASSUME_NONNULL_END
