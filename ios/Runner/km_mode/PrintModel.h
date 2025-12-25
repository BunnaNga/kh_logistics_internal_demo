//
//  PrintModel.h
//  Km_Test
//
//  Created by 肖中旺 on 2021/9/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrintModel : NSObject


/**模版类型 0TSPL  1ESC  2CPCL*/
@property(nonatomic, assign) int cmdType;

/**模版名称*/
@property(nonatomic, strong) NSString *name;

/**模版数据*/
@property(nonatomic, strong) NSData *data;

/**模版格式 str:明文字符串 b64:base64 h16:16进制
 */
@property(nonatomic, strong) NSString *dataType;

/**数据地址*/
@property(nonatomic, strong) NSString *dataPath;




@end

NS_ASSUME_NONNULL_END
