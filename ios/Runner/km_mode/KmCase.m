//
//  UseCase.m
//  xzwblue
//
//  Created by 肖中旺 on 2021/9/10.
//

#import "KmCase.h"
#import "FastCase.h"
#import "HexUtils.h"

@implementation KmCase

//
#pragma mark - TSPL
+ (NSData *)tspl_case1
{
    FastCase *fastCase = [[FastCase alloc]init];
//    [fastCase crtiCmdtype:0];
//    [fastCase.printCmd appendData:[HexUtils hexStrToData:@"1B00604A4BA98C80FFFF0000000009000002001100030357120000"]];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"SETC AUTODOTTED OFF\r\n"]];
    [fastCase addSize:75 height:120];
    [fastCase addCls];
//    [fastCase addSpeed:@"3"];
//    [fastCase addDensity:@"15"];
    
    [fastCase addText:50 y:50 font:@"TSS16.BF2" rotate:0 xMultiple:1 yMultiple:1 alignment:0 content:@"你好快麦打印机16号字体"];
    

//    [fastCase addText:50 y:50 font:@"1" rotate:0 xMultiple:1 yMultiple:1 alignment:0 content:@"你好快麦打印机16号字体"];

    [fastCase addBox:20 y:20 xend:500 yend:800 thickness:2 radius:0];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR R160G0B0A1\r\n"]];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR R255G0B0A1\r\n"]];
    [fastCase addText:50 y:100 font:@"TSS24.BF2" rotate:0 xMultiple:1 yMultiple:1 alignment:0 content:@"你好快麦打印机24号字体"];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR END\r\n"]];


    [fastCase addText:250 y:50 font:@"TSS16.BF2" rotate:0 xMultiple:1 yMultiple:1 alignment:0 content:@"你好快麦打印机16号字体"];
    [fastCase addReverse:240 y:40 width:200 height:40];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR R255G0B0A1\r\n"]];
    [fastCase addBar:50 y:200 width:300 height:3];
    
    [fastCase addBarcode:50 y:210 codeType:@"128" height:100 style:1 rotation:0 narrow:2 wide:2 alignment:0 content:@"kuaimai123456"];
    [fastCase addQRCode:50 y:350 eccLevel:@"L" cellWidth:7 mode:@"M" rotate:0 model:@"M1" mask:@"S3" content:@"kuaimai123456"];

    [fastCase addCircle:50 y:550 diameter:100 thickness:3];
    [fastCase addEllipse:200 y:550 width:200 height:100 thickness:3];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR END\r\n"]];

//    [fastCase addWaterMark:@"70kmp"];
    [fastCase addText:50 y:660 font:@"TSS24.BF2" rotate:0 xMultiple:1 yMultiple:1 alignment:0 content:@"你好快麦打印机24号字体水印"];
    [fastCase addWaterMark:@"0"];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR R255G0B0A1\r\n"]];

    [fastCase addPrint:1 n:1];
   NSLog(@"16进制%@",[HexUtils dataToHexStr:fastCase.printCmd]);
    NSLog(@"明文%@",[HexUtils dataToStr:fastCase.printCmd]);

//    fastCase.printCmd = [HexUtils strToData:@"ぁぃぅぃぉ"];

    return fastCase.printCmd;

}

+ (NSData *)tspl_caseImage:(UIImage *)image
{
//    UIImage *image = [UIImage imageNamed:@"test_printer"];

    // 40x30mm @203dpi ≈ 320x240 dots
//    image = [self scaleImageToPaper:image];
    image = [self convertToBit:image];

    FastCase *fastCase = [[FastCase alloc] init];

//    [fastCase addSize:80 height:100];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"DENSITY 12\r\n"]];
//    [fastCase addDirection:0 n:0];
//    [fastCase addReference:0 y:0];
//    [fastCase addCls];
////
    [fastCase addBitmap:0 y:0 mode:0 image:image];
    [fastCase addPrint:1 n:1];

    return fastCase.printCmd;
}


+ (NSData *)tspl_case2
{
    UIImage *image = [UIImage imageNamed:@"test_printer"];

    // 40x30mm @203dpi ≈ 320x240 dots
 //   image = [self scaleImageToPaper:image];
    image = [self convertToBit:image];

    FastCase *fastCase = [[FastCase alloc] init];

    [fastCase addSize:80 height:100];
    [fastCase addCls];
    [fastCase.printCmd appendData:[HexUtils strToData:@"DENSITY 12\r\n"]];
    [fastCase addDirection:0 n:0];
    [fastCase addReference:0 y:0];

    [fastCase addBitmap:14 y:100 mode:0 image:image];
    [fastCase addPrint:1 n:1];

    return fastCase.printCmd;
}

