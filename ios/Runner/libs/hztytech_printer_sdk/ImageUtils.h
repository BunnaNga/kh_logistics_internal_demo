//
//  ImageUtils.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/22.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ImageUtils : NSObject

+(uint8_t *)imageToGreyImage:(UIImage *)image dir:(int)dir;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;

+ (NSData *)pixToTscCmd:(uint8_t *)src width:(NSInteger) width;
+ (unsigned char *)format_K_threshold:(unsigned char *) orgpixels
                               width:(NSInteger) xsize height:(NSInteger) ysize;

+ (UIImage*)imagePadLeft:(NSInteger) left withSource: (UIImage*)source;

+ (NSData *)eachLinePixToCmd:(unsigned char *)src nWidth:(NSInteger) nWidth nHeight:(NSInteger) nHeight nMode:(NSInteger) nMode;

+(unsigned char *)tscformat_K_threshold:(unsigned char *) orgpixels
                                  width:(NSInteger) xsize height:(NSInteger) ysize;

@end

NS_ASSUME_NONNULL_END
