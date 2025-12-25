//
//  TscImageCommand.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/22.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TscImageCommand : NSObject

+ (NSData *)addBitmap:(NSInteger)x y:(NSInteger)y
           bitmapMode:(NSInteger)mode bitmap:(UIImage *)b;


@end

NS_ASSUME_NONNULL_END