+ (UIImage *)scaleImageToPaper:(UIImage *)image
{
    CGSize size = CGSizeMake(639, 799); // calculated dots
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//
//+ (UIImage *)convertToBit:(UIImage *)image {
//    size_t width = image.size.width;
//    size_t height = image.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
//    CGContextRef context = CGBitmapContextCreate(nil,
//                                                 width,
//                                                 height,
//                                                 8,
//                                                 width,
//                                                 colorSpace,
//                                                 kCGImageAlphaNone);
//    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
//    CGImageRef bwImage = CGBitmapContextCreateImage(context);
//    UIImage *result = [UIImage imageWithCGImage:bwImage];
//    CGImageRelease(bwImage);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return result;
//}
+ (UIImage *)convertToBit:(UIImage *)image
{
    int width = image.size.width;
    int height = image.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();

    uint8_t *rawData = calloc(width * height, sizeof(uint8_t));

    CGContextRef context = CGBitmapContextCreate(
        rawData,
        width,
        height,
        8,
        width,
        colorSpace,
        kCGImageAlphaNone
    );

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);

    // 🔥 Threshold (tune value 120–160)
    int threshold = 200;
    for (int i = 0; i < width * height; i++) {
        rawData[i] = (rawData[i] < threshold) ? 0 : 255;
    }

    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *bwImage = [UIImage imageWithCGImage:imageRef];

    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    free(rawData);

    return bwImage;
}

#pragma mark - CPCL
+ (NSData *)cpcl_case1
{
    FastCase *fastCase = [FastCase new];
    [fastCase cpcl_addInit:800 copys:1];
    [fastCase cpcl_addUnit:@"IN-DOTS"];
    [fastCase cpcl_addWidth:600];
    [fastCase cpcl_SetMag:1 h:1];
    
    
    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:50 data:@"你好快麦打印机24"];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR R255G0B0A1\r\n"]];

    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:100 data:@"你好快麦打印机24彩色"];
    
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:100 data:@"你好快麦打印机24反白"];
//    [fastCase cpcl_addInverseLine:50 starty:100 endx:350 endy:100 width:40];
    [fastCase cpcl_SetMag:3 h:3];
    [fastCase addWaterMark:@"50kmp"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:300 data:@"3-3"];
    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:150 y:300 data:@"你好快麦打印机24"];
    [fastCase addWaterMark:@"0"];
    [fastCase cpcl_SetMag:3 h:3];
    [fastCase cpcl_addText:@"T" font:@"4" size:@"0" x:50 y:200 data:@"R200你好快麦打印机32"];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR END\r\n"]];

    [fastCase cpcl_SetMag:2 h:1];
    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:150 data:@"2-1你好快麦打印机24"];
    [fastCase cpcl_SetMag:3 h:3];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:150 y:300 data:@"你好快麦打印机24"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:300 data:@"3-3你好快麦打印机24"];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR R255G0B0A1\r\n"]];
    [fastCase cpcl_addLine:50 starty:380 endx:250 endy:380 width:5];

    [fastCase cpcl_addBarcode:NO codetype:@"128" width:1 radio:@"1" height:50 x:50 y:390 data:@"kuaimai123456"];
    [fastCase cpcl_addQrcode:false codetype:@"QR" x:50 y:500 m:2 n:6 data1:@"M" data2:@"A" data3:@"kuaimai123456"];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR END\r\n"]];
    [fastCase cpcl_form];
    [fastCase cpcl_print];
    
    
