//
//  FastCase.h
//  xzwblue
//
//  Created by 肖中旺 on 2021/9/10.
//

#import <Foundation/Foundation.h>
#import "TscCreater.h"
#import "EscCreater.h"
#import "CpclCreater.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FastCase : NSObject


/**输出字节流*/
@property(nonatomic, strong) NSMutableData *printCmd;



/**tspl指令集对象*/
@property(nonatomic, strong) TscCreater *tsplCreater;

/**esc指令集对象*/
@property(nonatomic, strong) EscCreater *escCreater;

/**cpcl指令集对象*/
@property(nonatomic, strong) CpclCreater *cpclCreater;

#pragma mark - TSPL


/// 清空打印机画板缓存
- (FastCase *)addCls;

/// 打印速度
/// @param n 速度等级
- (FastCase *)addSpeed:(NSString *)n;

/// 打印浓度
/// @param n 浓度等级
- (FastCase *)addDensity:(NSString *)n;


/// 设置打印区域
/// @param width  打印宽度单位 mm
/// @param height 打印高度 mm
- (FastCase *)addSize:(int)width height:(int)height;

- (FastCase *)addDirection:(int)m n:(int)n;

- (FastCase *)addGap:(int)m n:(int)n;

- (FastCase *)addReference:(int)x y:(int)y;

- (FastCase *)addOffset:(NSString *)m;


/// 生成TEXT指令
/// @param x 起始x坐标
/// @param y 起始y坐标
/// @param font 字体名称
/// @param rotate 顺时针旋转角度 0 90 180 270
/// @param xMultiple x倍数 【1-10】
/// @param yMultiple y倍数 【1-10】
/// @param alignment 对齐
/// @param content 打印内容
- (FastCase *)addText:(int)x y:(int)y font:(NSString *)font rotate:(int)rotate xMultiple:(int)xMultiple yMultiple:(int)yMultiple alignment:(int)alignment content:(NSString *)content;

/// 加粗
/// @param n 0不加粗 1加粗
- (FastCase *)addBold:(int)n;

/// 生成BOX
/// @param x x坐标
/// @param y y坐标
/// @param xend x结束点
/// @param yend y结束点
/// @param thickness thickness线条宽度
/// @param radius radius弧度半径
- (FastCase *)addBox:(int)x y:(int)y xend:(int)xend yend:(int)yend thickness:(int)thickness radius:(int)radius;

/// 反白打印
/// @param x x起点
/// @param y y起点
/// @param width 宽度
/// @param height 高度
- (FastCase *)addReverse:(int)x y:(int)y width:(int)width height:(int)height;

/// 生成线条
/// @param x 起始x坐标
/// @param y 起始y坐标
/// @param width 宽度
/// @param height 高度
- (FastCase *)addBar:(int)x y:(int)y width:(int)width height:(int)height;


/// 生成BARCODE指令
/// @param x x坐标
/// @param y y坐标
/// @param codeType 条码类型
/// @param height  条码高度
/// @param style 文字样式  0:不可见   1:可见居左  2:可见居中  3:可见居右
/// @param rotation  顺时针旋转角度 0 90 180 270
/// @param narrow 窄条宽度
/// @param wide 宽条宽度
/// @param alignment 对齐方式
/// @param content 条码内容
- (FastCase *)addBarcode:(int)x y:(int)y codeType:(NSString *)codeType height:(int)height style:(int)style rotation:(int)rotation narrow:(int)narrow wide:(int)wide alignment:(int)alignment content:(NSString *)content;



/// 生成QRCODE指令
/// @param x x坐标
/// @param y y坐标
/// @param eccLevel 纠错等级 {7,15,25,30}
/// @param cellWidth 条码大小级别
/// @param mode Auto / manual encode
/// @param rotate 旋转角度
/// @param model 条码版本 M1:(默认)，原始版本  M2:增强版
/// @param mask 掩膜版的种类，控制二维码的样式 S[0-8] 默认为7
/// @param content 二维码内容
- (FastCase *)addQRCode:(int)x y:(int)y eccLevel:(NSString *)eccLevel cellWidth:(int)cellWidth mode:(NSString *)mode rotate:(int)rotate model:(NSString *)model mask:(NSString *)mask content:(NSString *)content;


