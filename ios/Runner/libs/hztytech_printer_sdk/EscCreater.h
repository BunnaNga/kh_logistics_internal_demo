//
//  EscCreater.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/18.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EscCreater : NSObject

/**
 * 初始化打印机
 *
 */

- (NSData *)crtiInit;

/**
 * 打印并换行
 *
 */
- (NSData *)crtiLf;

/**
 * 打印并回车
 *
 */
- (NSData *)crtiCr;


/**
 * 选择字符大小
 * n为字节字符，控制字符大小
 */
- (NSData *)crtiSetCharSize:(NSInteger )n;

/**
 * 字体反白
 * n为字节字符，控制是否反白
 */
- (NSData *)crtiReversen:(NSInteger )n;

/// 打印并走纸
/// @param lines 1-255 走纸的行数
- (NSData *)crtiPrintAndfeed:(NSInteger)lines;

/// 打印绝对位置
/// @param x 0-65535
- (NSData *)crtiLocation:(NSInteger)x;

/// 对齐方式
/// @param n 0左对齐 1居中 2右对齐
- (NSData *)crtiAlign:(NSInteger )n;


/**
 * 选择打印模式
 * n 00：正常 01：压缩 08：选择加粗模式 10：选择倍高模式 20：选择倍宽模式 80：选择下划线模式
 *
 */
- (NSData *)crtiPrintModen:(NSInteger )n;


/**
 * 选择/取消下划线模式
 *  n 00/48：取消 01/49选择1点宽 02/50：选择2点宽
 */
- (NSData *)crtiUnlinen:(NSInteger )n;


/**
 * 选择/取消加粗模式
 * @param n 00：取消加粗模式 01：选择加粗模式
 */
- (NSData *)crtiBold:(NSInteger )n;

/**
 * 选择字体
 * @param n 00/48：正常字体(12 × 24) 01/49：压缩字体(9 × 17)
 */
- (NSData *)crtiFontn:(NSInteger )n;


/**
 * 选择/取消顺时针旋转90度
 */
- (NSData *)crtiRotaVn:(NSInteger )n;


/**
 * 选择/取消倒置打印模式
 *
 */

- (NSData *)crtiHorsen:(NSInteger )n;

/**
 * 设置 QRCode 模块大小为 n dot
 *
 *
 */
- (NSData *)crtiQr_sizen:(NSInteger )n;

/**
 * 存储 QRCode 数据(d1...dk)到符号存储区
 *  pl 0 ≤ pL ≤255
 *  pH 0 ≤ pH ≤ 27
 * data d1...dk  k = (pL + pH × 256) - 3
 *
 */
- (NSData *)crtiQr_writepl:(NSInteger )pl pH:(NSInteger )pH data:(NSData *)data;


/**
 * 打印QRCode条码
 *
 */
- (NSData *)crtiQr_print;


/**
 * 选择 HRI 使用字体
 * n 0,1:标准 ASCII 码字符 (12 × 24)
 *          1,49:压缩 ASCII 码字符 (9 × 17)
 *
 */
- (NSData *)crtiBarcode_hri_fontn:(NSInteger )n;


/**
 * 选择 HRI 字符的打印位置
 *n 0, 48:不打印
 *  1, 49：条码上方
 *          2, 50：条码下方
 *          3, 51：条码上、下方都打印
 */
- (NSData *)crtiBarcode_hri_locationn:(NSInteger )n;

/**
 * 选择条码高度。
 * n 1 ≤ n ≤ 255
 *
 */
- (NSData *)crtiBarcode_heightn:(NSInteger )n;


/**
 * 选择条码横向模块宽度
 * @param n 2 ≤ n ≤ 6
 *
 */
- (NSData *)crtiBarcode_widghtn:(NSInteger )n;

/**
 * 打印条码
 * m 0 ≤ m ≤ 6
 * data 请按文档入参
 *
 */
- (NSData *)crtiBarcode_print_m1m:(NSInteger )m data:(NSData *)data;


/**
 *
 *  m 65 ≤ m ≤ 73
 *  n
 *  data
 *
 */
- (NSData *)crtiBarcode_print_m2m:(NSInteger )m n:(NSInteger )n data:(NSData *)data;


/// 打印条码
/// @param width 条码宽度 2 ≤ n ≤ 6
/// @param height 条码高度 1 ≤ height ≤ 255
/// @param font 条码字体 0,48:标准 ASCII 码字符 (12 × 24) 1,49:压缩 ASCII 码字符 (9 × 17)
/// @param loc 条码位置显示0, 48:不打印 1, 49：条码上方 2, 50：条码下方 3, 51：条码上、下方都打印
/// @param m 条码类型 0 ≤ m ≤ 6 65 ≤ m ≤ 73 具体用法参考文档
/// @param data 条码数据
- (NSData *)crtiBarcode:(int)width height:(int)height font:(int)font loc:(int)loc m:(int)m data:(NSData *)data;



/// 设置模版宽度
/// @param width 单位mm
- (NSData *)crtiSizeWidth:(int)width;



/// 设置纸张模式
/// @param type 33连续纸 34标签纸
- (NSData *)crtiPapertype:(int)type;



/// 设置指令模式
/// @param type  0：TSPL  1：ESC
- (NSData *)crtiCmdtype:(int)type;


/// 获取设备序列号
- (NSData *)crtiGetSn;

//设置汉语
- (NSData *)crtiChinese;

/// 获取设备mac地址
- (NSData *)crtiGetmacId;


/// 获取设备电量
- (NSData *)crtiGetElectricity;

/// 获取设备充电状态
- (NSData *)crtiGetChargingStatus;


/// 获取设备充电次数
- (NSData *)crtiGetChargingCount;

/// 获取打印机型号
- (NSData *)crtiGetDeviceType;


/// 获取打印机固件版本
- (NSData *)crtiGetFirmwareVersion;


/// 通过蓝牙获取打印机型号
- (NSData *)crtiGetDevicetypeWithBluetooth;

/// 通过蓝牙获取打印机状态
- (NSData *)crtiGetDeviceStatus;
/// 获取km
- (NSData *)crtiGetKM;


/// 打印二维码
/// @param size 二维码大小
/// @param data 二维码数据
- (NSData *)crtiQrcode:(int)size data:(NSString *)data;



@end

NS_ASSUME_NONNULL_END
