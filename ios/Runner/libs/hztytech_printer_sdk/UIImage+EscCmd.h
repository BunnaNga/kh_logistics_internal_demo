//
//  UIImage+EscCmd.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/21.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (EscCmd)

typedef NS_ENUM(NSInteger,BitPixels) {
    BPAlpha = 0,
    BPBlue = 1,
    BPGreen = 2,
    BPRed = 3
};

- (NSData *)imageToData;

- (NSData *)bitmapData;

@end

NS_ASSUME_NONNULL_END