/// 圆
/// @param x 起点x
/// @param y 起点y
/// @param diameter 直径
/// @param thickness 线条宽度
- (FastCase *)addCircle:(int)x y:(int)y diameter:(int)diameter thickness:(int)thickness;



/// 椭圆
/// @param x x起点
/// @param y y起点
/// @param width 宽
/// @param height 高
/// @param thickness 线条宽度
- (FastCase *)addEllipse:(int)x y:(int)y width:(int)width height:(int)height thickness:(int)thickness;


/// 添加水印
/// @param density 水印浓度[0-100]
- (FastCase *)addWaterMark:(NSString *)density;
/// 打印模版
/// @param m  指定要打印多少套标签。
/// @param n  指定每个特定标签集应该打印多少份副本
- (FastCase *)addPrint:(int)m n:(int)n;


/// 打印图片
/// @param x 图片x坐标
/// @param y 图片y坐标
/// @param mode 图片打印类型 0-2 默认0   3:zlib压缩  4:zlib反白  16:lz0压缩
/// @param image 图片
- (FastCase *)addBitmap:(int)x y:(int)y mode:(int)mode image:(UIImage *)image;


#pragma mark - 打印机设置

/// 设置模版宽度
/// @param width 单位mm
- (FastCase *)crtiSizeWidth:(int)width;



/// 设置纸张模式
/// @param type 33连续纸 34标签纸
- (FastCase *)crtiPapertype:(int)type;



/// 设置指令模式
/// @param type  0：TSPL  1：ESC
- (FastCase *)crtiCmdtype:(int)type;

#pragma mark - CPCL
/// 新建打印模版
/// @param height 打印模版高度
/// @param copys 打印份数
- (FastCase *)cpcl_addInit:(int)height copys:(int)copys;


/// 设置单位
/// @param unit  IN-INCHES 度量单位英寸
/// IN-CENTIMETERS 度量单位厘米
/// IN-MILLIMETERS 度量单位毫米
/// IN-DOTS 度量单位为点
- (FastCase *)cpcl_addUnit:(NSString *)unit;



/// 设置打印模版宽度
/// @param width 模版宽度
- (FastCase *)cpcl_addWidth:(int)width;

- (FastCase *)cpcl_addHeight:(int)height;


/// 设置文字倍数
/// @param w 宽 [1-3]
/// @param h 高 [1-3]
- (FastCase *)cpcl_SetMag:(int)w h:(int)h;

/// 文本指令
/// @param cmd  cmd 指令类型 (逆时针旋转角度) 默认不旋转  TEXT（或T） TEXT90（或 T90） TEXT180（或 T180） TEXT270（或 T270）
/// @param font font 0-6(根据打印机文档设置)
/// @param size size 0-6(根据打印机文档设置)
/// @param x x坐标
/// @param y y坐标
/// @param data 打印数据
- (FastCase *)cpcl_addText:(NSString *)cmd font:(NSString *)font size:(NSString *)size x:(int)x y:(int)y data:(NSString *)data;



/// 打印线条
/// @param startx 起点x坐标
/// @param starty 起点y坐标
/// @param endx 终点x坐标
/// @param endy 终点y坐标
/// @param width 线条宽度
- (FastCase *)cpcl_addLine:(int)startx starty:(int)starty endx:(int)endx endy:(int)endy width:(int)width;


/// 反白打印
/// @param startx 起点x坐标
/// @param starty 起点y坐标
/// @param endx 终点x坐标
/// @param endy 终点y坐标
/// @param width 线条宽度
- (FastCase *)cpcl_addInverseLine:(int)startx starty:(int)starty endx:(int)endx endy:(int)endy width:(int)width;

