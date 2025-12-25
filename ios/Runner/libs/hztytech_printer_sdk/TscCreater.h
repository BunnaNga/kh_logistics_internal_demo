//
//  TscCreater.h
//  KmPrint
//
//  Created by 肖中旺 on 2020/12/17.
//  Copyright © 2020 肖中旺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TscCreater : NSObject

/**生成sound指令
 *level响声级别
 *interval时间间隔
 */
- (NSData *)crtiSoundlevel:(NSInteger )level interval:(NSInteger )interval;


/**生成PRINT
 *
 */
- (NSData *)crtiPrintm:(NSInteger )m n:(NSInteger )n;
                                
- (NSData *)crtiClear;
- (NSData *)crtiCut;
- (NSData *)crtiSelftest:(NSString *)page;

/**生成SIZE指令
 *width页面宽度,单位自己输入
 *height页面高度
 */
- (NSData *)crtiSize:(NSInteger)width height:(NSInteger)height;

/**生成TEXT指令
 *起始x坐标
 *起始y 坐标
 *font字体名称
 *旋转
 *x倍数
 *y倍数
 *alignment对齐
 *content文本内容
 */
- (NSData *)crtiTextx:(NSInteger)x y:(NSInteger)y font:(NSString *)font rotate:(NSInteger)ratate xMultiple:(NSInteger)xMultiple yMultiple:(NSInteger)yMultiple alignment:(NSInteger)alignment content:(NSString *)content;

/**n 可以为n或者nkmp两种格式 n为等级，nkmp中的n为最大速度的百分比
 *
 */
- (NSData *)crtiSpeed:(NSString *)n;

/**n 可以为n或者nkmp两种格式 n为等级，nkmp中的n为最大浓度的百分比
 *
 */

- (NSData *)crtiDensity:(NSString *)n;

/**生成DIRECTION指令
 *m进纸方向
 *n是否采用镜像打印
 */
- (NSData *)crtiDirection:(NSInteger )m n:(NSInteger )n;

/**生成BAR指令
 *起始x坐标
 *起始y坐标
 *width宽度单位像素
 *height高度单位像素
 */
- (NSData *)crtiBarx:(NSInteger )x y:(NSInteger )y width:(NSInteger )width height:(NSInteger )height;

/**生成BOX
 *x坐标
 *y坐标
 *x结束点
 *y结束点
 *thickness线条宽度
 *radius弧度半径
 */
- (NSData *)crtiBox:(NSInteger )x y:(NSInteger )y x_end:(NSInteger )x_end y_end:(NSInteger )y_end thickness:(NSInteger )thickness radius:(int)radius;

/**生成CIRCLE指令
 *x起始x坐标
 *起始y 坐标
 *diameter直径 单位是点
 *thickness线条宽度
 */
- (NSData *)crtiCircle:(NSInteger )x y:(NSInteger )y diameter:(NSInteger )diameter thickness:(NSInteger )thickness;

/**生成ELLIPSE指令
 *起始x坐标
 *起始y 坐标
 *width宽度，单位是点
 *height,高度，单位是点
 *thickness线条宽度
 */
- (NSData *)crtiEllipse:(NSInteger )x y:(NSInteger )y width:(NSInteger )width height:(NSInteger )height thickness:(NSInteger )thickness;


/**生成GAP指令
 *m标签之间的间距
 *n标签内容与标签底部之间的距离
 */
- (NSData *)crtiGap:(NSInteger )m n:(NSInteger )n;

/**
 *生成BLINE命令
 *m黑标纸张高度
 *n进纸长度
 */
- (NSData *)crtiBlinem:(NSInteger )m n:(NSInteger )n;


/**生成OFFSET指令
 *偏移距离，单位mm
 */

- (NSData *)crtiOffset:(NSString *)m;

/*生成SHIFT 指令
 *n垂直进纸高度，单位是dot
 */
- (NSData *)crtiShiftn:(NSInteger )n;

/**打印机进纸一段距离
 */
- (NSData *)crtiFeedn:(NSInteger )n;

/**进纸一张
 
 */
- (NSData *)crtiFormFeed;

/**回纸一段距离tspl2
 
 */
- (NSData *)crtiBackFeedn:(NSInteger )n;

/**回纸一段距离tspl1
 
*/
- (NSData *)crtiBackupn:(NSInteger )n;

//打印自检页
- (NSData *)crtiSelftest:(NSString *)page;

- (NSData *)crtiDelay:(NSInteger )ms;

//生成ERASE指令
/**
 *生成ERASE指令
 *int x,  //起始x坐标
 int y, //起始y 坐标
 int x_width,        //宽度，单位是点
 int,y_height,        //高度，单位是点
 */
- (NSData *)crtiErase:(NSInteger )x y:(NSInteger )y x_width:(NSInteger )x_width y_height:(NSInteger )y_height;

/**生成REFERENCE指令
 *x水平偏移
 *y 水平偏移
 */
