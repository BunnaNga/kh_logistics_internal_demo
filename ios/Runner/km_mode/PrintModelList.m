//
//  PrintModelList.m
//  Km_Test
//
//  Created by 肖中旺 on 2021/9/16.
//

#import "PrintModelList.h"

@implementation PrintModelList

/// 快麦指令规范TSPL常用指令
+ (PrintModel *)addKM_TSPL_1
{
    PrintModel *model = [PrintModel new];
    model.name = @"快麦指令规范TSPL常用指令";
    return model;
}

/// 快麦指令规范TSPL图片
+ (PrintModel *)addKM_TSPL_2{
    PrintModel *model = [PrintModel new];
    model.name = @"快麦指令规范TSPL图片";
    return model;
}


/// 快麦指令规范CPCL常用指令
+ (PrintModel *)addKM_CPCL_1{
    PrintModel *model = [PrintModel new];
    model.name = @"快麦指令规范CPCL常用指令";
    return model;
}

/// 快麦指令规范CPCL图片
+ (PrintModel *)addKM_CPCL_2{
    PrintModel *model = [PrintModel new];
    model.name = @"快麦指令规范CPCL图片";
    return model;
}


/// 快麦指令规范ESC常用指令
+ (PrintModel *)addKM_ESC_1{
   
    PrintModel *model = [PrintModel new];
    model.name = @"快麦指令规范ESC常用指令";
    return model;
}


/// 快麦指令规范ESC图片
+ (PrintModel *)addKM_ESC_2{
    PrintModel *model = [PrintModel new];
    model.name = @"快麦指令规范ESC图片";
    return model;
}


@end