//    fastCase.printCmd = [HexUtils strToData:@"! 0 200 200 600 1\r\nSETBOLD 2\r\nT 4 0 10 10 测试，当你看到这个页面\r\nT 4 0 10 60 说明打印功能是完善的！\r\nSETBOLD 0\r\nT 55 0 10 110 用于12号以下字\r\nT 1 0 10 140 用于13~16号字\r\nT 4 0 10 180 用于17~20号字\r\nSETMAG 2 2\r\nT 1 0 10 230 用于21~29号字\r\nSETMAG 3 4\r\nT 4 0 10 300 用于30号以上字\r\nSETMAG 0 0\r\nPRINT\r\n"];
    
    
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:50 data:@"あアいイうウえエおオ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:100 data:@"かカきキくクけケこコ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:150 data:@"さサしシすスせセそソ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:200 data:@"たタちチつツてテとト"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:250 data:@"なナにニぬヌねネのノ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:300 data:@"はハひヒふフへヘほホ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:350 data:@"まマみミむムめメもモ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:400 data:@"やヤゆユよヨ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:450 data:@"らラりリるルれレろロ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:500 data:@"わワをヲ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:550 data:@"んン"];
    
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:50 data:@"ぁぃぅぃぉァィゥェォ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:150 data:@"ｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:200 data:@"ﾝｶﾞｷﾞｸﾞｹﾞｺﾞｻﾞｼﾞｽﾞｾﾞｿﾞﾀﾞﾁﾞﾂﾞﾃﾞﾄﾞﾊﾞﾋﾞﾌﾞﾍﾞﾎﾞ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:250 data:@"ﾊﾟﾋﾟﾌﾟﾍﾟﾎﾟｷｬｷｭｷｮｼｬｼｭｼｮﾁｬﾁｭﾁｮﾆｬﾆｭﾆｮ ﾋｬﾋｭﾋｮﾐｬﾐｭﾐｮ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:300 data:@"ﾘｬﾘｭﾘｮｷﾞｬｷﾞｭｷﾞｮｼﾞｬｼﾞｭｼﾞｮﾋﾞｬﾋﾞｭﾋﾞｮﾋﾟｬﾋﾟｭﾋﾟｮあアいイうウえエおオ"];
//
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:350 data:@" かカきキくクけケこコさサしシすスせセそソたタちチつツてテとトなナにニぬヌねネのノはハひヒふフへヘほホ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:400 data:@" まマみミむムめメもモやヤゆユよヨらラりリるルれレろロわワをヲんンがガぎギぐグげゲごゴざザじジずズぜゼぞゾだダぢヂづヅでデどドばバびビぶブべベぼボぱパぴピぷプぺペぽポ"];
//
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:450 data:@"きゃキャきゅキュきょキョしゃシャしゅシュしょショちゃチャちゅチュちょチョにゃニャにゅニュにょニョひゃヒャひゅヒュひょヒョみゃミャみゅミュみょミョりゃリャりゅ"];
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:500 data:@"リュりょリョぎゃギャぎゅギュぎょギョじゃジャじゅジュじょジョびゃビャびゅビュびょビョぴゃピャぴゅピュぴょピョ"];
    
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:550 data:@"ぁぃぅぃぉァィゥェォ亜哀悪握圧扱安暗案~!@#$%^&*()_+`-=/*-+,./;'[]\{}|:\"?><abcdefghijklmno p q r s t u v w x y z"];
//
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:600 data:@"下記の処理中にてエラーメッセージが送信されました。処理が中断している恐れがあります。【処理名】:店舗移動実績【処理開始】:2022/06/27 00:55:01【メッセージ】:ファイルインポート解析中にエラーが発生しました。"];
//
//    [fastCase cpcl_addText:@"T" font:@"1" size:@"0" x:50 y:650 data:@"ファイル名:詳細はエラーログを確認してください。このメールは配信専用となっております。このメールに返信してBLにコメントを投稿するか、下記のボタンをクリックして課題を表示してください。"];
//
    return fastCase.printCmd;
    
}