- (NSData *)crtiReference:(NSInteger )x y:(NSInteger )y;

/**生成BARCODE指令
 *x 坐标
 *y坐标
 *code type
 *barcode height
 *style,//内容样式,对应humenreadable
 *rotation,//旋转角度
 *narrow,//窄条宽度,单位像素
 * wide,//宽条宽度,单位像素
 * alignment,//对齐方式
 * content//条码内容
 */
- (NSData *)crtiBarcode:(NSInteger )x y:(NSInteger )y codeType:(NSString *)codeType height:(NSInteger )height style:(NSInteger )style rotation:(NSInteger )rotation narrow:(NSInteger )narrow wide:(NSInteger )wide alignment:(NSInteger)alignment content:(NSString *)content;


/**生成QRCODE指令
 *x, //起始x坐标
 *y, //起始y 坐标
 *eccLevel, //{7,15,25,30}
 *cellWidth, //[1,10]
 *mode, //{0:Auto, 1:manual}
 *rotate, //旋转角度
 *model, //[1-default M1 ,2-M2]
 *String mask, //S[0-8] 默认为7
 *String content //内容
 */
- (NSData *)crtiQRCodex:(NSInteger )x y:(NSInteger )y eccLevel:(NSString *)eccLevel cellWidth:(NSInteger )cellWidth mode:(NSString *)mode rotate:(NSInteger )rotate model:(NSString *)model mask:(NSString *)mask content:(NSString *)content;
                                

/**生成REVERSE指令
 *x, //起始x坐标
 *y, //起始y 坐标
 *width, //宽度，单位是点
 *height //高度，单位是点
 */
- (NSData *)crtiReverse:(NSInteger )x y:(NSInteger )y width:(NSInteger )width height:(NSInteger )height;


/**生成BLOCK指令
 *x, //起始x坐标
 *y, //起始y 坐标
 *width, //宽度，单位是点
 *height, //高度，单位是点
 *font, //字体名称
 *rotate, //旋转角度
 *xMultiple, //x倍数
 *yMultiple, //y倍数
 *lineSpace, //行间距
 *alignment, //对齐
 *content //内容
 */
- (NSData *)crtiBlockx:(NSInteger )x y:(NSInteger )y width:(NSInteger )width height:(NSInteger )height font:(NSString *)font rotate:(NSInteger )rotate xMultiple:(NSInteger )xMultiple yMultiple:(NSInteger )yMultiple lineSpace:(NSInteger )lineSpace alignment:(NSString *)alignment content:(NSString *)content;
                                  
/**生成BOLD指令
 *0为取消加粗
 */
- (NSData *)crtiBold:(NSInteger )level;

/**水印WATERMARK N
 *水印浓度[0,100],其中0代表取消水印
 */
- (NSData *)crtiWaterMark:(NSString *)density;

//获取设备状态，使用<ECS>!? 实现
- (NSData *)critGetDevStat;

//重启，使用<ESC>!C 实现
- (NSData *)critRestart;

//恢复出厂设置,使用<ESC>!R实现
- (NSData *)critReset;


//生成支持压缩的BITMAP指令
/**
 int x,                    //x坐标
 int y,                    //y 坐标
 int width,                //图像宽度,单位是字节
 int  wlimit,                //图像最大宽度限制，因打印机而异
                               默认为0。代表不限制。
 int height,                //图像你高度，单位是点
 string mode,                //图像渲染模式，共2个字符组成
                               首字符代表渲染模式，尾字符代表压缩算法。例如：00-代表overwrite模式无压缩。 11 代表or模式行式压缩。
 byte[] bitmap,             //二值图像的数据部分
 */
- (NSData *)crtiBitmap:(NSInteger )x y:(NSInteger )y width:(NSInteger )width wlimit:(NSInteger )wlimit height:(NSInteger )height mode:(NSString *)mode bitmap:(NSData *)bitmap;

/**
 int pageWidth,           //页面宽度,单位毫米
       int pageHeight,          //页面高度,单位毫米
      int xOffset,             //打印区域水平偏移
      int yOffset,           //打印区域垂直偏移
 boolean reversePrint,  //是否反向打印,默认为false
 boolean mirrorPrint,   //是否镜像打印,默认为flase
 int   speed,           //打印浓度,默认为-1 表示使用设备默认
 int   density          //打印速度,默认为 -1 标识使用设备默认
 boolean clearBuffer,   //是否清空缓冲区,默认为true
 */
- (NSData *)crtiInitPage:(NSInteger )pageWidth pageHeight:(NSInteger )pageHeight xOffset:(NSInteger )xOffset yOffset:(NSInteger )yOffset reversePrint:(BOOL )reversePrint mirrorPrint:(BOOL )mirrorPrint speed:(NSInteger )speed density:(NSInteger )density clearBuffer:(BOOL)clearBuffer;

@end

NS_ASSUME_NONNULL_END
