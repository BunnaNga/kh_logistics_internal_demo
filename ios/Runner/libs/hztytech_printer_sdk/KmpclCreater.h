//
//  KmpclCreater.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/19.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KmpclCreater : NSObject


- (NSData *)crtiGetProfile;         //获取基本信息
- (NSData *)crtiGetPrintConf;      //获取打印配置信息
- (NSData *)crtiSetPrintConf:(NSData *)data;  //修改打印配置信息
- (NSData *)crtiGetNetworkConf;    //获取网络配置
- (NSData *)crtiGetBluetoothConf;  //获取蓝牙配置信息

@end

NS_ASSUME_NONNULL_END