+ (NSData *)cpcl_case2:(UIImage *)image
{
//    NSString * imageBase64 = [HexUtils getStringWithFilePath:@"快麦打印机"];
//    
//    UIImage *image = [HexUtils getImageWithBase64:imageBase64];
    
    FastCase *fastCase = [[FastCase alloc]init];
//    [fastCase crtiCmdtype:0];

//    image = [PdftoImage scaleImage:image size:CGSizeMake(240, 240)];
    [fastCase cpcl_addInit:560 copys:1];
    [fastCase cpcl_addUnit:@"IN-DOTS"];
    [fastCase cpcl_addWidth:400];
//    [fastCase cpcl_addHeight:320];
    
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR R160G0B0A1\r\n"]];
    [fastCase cpcl_addBitmap:0 y:0 mode:1 image:image];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR END\r\n"]];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"GAP-SENSE\r\n"]];
//    [fastCase.printCmd appendData:[HexUtils strToData:@"COLOR END\r\n"]];
    [fastCase cpcl_form];
    [fastCase cpcl_print];
    NSLog(@"16进制----%@",[HexUtils dataToHexStr:fastCase.printCmd]);
    
//    fastCase.printCmd = [HexUtils hexStrToData:@"21203020323030203230302033323020310D0A504147452D5749445448203332300D0A4347203720353420302031362020FFFE1FCC39FFFCFFFE1FCC39FFFCC0061F00F9800CC0061F00F9800CCFE67CF3E19FCCCFE67CF3E19FCCCFE67CFFE19FCCCFE67CCCE19FCCCFE67CCCE19FCCCFE673FC399FCCCFE673FC399FCCC006730FF9800CC006730FF9800CFFFE733339FFFCFFFE733339FFFC00007300F8000000007300F80000CFFE1FFF01FFC0CFFE1FFF01FFC0FFFFFFFF1FFFF0F3E1FCC03E6030F3E1FCC03E6030FE661CFCFFFF3CFE661CFCFFFF3CF061FFF3E6600CF061FFF3E6600CF3FFFCCF01F9FCF3FFFCCF01F9FCCF807F3C386730CF807F3C386730C39F9F0FFE7F3CC39F9F0FFE7F3CCFE07033E0670CCFE07033E0670CCFFE603FFFFFCCCFFE003FFFF9C0CFFE003FFFF9C000007C0CF81FC000007C0CF81FC0FFFE1FF3399FFCFFFE1FF3399FFCC00670C3381F00C00670C3381F00CFE670C0FFFFFCCFE670C0FFFFFCCFE6733C07F9FCCFE6733C07F9FCCFE67F3F07F9FCCFE67F0F0061CCCFE67F0F0061CCC0061F3C387F0CC0061F3C387F0CFFFE7333067FFCFFFE7333067FFC4741502D53454E53450D0A464F524D0D0A5052494E540D0A"];
    
    return fastCase.printCmd;
}


#pragma mark - ESC
+ (NSData *)esc_case1
{
    FastCase *fastCase = [FastCase new];
    [fastCase esc_addInit];
    [fastCase esc_addAlign:1];
    [fastCase esc_setCharSize:0 height:0];
    [fastCase esc_addText:@"快麦打印机居中\r\n"];
    [fastCase esc_addAlign:0];
    [fastCase esc_setCharSize:1 height:1];
    [fastCase esc_addText:@"快麦打印机放大1-1\r\n"];
    [fastCase esc_setCharSize:2 height:2];
    [fastCase esc_addText:@"快麦打印机放大2-2\r\n"];
//    [fastCase esc_setCharSize:3 height:3];
//    [fastCase esc_addText:@"快麦打印机放大3-3\r\n"];
    [fastCase esc_setCharSize:0 height:0];
    [fastCase esc_addLocation:@"文本1" text2:@"文本2\r\n\r\n"];
    [fastCase esc_setCharSize:0 height:0];
    [fastCase esc_addText:@"width2条码宽度36mm\r\n"];
    [fastCase esc_barCode:2 height:80 font:1 loc:2 m:73 data:@"width2abcd"];
    [fastCase esc_addText:@"\r\n"];
    
    [fastCase esc_addText:@"width3条码宽度54mm\r\n"];
    [fastCase esc_barCode:3 height:80 font:1 loc:2 m:73 data:@"width2abcd"];
    [fastCase esc_addText:@"\r\n"];
    
    [fastCase esc_addText:@"width4条码宽度72mm\r\n"];
    [fastCase esc_barCode:4 height:80 font:1 loc:2 m:73 data:@"width2abcd"];
    [fastCase esc_addText:@"\r\n"];
    
    [fastCase esc_addText:@"width5条码宽度90mm\r\n"];
    [fastCase esc_barCode:5 height:80 font:1 loc:2 m:73 data:@"width2abcd"];
    [fastCase esc_addText:@"\r\n"];
    [fastCase esc_addText:@"\r\n"];
    
    [fastCase esc_addText:@"\r\nSIZE-1二维码宽度3mm\r\n"];
    [fastCase esc_qrCode:1 data:@"kuaimai123456"];
    
    [fastCase esc_addText:@"\r\nSIZE-2二维码宽度4mm\r\n"];
    [fastCase esc_qrCode:2 data:@"kuaimai123456"];
    
    [fastCase esc_addText:@"\r\nSIZE-3二维码宽度7mm\r\n"];
    [fastCase esc_qrCode:3 data:@"kuaimai123456"];
    
    
    [fastCase esc_addText:@"\r\nSIZE-4二维码宽度10mm\r\n"];
    [fastCase esc_qrCode:4 data:@"kuaimai123456"];
    
    [fastCase esc_addText:@"\r\nSIZE-5二维码宽度13mm\r\n"];
    [fastCase esc_qrCode:5 data:@"kuaimai123456"];
    
    [fastCase esc_addText:@"\r\nSIZE-6二维码宽度16mm\r\n"];
    [fastCase esc_qrCode:6 data:@"kuaimai123456"];
    
    [fastCase esc_addText:@"\r\nSIZE-7二维码宽度18mm\r\n"];
    [fastCase esc_qrCode:7 data:@"kuaimai123456"];
    
    [fastCase esc_addText:@"\r\nSIZE-8二维码宽度21mm\r\n"];
    [fastCase esc_qrCode:8 data:@"kuaimai123456"];
    
    [fastCase esc_addText:@"\r\nSIZE-9二维码宽度24mm\r\n"];
    [fastCase esc_qrCode:9 data:@"kuaimai123456"];
//
    [fastCase esc_addText:@"\r\nSIZE-10二维码宽度26mm\r\n"];
    [fastCase esc_qrCode:10 data:@"kuaimai123456"];
//
    [fastCase esc_addText:@"\r\nSIZE-11二维码宽度29mm\r\n"];
    [fastCase esc_qrCode:11 data:@"kuaimai123456"];
    [fastCase esc_addText:@"\r\nSIZE-12二维码宽度31mm\r\n"];
    [fastCase esc_qrCode:12 data:@"kuaimai123456"];
    [fastCase esc_addText:@"\r\nSIZE-13二维码宽度34mm\r\n"];
    [fastCase esc_qrCode:13 data:@"kuaimai123456"];
    [fastCase esc_addText:@"\r\nSIZE-14二维码宽度37mm\r\n"];
    [fastCase esc_qrCode:14 data:@"kuaimai123456"];
    [fastCase esc_addText:@"\r\nSIZE-15二维码宽度39mm\r\n"];
    [fastCase esc_qrCode:15 data:@"kuaimai123456"];
    
    
    [fastCase esc_feed:5];
    
    
    NSLog(@"%@",[HexUtils dataToHexStr:fastCase.printCmd]);
    
    return fastCase.printCmd;
}



