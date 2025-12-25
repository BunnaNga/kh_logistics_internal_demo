//
//  Kmbluetooth.h
//  Km_Test
//
//  Created by 肖中旺 on 2021/9/14.
//

#import <Foundation/Foundation.h>

#import <CoreBluetooth/CoreBluetooth.h>





/**发现蓝牙*/
typedef void (^FindDevice) (CBPeripheral * _Nonnull device);

/**发现蓝牙*/
typedef void (^FindDeviceInformation) (CBPeripheral * _Nonnull device,NSDictionary<NSString *,id> *advertisementData,NSNumber *RSSI);

/**连接结果*/
typedef void (^ConnectBack) (CBPeripheralState connectState);

/**外设状态返回*/
typedef void (^CBManagerStateBack) (CBManagerState managerState);

/**读取打印机数据*/
typedef void (^NotifyBack) (NSData * _Nullable back);

/**读取并解析打印机数据*/
typedef void (^NotifyBackStr) (NSString * _Nullable back);

typedef void (^ConnectBackCBCharacteristic) (CBCharacteristic  * _Nullable writechatacter);


/**写入数据-->返回当前进度*/
typedef void (^WriteProgress) (int progress);

/**写入成功-->返回耗时*/
typedef void (^WriteSuccess) (float time,int datalength);

/**写入失败-->返回原因*/
typedef void (^WriteFail) (NSString * _Nullable reason);



NS_ASSUME_NONNULL_BEGIN

@interface Kmbluetooth : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

/**中心管理者(管理设备的扫描和连接)*/
@property (nonatomic, strong) CBCentralManager *kmCentralManager;

/**存储的设备*/
@property (nonatomic, strong) NSMutableArray<CBPeripheral*> *peripherals;
//@property (nonatomic, strong) NSMutableArray *sdkperipherals;
/**扫描到的设备*/
@property (nonatomic, strong) CBPeripheral *cbPeripheral;

/**外设状态*/
@property (nonatomic, assign) CBManagerState peripheralState;


//@property (strong, nonatomic)   NSMutableArray            *infos;  /**< 详情数组 */

/**< 可写入可数据的特性 */
@property (strong, nonatomic)   CBCharacteristic     *writechatacter;


/**通知 */
@property (strong, nonatomic)   CBCharacteristic     *notifychatacter;


/**< 写入次数 */
@property (assign, nonatomic) NSInteger writeCount;
/**< 写入数据 */
@property (assign, nonatomic) NSInteger firstCount;
@property (assign, nonatomic) NSInteger writeIndex;

/**发送数据缓存区*/
@property (nonatomic, strong) NSMutableData *data;


/**发送数据缓存区*/
@property (nonatomic, strong) NSThread *myFirstThread;

/**获取（需要返回结果发送）的mtu*/
@property (nonatomic, assign) NSInteger mtuLength;


/**发现设备返回*/
@property (nonatomic, copy) FindDevice findDevice;


/**发现设备返回*/
@property (nonatomic, copy) FindDeviceInformation findDeviceInformation;

/**连接结果返回*/
@property (nonatomic, copy) ConnectBack connectBack;

/**返回特征值*/
@property (nonatomic, copy) ConnectBackCBCharacteristic characterBack;

/**当前写入成功*/
@property (nonatomic, copy) WriteSuccess writeSuccess;

/**当前写入失败*/
@property (nonatomic, copy) WriteFail writeFail;


/**当前写入进度*/
@property (nonatomic, copy) WriteProgress writeProgress;

/**返回数据*/
@property (nonatomic, copy) NotifyBack  notifyBack;

@property (nonatomic, copy) CBManagerStateBack  managerStateBack;

/**打印开始时间*/
@property (nonatomic, strong) NSDate *dateStart;
/**打印结束时间*/
@property (nonatomic, strong) NSDate *dateEnd;


@property (nonatomic, assign) CBCharacteristicWriteType writetype;

//蓝牙数据状态
@property (nonatomic, assign) NSInteger writeEnd;



+(instancetype)shareTools;

/// 打开蓝牙
- (void)openBluetoothAdapter:(CBManagerStateBack)managerStateBack;


/// 扫描设备
/// @param findeDevice 发现设备的回调
- (void)startBluetoothDevicesDiscovery:(FindDevice)findeDevice;

///  建立连接
/// @param device 要连接的设备
/// @param connectBack 连接的结果
- (void)createBLEConnection:(CBPeripheral *)device connectBack:(ConnectBack)connectBack;



///  建立连接
/// @param device 要连接的设备
/// @param connectBack 连接的结果
/// @param characterBack 返回特征值
- (void)createBLEConnection:(CBPeripheral *)device connectBack:(ConnectBack)connectBack character:(ConnectBackCBCharacteristic)characterBack;


/// 写入数据
/// @param data 要写入的数据
- (void)writeData:(NSData *)data;


/// 写入数据并读取数据
/// @param data 要写入的数据
/// @param notifyBack 写入成功返回读取数据
- (void)writeData:(NSData *)data notifyBack:(NotifyBack)notifyBack;


/// 写入数据返回写入结果
/// @param data 要写入的数据
/// @param writeSuccess 写入成功返回结果
- (void)writeData:(NSData *)data writeSuccess:(WriteSuccess)writeSuccess;



/// 写入数据
/// @param data 要写入的数据
/// @param writeSuccess 写入成功返回结果 [结果返回耗时]
/// @param writeProgress 写入数据的当前进度  [0-100]
- (void)writeData:(NSData *)data writeSuccess:(WriteSuccess)writeSuccess writeProgress:(WriteProgress)writeProgress;


/// 写入数据
/// @param data 要写入的数据
/// @param writeSuccess 写入成功返回结果 [结果返回耗时]
/// @param writeFail 写入失败，失败原因
/// @param writeProgress 写入数据的当前进度  [0-100]
- (void)writeData:(NSData *)data writeSuccess:(WriteSuccess)writeSuccess writeFail:(WriteFail)writeFail writeProgress:(WriteProgress)writeProgress;

/// 写入数据
/// @param data 要写入的数据
/// @param cbPeripheral 指定打印机
/// @param character 制定特征值
/// @param writeSuccess 写入成功返回结果 [结果返回耗时]
/// @param writeProgress 写入数据的当前进度  [0-100]
- (void)writeData:(NSData *)data cbPeripheral:(CBPeripheral *)cbPeripheral character:(CBCharacteristic *)character writeSuccess:(WriteSuccess)writeSuccess writeProgress:(WriteProgress)writeProgress;

/// 关闭连接
- (void)closeBLEConnection;


/// 停止扫描
- (void)stopBluetoothDevicesDiscovery;




/// 获取打印机状态
/// @param notifyBackStr 状态返回
- (void)getPrinterStatus:(NotifyBackStr)notifyBackStr;


/// 获取连接状态
- (BOOL)connectStatus;

///断开连接
- (void)disconnectPrint;

@end

NS_ASSUME_NONNULL_END
