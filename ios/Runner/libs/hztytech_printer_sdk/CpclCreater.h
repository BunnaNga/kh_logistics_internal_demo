//
//  CpclCreater.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/18.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CpclCreater : NSObject

/**
 * 页面设置指令
 * offset,//整个标签的横向偏置点
 * xr,//横向分辨率
 * yr,//纵向分辨率
 * height,//标签最大高度
 * qty//要打印的标签数量
 */

- (NSData *)crtiPageInit:(NSInteger )offset xr:(NSInteger )xr yr:(NSInteger )yr height:(NSInteger )height copys:(NSInteger )copys;


/**
 * 打印指令
 *
 */
- (NSData *)crtiPrint;

- (NSData *)crtiPOPrint;


/**
 * 换页指令
 *
 */
- (NSData *)crtiForm;


/// 设置文字倍数
/// @param w 宽的倍数
/// @param h 高的倍数
- (NSData *)crtiSetMag:(int)w h:(int)h;

/**
 * 文本指令
 * cmd,//指令类型
 * font,//字体名称或者编号
 * size,//字体大小
 * x,//横向起始位置
 * y,//纵向起始位置
 * data//文本数据
 */
- (NSData *)crtiText:(NSString *)cmd font:(NSString *)font size:(NSString *)size x:(NSInteger )x y:(NSInteger )y data:(NSString *)data;


/**条码打印
 * cmd,//指令类型
 * type,//条码类型
 * width,//宽条的单位宽度
 * radio,//宽条与窄条的比例
 * height,//条码的单位高度
 * x,//横向起始位置
 * y,//纵向起始位置
 * data//条码数据
 */
- (NSData *)crtiBarcodecmd:(NSString *)cmd type:(NSString *)type width:(NSInteger )width radio:(NSString *)radio height:(NSInteger )height x:(NSInteger )x y:(NSInteger )y data:(NSString *)data;

/**二维码打印
 *cmd,//指令类型
 *type,//条码类型
 *x,//横向起始位置
 *y,//纵向起始位置
 *mn,//规范编码
 *un,//模块的单位宽度/单位高度
 *data//条码数据
 */
- (NSData *)crtiQrcodecmd:(NSString *)cmd type:(NSString *)type x:(NSInteger )x y:(NSInteger )y mn:(NSInteger )mn un:(NSInteger )un data:(NSString *)data;


/**边框
 *
 */
- (NSData *)crtiBox:(NSInteger )x y:(NSInteger )y x_end:(NSInteger )x_end y_end:(NSInteger )y_end width:(NSInteger )width;

- (NSData *)crtiDensity:(NSString *)n;


//打印速度
- (NSData *)crtiSpeed:(NSString *)n;


- (NSData *)crtiInverseline:(int)startx starty:(int)starty endx:(int)endx endy:(int)endy width:(int)width;


/// 设置单位
/// @param unit  IN-INCHES 度量单位英寸 ---IN-CENTIMETERS 度量单位厘米 ---IN-MILLIMETERS 度量单位毫米 ---IN-DOTS 度量单位为点
- (NSData *)critUnit:(NSString *)unit;



/// 设置打印模版宽度
/// @param width  模版宽度
- (NSData *)crtiPW:(int)width;

- (NSData *)crtiPH:(int)height;


/// 打印线条
/// @param startx 起点x坐标
/// @param starty 起点y坐标
/// @param endx 终点x坐标
/// @param endy 终点y坐标
/// @param width 线条宽度
- (NSData *)crtiLine:(int)startx starty:(int)starty endx:(int)endx endy:(int)endy width:(int)width;



/// 打印二维码类型
/// @param isVQ isVQ 是否纵向
/// @param codetype 默认QR
/// @param x x坐标
/// @param y  y坐标
/// @param m  选项是 1 或 2。QR Code Model 1 是原始ྟ规范，2增强版 默认1
/// @param n  模块单位宽度 1-32 默认6
/// @param data1 纠错等级 H/极高可高级别 Q/高可靠级别 M/标准级别 L/高密度级别 默认M
/// @param data2 字符模式 N数字 A字母数字 默认 A
/// @param data3  二维码内容 二维码内容
- (NSData *)crtiQrcode:(Boolean)isVQ codetype:(NSString *)codetype x:(int)x y:(int)y m:(int)m n:(int)n data1:(NSString *)data1 data2:(NSString *)data2 data3:(NSString *)data3;


- (NSData *)crtiBarcode:(Boolean)isvb codetype:(NSString *)codetype width:(int)width radio:(NSString *)radio height:(int)height x:(int)x y:(int)y data:(NSString *)data;


@end

NS_ASSUME_NONNULL_END