+ (NSData *)esc_case2
{
    NSString * imageBase64 = [HexUtils getStringWithFilePath:@"测试模版_40x30_b64"];
    
    UIImage *image = [HexUtils getImageWithBase64:imageBase64];
    FastCase *fastCase = [[FastCase alloc]init];
//    [fastCase crtiCmdtype:0];

    [fastCase esc_addInit];
//    1f8001201f1151001b4a00
//    [fastCase.printCmd appendData:[HexUtils hexStrToData:@"1f115100"]];
//    for (int j = 0; j<160; j++) {
//        [fastCase.printCmd appendData:[HexUtils hexStrToData:@"1B2A202200"]];
//        for (int i = 0;i<34; i++) {
//
//            [fastCase.printCmd appendData:[HexUtils hexStrToData:@"FF"]];
//        }
//    }
//
//
//    [fastCase.printCmd appendData:[HexUtils hexStrToData:@"0D0A"]];
    
    
   
    
//    [fastCase esc_addAlign:0];
    [fastCase.printCmd appendData:[self start]];
    
    [fastCase esc_addBitmap:0 image:image];
//    [fastCase esc_feed:5];
    [fastCase.printCmd appendData:[self escPrint]];
    
    NSLog(@"指令--------%d",fastCase.printCmd.length);
    NSLog(@"指令----%@----",[HexUtils dataToHexStr:fastCase.printCmd]);
    
    
    
    return fastCase.printCmd;
}

+ (NSData *)escPrint
{
    NSMutableData *data = [NSMutableData new];
    Byte lineSpace[] = {0x0C};
    [data appendBytes:lineSpace length:sizeof(lineSpace)];
    return data;
}

+ (NSData *)start
{
    NSMutableData *data = [NSMutableData new];
    Byte lineSpace[] = {0x1F,0x11,0x51,0x00};
    [data appendBytes:lineSpace length:sizeof(lineSpace)];
    return data;
}





@end
