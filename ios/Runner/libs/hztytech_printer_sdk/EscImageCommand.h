//
//  EscImageCommand.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/22.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EscImageCommand : NSObject

+ (NSData *)addBitmap:(int)mode image:(UIImage *)image;

+ (NSData *)addBitmapCut:(int)mode image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
