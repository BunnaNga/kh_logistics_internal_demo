//
//  PrintModelList.h
//  Km_Test
//
//  Created by 肖中旺 on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import "PrintModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrintModelList : NSObject


/// 快麦指令规范TSPL常用指令
+ (PrintModel *)addKM_TSPL_1;

/// 快麦指令规范TSPL图片
+ (PrintModel *)addKM_TSPL_2;


/// 快麦指令规范CPCL常用指令
+ (PrintModel *)addKM_CPCL_1;

/// 快麦指令规范CPCL图片
+ (PrintModel *)addKM_CPCL_2;


/// 快麦指令规范ESC常用指令
+ (PrintModel *)addKM_ESC_1;

/// 快麦指令规范ESC图片
+ (PrintModel *)addKM_ESC_2;

@end

NS_ASSUME_NONNULL_END
