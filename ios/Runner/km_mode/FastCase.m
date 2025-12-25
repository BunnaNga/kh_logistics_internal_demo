//
//  FastCase.m
//  xzwblue
//
//  Created by 肖中旺 on 2021/9/10.
//

#import "FastCase.h"

#import "TscImageCommand.h"
#import "EscImageCommand.h"

#import "CpclImageCommand.h"
#import "HexUtils.h"

//#import "HomeMoreView.h"

@implementation FastCase

- (id)init{
    self = [super init];
    if (self) {
        _printCmd = [NSMutableData new];
        _tsplCreater = [TscCreater new];
        _cpclCreater = [CpclCreater new];
        _escCreater = [EscCreater new];
    }
    return self;
}

#pragma mark - TSPL

/// 自检页
- (FastCase *)addSelfTest{
    NSData *addCmd = [_tsplCreater crtiSelftest:@""];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印速度
/// @param n 速度等级
- (FastCase *)addSpeed:(NSString *)n{
    NSData *addCmd = [_tsplCreater crtiSpeed:n];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印浓度
/// @param n 浓度等级
- (FastCase *)addDensity:(NSString *)n{
    NSData *addCmd = [_tsplCreater crtiDensity:n];
    [_printCmd appendData:addCmd];
    return self;
}

/// 清空打印机画板缓存
- (FastCase *)addCls{
    NSData *addCmd = [_tsplCreater crtiClear];
    [_printCmd appendData:addCmd];
    return self;
}

/// 设置打印区域
/// @param width  打印宽度单位 mm
/// @param height 打印高度 mm
- (FastCase *)addSize:(int)width height:(int)height{
    NSData *addCmd = [_tsplCreater crtiSize:width height:height];
    [_printCmd appendData:addCmd];
    return self;
}


- (FastCase *)addDirection:(int)m n:(int)n{
    NSData *addCmd = [_tsplCreater crtiDirection:m n:n];
    [_printCmd appendData:addCmd];
    return self;
}

- (FastCase *)addGap:(int)m n:(int)n{
    NSData *addCmd = [_tsplCreater crtiGap:m n:n];
    [_printCmd appendData:addCmd];
    return self;
}

- (FastCase *)addOffset:(NSString *)m{
    NSData *addCmd = [_tsplCreater crtiOffset:m];
    [_printCmd appendData:addCmd];
    return self;
}

- (FastCase *)addReference:(int)x y:(int)y{
    NSData *addCmd = [_tsplCreater crtiReference:x y:y];
    [_printCmd appendData:addCmd];
    return self;
}



/// 生成TEXT指令
/// @param x 起始x坐标
/// @param y 起始y坐标
/// @param font 字体名称
/// @param rotate 顺时针旋转角度 0 90 180 270
/// @param xMultiple x倍数 【1-10】
/// @param yMultiple y倍数 【1-10】
/// @param alignment 对齐
/// @param content 打印内容
- (FastCase *)addText:(int)x y:(int)y font:(NSString *)font rotate:(int)rotate xMultiple:(int)xMultiple yMultiple:(int)yMultiple alignment:(int)alignment content:(NSString *)content{
    NSData *addCmd = [_tsplCreater crtiTextx:x y:y font:font rotate:rotate xMultiple:xMultiple yMultiple:yMultiple alignment:alignment content:content];
    [_printCmd appendData:addCmd];
    return self;
}


/// 加粗
/// @param n 0不加粗 1加粗
- (FastCase *)addBold:(int)n
{
    NSData *addCmd = [_tsplCreater crtiBold:n];
    [_printCmd appendData:addCmd];
    return self;
}

/// 反白打印
/// @param x x起点
/// @param y y起点
/// @param width 宽度
/// @param height 高度
- (FastCase *)addReverse:(int)x y:(int)y width:(int)width height:(int)height
{
    NSData *addCmd = [_tsplCreater crtiReverse:x y:y width:width height:height];
    [_printCmd appendData:addCmd];
    return self;
}


/// 生成BOX
/// @param x x坐标
/// @param y y坐标
/// @param xend x结束点
/// @param yend y结束点
/// @param thickness thickness线条宽度
/// @param radius radius弧度半径
- (FastCase *)addBox:(int)x y:(int)y xend:(int)xend yend:(int)yend thickness:(int)thickness radius:(int)radius
{
    NSData *addCmd = [_tsplCreater crtiBox:x y:y x_end:xend y_end:yend thickness:thickness radius:radius];
    [_printCmd appendData:addCmd];
    return self;
}

/// 生成线条
/// @param x 起始x坐标
/// @param y 起始y坐标
/// @param width 宽度
/// @param height 高度
- (FastCase *)addBar:(int)x y:(int)y width:(int)width height:(int)height{
    NSData *addCmd = [_tsplCreater crtiBarx:x y:y width:width height:height];
    [_printCmd appendData:addCmd];
    return self;
}


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
- (FastCase *)addBarcode:(int)x y:(int)y codeType:(NSString *)codeType height:(int)height style:(int)style rotation:(int)rotation narrow:(int)narrow wide:(int)wide alignment:(int)alignment content:(NSString *)content{
    
    NSData *addCmd = [_tsplCreater crtiBarcode:x y:y codeType:codeType height:height style:style rotation:rotation narrow:narrow wide:wide alignment:alignment content:content];
    [_printCmd appendData:addCmd];
    return self;
}


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
- (FastCase *)addQRCode:(int)x y:(int)y eccLevel:(NSString *)eccLevel cellWidth:(int)cellWidth mode:(NSString *)mode rotate:(int)rotate model:(NSString *)model mask:(NSString *)mask content:(NSString *)content{
    
    NSData *addCmd = [_tsplCreater crtiQRCodex:x y:y eccLevel:eccLevel cellWidth:cellWidth mode:mode rotate:rotate model:model mask:mask content:content];
    [_printCmd appendData:addCmd];
    return self;
}



/// 圆
/// @param x 起点x
/// @param y 起点y
/// @param diameter 直径
/// @param thickness 线条宽度
- (FastCase *)addCircle:(int)x y:(int)y diameter:(int)diameter thickness:(int)thickness
{
    NSData *addCmd = [_tsplCreater crtiCircle:x y:y diameter:diameter thickness:thickness];
    [_printCmd appendData:addCmd];
    return self;
}



/// 椭圆
/// @param x x起点
/// @param y y起点
/// @param width 宽
/// @param height 高
/// @param thickness 线条宽度
- (FastCase *)addEllipse:(int)x y:(int)y width:(int)width height:(int)height thickness:(int)thickness
{
    NSData *addCmd = [_tsplCreater crtiEllipse:x y:y width:width height:height thickness:thickness];
    [_printCmd appendData:addCmd];
    return self;
}



/// 添加水印
/// @param density 水印浓度
- (FastCase *)addWaterMark:(NSString *)density
{
    NSData *addCmd = [_tsplCreater crtiWaterMark:density];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印模版
/// @param m  指定要打印多少套标签。
/// @param n  指定每个特定标签集应该打印多少份副本
- (FastCase *)addPrint:(int)m n:(int)n
{
    NSData *addCmd = [_tsplCreater crtiPrintm:m n:n];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印图片
/// @param x 图片x坐标
/// @param y 图片y坐标
/// @param mode 图片打印类型 0-2 默认0   3:zlib压缩  4:zlib反白  16:lz0压缩
/// @param image 图片
- (FastCase *)addBitmap:(int)x y:(int)y mode:(int)mode image:(UIImage *)image{
    NSData *addCmd = [TscImageCommand addBitmap:x y:y bitmapMode:mode bitmap:image];
    [_printCmd appendData:addCmd];
    return self;
}

//- (FastCase *)addBitmap:(int)x y:(int)y mode:(int)mode image:(UIImage *)image {
//    NSData *addCmd = [TscImageCommand addBitmap:x y:y bitmapMode:mode bitmap:image];
//    [_printCmd appendData:addCmd];
//    return self;
//}

//- (FastCase *)addBitmap:(int)x
//                      y:(int)y
//                   mode:(int)mode
//                  image:(UIImage *)image
//{
//    @autoreleasepool {
//
//        // 1️⃣ Resize image to printer width (example: 576px)
//        UIImage *resizedImage = [self resizeForPrinter:image targetWidth:576];
//
//        // 2️⃣ Convert to black & white (1-bit friendly)
//        UIImage *bwImage = [self convertToBlackWhite:resizedImage];
//
//        // 3️⃣ Generate TSPL bitmap command
//        NSData *addCmd = [TscImageCommand addBitmap:x
//                                                  y:y
//                                          bitmapMode:mode
//                                               bitmap:bwImage];
//
//        [_printCmd appendData:addCmd];
//    }
//
//    return self;
//}
//- (UIImage *)resizeForPrinter:(UIImage *)image targetWidth:(CGFloat)width {
//    CGFloat ratio = width / image.size.width;
//    CGFloat height = image.size.height * ratio;
//
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 1.0);
//    [image drawInRect:CGRectMake(0, 0, width, height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return newImage;
//}

//- (UIImage *)convertToBlackWhite:(UIImage *)image {
//    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
//
//    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
//    [filter setValue:ciImage forKey:kCIInputImageKey];
//    [filter setValue:@0 forKey:kCIInputSaturationKey]; // remove color
//    [filter setValue:@1.2 forKey:kCIInputContrastKey]; // sharper print
//
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef cgImage =
//        [context createCGImage:filter.outputImage
//                      fromRect:filter.outputImage.extent];
//
//    UIImage *bwImage = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//
//    return bwImage;
//}
#pragma mark - 打印机设置

/// 设置模版宽度
/// @param width 单位mm
- (FastCase *)crtiSizeWidth:(int)width
{
    NSData *addCmd = [_escCreater crtiSizeWidth:width];
    [_printCmd appendData:addCmd];
    return self;
}



/// 设置纸张模式
/// @param type 33连续纸 34标签纸
- (FastCase *)crtiPapertype:(int)type
{
    NSData *addCmd = [_escCreater crtiPapertype:type];
    [_printCmd appendData:addCmd];
    return self;
}



/// 设置指令模式
/// @param type  0：TSPL  1：ESC
- (FastCase *)crtiCmdtype:(int)type
{
    NSData *addCmd = [_escCreater crtiCmdtype:type];
    [_printCmd appendData:addCmd];
    return self;
}

/// 获取设备序列号
- (FastCase *)crtiGetSn
{
    NSData *addCmd = [_escCreater crtiGetSn];
    [_printCmd appendData:addCmd];
    return self;
}


/// 获取设备mac地址
- (FastCase *)crtiGetmacId
{
    NSData *addCmd = [_escCreater crtiGetmacId];
    [_printCmd appendData:addCmd];
    return self;
}


/// 获取设备电量
- (FastCase *)crtiGetElectricity
{
    NSData *addCmd = [_escCreater crtiGetElectricity];
    [_printCmd appendData:addCmd];
    return self;
}

/// 获取设备充电状态
- (FastCase *)crtiGetChargingStatus
{
    NSData *addCmd = [_escCreater crtiGetChargingStatus];
    [_printCmd appendData:addCmd];
    return self;
}


/// 获取设备充电次数
- (FastCase *)crtiGetChargingCount
{
    NSData *addCmd = [_escCreater crtiGetChargingCount];
    [_printCmd appendData:addCmd];
    return self;
}

/// 获取打印机型号
- (FastCase *)crtiGetDeviceType
{
    NSData *addCmd = [_escCreater crtiGetDeviceType];
    [_printCmd appendData:addCmd];
    return self;
}


/// 获取打印机固件版本
- (FastCase *)crtiGetFirmwareVersion
{
    NSData *addCmd = [_escCreater crtiGetFirmwareVersion];
    [_printCmd appendData:addCmd];
    return self;
}


/// 通过蓝牙获取打印机型号
- (FastCase *)crtiGetDevicetypeWithBluetooth
{
    NSData *addCmd = [_escCreater crtiGetDevicetypeWithBluetooth];
    [_printCmd appendData:addCmd];
    return self;
}

/// 获取打印机状态
- (FastCase *)crtiGetDeviceStatus
{
    NSData *addCmd = [_escCreater crtiGetDeviceStatus];
    [_printCmd appendData:addCmd];
    return self;
}

/// 获取KM
- (FastCase *)crtiGetKM
{
    NSData *addCmd = [_escCreater crtiGetKM];
    [_printCmd appendData:addCmd];
    return self;
}


#pragma mark - CPCL


/// 新建打印模版
/// @param height 打印模版高度
/// @param copys 打印份数
- (FastCase *)cpcl_addInit:(int)height copys:(int)copys{

    NSData *addCmd = [_cpclCreater crtiPageInit:0 xr:200 yr:200 height:height copys:copys];
    [_printCmd appendData:addCmd];
    return self;
}



/// 设置单位
/// @param unit  IN-INCHES 度量单位英寸
/// IN-CENTIMETERS 度量单位厘米
/// IN-MILLIMETERS 度量单位毫米
/// IN-DOTS 度量单位为点
- (FastCase *)cpcl_addUnit:(NSString *)unit{

    NSData *addCmd = [_cpclCreater critUnit:unit];
    [_printCmd appendData:addCmd];
    return self;
}



/// 设置打印模版宽度
/// @param width 模版宽度
- (FastCase *)cpcl_addWidth:(int)width{
    NSData *addCmd = [_cpclCreater crtiPW:width];
    [_printCmd appendData:addCmd];
    return self;
}


- (FastCase *)cpcl_addHeight:(int)height{
    NSData *addCmd = [_cpclCreater crtiPH:height];
    [_printCmd appendData:addCmd];
    return self;
}






/// 文本指令
/// @param cmd  cmd 指令类型 (逆时针旋转角度) 默认不旋转  TEXT（或T） TEXT90（或 T90） TEXT180（或 T180） TEXT270（或 T270）
/// @param font font 0-6(根据打印机文档设置)
/// @param size size 0-6(根据打印机文档设置)
/// @param x x坐标
/// @param y y坐标
/// @param data 打印数据
- (FastCase *)cpcl_addText:(NSString *)cmd font:(NSString *)font size:(NSString *)size x:(int)x y:(int)y data:(NSString *)data{
    NSData *addCmd = [_cpclCreater crtiText:cmd font:font size:size x:x y:y data:data];
    [_printCmd appendData:addCmd];
    return self;
}


- (FastCase *)cpcl_SetMag:(int)w h:(int)h
{
    NSData *addCmd = [_cpclCreater crtiSetMag:w h:h];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印线条
/// @param startx 起点x坐标
/// @param starty 起点y坐标
/// @param endx 终点x坐标
/// @param endy 终点y坐标
/// @param width 线条宽度
- (FastCase *)cpcl_addLine:(int)startx starty:(int)starty endx:(int)endx endy:(int)endy width:(int)width{
    NSData *addCmd = [_cpclCreater crtiLine:startx starty:starty endx:endx endy:endy width:width];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印线条
/// @param startx 起点x坐标
/// @param starty 起点y坐标
/// @param endx 终点x坐标
/// @param endy 终点y坐标
/// @param width 线条宽度
- (FastCase *)cpcl_addInverseLine:(int)startx starty:(int)starty endx:(int)endx endy:(int)endy width:(int)width{
    NSData *addCmd = [_cpclCreater crtiInverseline:startx starty:starty endx:endx endy:endy width:width];
    [_printCmd appendData:addCmd];
    return self;
}

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
- (FastCase *)cpcl_addBarcode:(Boolean)isvb codetype:(NSString *)codetype width:(int)width radio:(NSString *)radio height:(int)height x:(int)x y:(int)y data:(NSString *)data{
    
    NSData *addCmd = [_cpclCreater crtiBarcode:isvb codetype:codetype width:width radio:radio height:height x:x y:y data:data];
    [_printCmd appendData:addCmd];
    return self;
}



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
- (FastCase *)cpcl_addQrcode:(Boolean)isVQ codetype:(NSString *)codetype x:(int)x y:(int)y m:(int)m n:(int)n data1:(NSString *)data1 data2:(NSString *)data2 data3:(NSString *)data3{
    
    NSData *addCmd = [_cpclCreater crtiQrcode:isVQ codetype:codetype x:x y:y m:m n:n data1:data1 data2:data2 data3:data3];
    [_printCmd appendData:addCmd];
    return self;
}


/// 走纸一张
- (FastCase *)cpcl_form{
    NSData *addCmd = [_cpclCreater crtiForm];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印
- (FastCase *)cpcl_print{
    NSData *addCmd = [_cpclCreater crtiPrint];
    [_printCmd appendData:addCmd];
    return self;
}

- (FastCase *)cpcl_poprint{
    NSData *addCmd = [_cpclCreater crtiPOPrint];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印图片
/// @param x x坐标
/// @param y y坐标
/// @param image 图片内容
- (FastCase *)cpcl_addBitmap:(int)x y:(int)y mode:(int)mode image:(UIImage *)image{

    NSData *addCmd = [CpclImageCommand addCpclBitmap:x y:y mode:mode bitmap:image];
    [_printCmd appendData:addCmd];
    return self;
}


#pragma mark - ESC


/// 打印机初始化
- (FastCase *)esc_addInit{
    
    NSData *addCmd = [_escCreater crtiInit];
    [_printCmd appendData:addCmd];
    return self;
}


/// 添加文字
/// @param text 要添加的文字
- (FastCase *)esc_addText:(NSString *)text{


    NSData *addCmd = [HexUtils strToData:text];
    [_printCmd appendData:addCmd];
    return self;
}


- (FastCase *)esc_addLocation:(NSString *)text1 text2:(NSString *)text2{


    NSData *l1 = [_escCreater crtiLocation:10];
    [_printCmd appendData:l1];
    NSData *data1 = [HexUtils strToData:text1];
    [_printCmd appendData:data1];
    NSData *l2 = [_escCreater crtiLocation:257];
    [_printCmd appendData:l2];
    NSData *data2 = [HexUtils strToData:text2];
    [_printCmd appendData:data2];
    return self;
}


/// 对齐方式
/// @param align 0左对齐 1居中 2右对齐
- (FastCase *)esc_addAlign:(int)align{
    
    NSData *addCmd = [_escCreater crtiAlign:align];
    [_printCmd appendData:addCmd];
    return self;
}



/// 设置字符倍宽倍高
/// @param width 0-7 分别是1-8倍 默认0正常
/// @param height 0-7 分别是1-8倍 默认0正常
- (FastCase *)esc_setCharSize:(int)width height:(int)height{
    int size = width *16 +height;
    NSData *addCmd = [_escCreater crtiSetCharSize:size];
    [_printCmd appendData:addCmd];
    return self;
}

/// 打印条码
/// @param width 条码宽度 2 ≤ n ≤ 6
/// @param height 条码高度 1 ≤ height ≤ 255
/// @param font 条码字体 0,48:标准 ASCII 码字符 (12 × 24) 1,49:压缩 ASCII 码字符 (9 × 17)
/// @param loc 条码位置显示0, 48:不打印 1, 49：条码上方 2, 50：条码下方 3, 51：条码上、下方都打印
/// @param m 条码类型 0 ≤ m ≤ 6 65 ≤ m ≤ 73 具体用法参考文档
/// @param data 条码数据
- (FastCase *)esc_barCode:(int)width height:(int)height font:(int)font loc:(int)loc m:(int)m data:(NSString *) data{
    
    NSData *addCmd = [_escCreater crtiBarcode:width height:height font:font loc:loc m:m data:[HexUtils strToData:data]];
    [_printCmd appendData:addCmd];
    return self;

}



/// 打印二维码
/// @param size 二维码大小
/// @param data 二维码数据
- (FastCase *)esc_qrCode:(int)size data:(NSString *)data{
    
    NSData *addCmd = [_escCreater crtiQrcode:size data:data];
    [_printCmd appendData:addCmd];
    return self;
}



/// 打印并走纸
/// @param lines 1-255 走纸的行数
- (FastCase *)esc_feed:(int)lines{
    
    NSData *addCmd = [_escCreater crtiPrintAndfeed:lines];
    [_printCmd appendData:addCmd];
    return self;
}


- (FastCase *)esc_chinese{
    
    NSData *addCmd = [_escCreater crtiChinese];
    [_printCmd appendData:addCmd];
    return self;
}


/// 打印一行
- (FastCase *)esc_print{

    [_printCmd appendData:[HexUtils strToData:@"\r\n"]];
    return self;
}



/// 打印图片
/// @param mode 默认0
/// @param image 图片
- (FastCase *)esc_addBitmap:(int)mode image:(UIImage *)image{
    if (mode == 3) {
        image =[self OriginImage:image scale:0.5];
    }
    NSData *addCmd = mode ==9?  [EscImageCommand addBitmapCut:mode image:image]:[EscImageCommand addBitmap:mode image:image];
    
    [_printCmd appendData:addCmd];
    
    return self;
}

- (UIImage*)OriginImage:(UIImage *)image scale:(float)scale
{
    CGSize size = CGSizeMake((image.size.width*scale), (image.size.height*scale));
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
