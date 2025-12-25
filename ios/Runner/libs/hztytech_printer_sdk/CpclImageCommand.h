//
//  CpclImageCommand.h
//  xzwblue
//
//  Created by 肖中旺 on 2021/9/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CpclImageCommand : NSObject


+ (NSData *)addCpclBitmap:(NSInteger) x y:(NSInteger) y mode:(int )mode  bitmap:(UIImage *) b;
//+ (NSData *)addCpclBitmap:(NSInteger)x y:(NSInteger)y bitmap:(UIImage *) b;
@end

NS_ASSUME_NONNULL_END