/// 打印条码
/// @param isvb 0,1 默认0
/// BARCODE（B）：横向打印条形码。
/// VBARCODE(VB) ：纵向打印条形码
/// @param codetype 条码类型 默认 128
/// UPC-A： UPCA、UPCA2、UPCA5
///  UPC-E： UPCE、UPCE2、UPCE5
/// EAN/JAN-13： EAN13、EAN132、EAN135
/// EAN/JAN-8： EAN8、EAN82、EAN 85
/// Code 39： 39、39C、F39、F39C
/// Code 93/Ext.93： 93
/// Interleaved 2 of 5： I2OF5
/// Interleaved 2 of 5（带checksum）：I2OF5C
/// German Post Code： I2OF5G
/// UCC EAN 128： UCCEAN128
/// Codabar： CODABAR、CODABAR16
/// MSI/Plessy： MSI、MSI10、MSI1010、MSI1110
/// Postnet： POSTNET
/// FIM： FIM
/// @param width 窄条单位宽度 默认1
/// @param radio  宽条与窄条单位比例 默认1
/// @param height 条码单位高度
/// @param x x坐标
/// @param y y坐标
/// @param data 条码数据
- (FastCase *)cpcl_addBarcode:(Boolean)isvb codetype:(NSString *)codetype width:(int)width radio:(NSString *)radio height:(int)height x:(int)x y:(int)y data:(NSString *)data;



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
- (FastCase *)cpcl_addQrcode:(Boolean)isVQ codetype:(NSString *)codetype x:(int)x y:(int)y m:(int)m n:(int)n data1:(NSString *)data1 data2:(NSString *)data2 data3:(NSString *)data3;


/// 走纸一张
- (FastCase *)cpcl_form;


/// 打印
- (FastCase *)cpcl_print;

- (FastCase *)cpcl_poprint;


/// 打印图片
/// @param x x坐标
/// @param y y坐标
/// @param mode 
/// @param image 图片内容
//- (FastCase *)cpcl_addBitmap:(int)x y:(int)y image:(UIImage *)image;
- (FastCase *)cpcl_addBitmap:(int)x y:(int)y mode:(int)mode image:(UIImage *)image;




#pragma mark - ESC

/// 自检页
- (FastCase *)addSelfTest;


/// 绝对位置
/// @param text1 文本1
/// @param text2 文本2
- (FastCase *)esc_addLocation:(NSString *)text1 text2:(NSString *)text2;

/// 打印机初始化
- (FastCase *)esc_addInit;


/// 添加文字
/// @param text 要添加的文字
- (FastCase *)esc_addText:(NSString *)text;


/// 对齐方式
/// @param align 0左对齐 1居中 2右对齐
- (FastCase *)esc_addAlign:(int)align;



/// 设置字符倍宽倍高
/// @param width 0-7 分别是1-8倍 默认0正常
/// @param height 0-7 分别是1-8倍 默认0正常
- (FastCase *)esc_setCharSize:(int)width height:(int)height;

/// 打印条码
/// @param width 条码宽度 2 ≤ n ≤ 6
/// @param height 条码高度 1 ≤ height ≤ 255
/// @param font 条码字体 0,48:标准 ASCII 码字符 (12 × 24) 1,49:压缩 ASCII 码字符 (9 × 17)
/// @param loc 条码位置显示0, 48:不打印 1, 49：条码上方 2, 50：条码下方 3, 51：条码上、下方都打印
/// @param m 条码类型 0 ≤ m ≤ 6 65 ≤ m ≤ 73 具体用法参考文档
/// @param data 条码数据
- (FastCase *)esc_barCode:(int)width height:(int)height font:(int)font loc:(int)loc m:(int)m data:(NSString *) data;



/// 打印二维码
/// @param size 二维码大小
/// @param data 二维码数据
- (FastCase *)esc_qrCode:(int)size data:(NSString *)data;



/// 打印并走纸
/// @param lines 1-255 走纸的行数
- (FastCase *)esc_feed:(int)lines;


/// 打印一行
- (FastCase *)esc_print;



/// 打印图片
/// @param mode 默认0
/// @param image 图片
- (FastCase *)esc_addBitmap:(int)mode image:(UIImage *)image;

- (FastCase *)esc_chinese;
/// 获取设备序列号
- (FastCase *)crtiGetSn;


/// 获取设备mac地址
- (FastCase *)crtiGetmacId;


/// 获取设备电量
- (FastCase *)crtiGetElectricity;

/// 获取设备充电状态
- (FastCase *)crtiGetChargingStatus;


/// 获取设备充电次数
- (FastCase *)crtiGetChargingCount;

/// 获取打印机型号
- (FastCase *)crtiGetDeviceType;


/// 获取打印机固件版本
- (FastCase *)crtiGetFirmwareVersion;


/// 通过蓝牙获取打印机型号
- (FastCase *)crtiGetDevicetypeWithBluetooth;

/// 通过蓝牙获取打印机状态
- (FastCase *)crtiGetDeviceStatus;

/// 获取KM
- (FastCase *)crtiGetKM;


@end

NS_ASSUME_NONNULL_END
