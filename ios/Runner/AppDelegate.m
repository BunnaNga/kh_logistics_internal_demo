#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface AppDelegate () <CBCentralManagerDelegate>
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *deviceArray;
@property (strong, nonatomic) FlutterMethodChannel *bluetoothChannel;
@property (copy, nonatomic) FlutterResult flutterResult;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [GeneratedPluginRegistrant registerWithRegistry:self];

  self.deviceArray = [NSMutableArray array];
  self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

  FlutterViewController *controller = (FlutterViewController *)self.window.rootViewController;

  self.bluetoothChannel = [FlutterMethodChannel
      methodChannelWithName:@"com.example.kh_logistics_internal_demo/bluetooth"
            binaryMessenger:controller.binaryMessenger];

  __weak typeof(self) weakSelf = self;
  [self.bluetoothChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
      if ([call.method isEqualToString:@"getBluetoothDevices"]) {
          weakSelf.flutterResult = result;
          [weakSelf.deviceArray removeAllObjects];
          [weakSelf startScanning];
      } else {
          result(FlutterMethodNotImplemented);
      }
  }];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark - Bluetooth Scanning

- (void)startScanning {
    if (self.centralManager.state == CBManagerStatePoweredOn) {
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];

        // Stop scanning after 3 seconds and return devices
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.centralManager stopScan];
            if (self.flutterResult) {
                self.flutterResult([self.deviceArray copy]);
                self.flutterResult = nil;
            }
        });
    } else {
        if (self.flutterResult) {
            self.flutterResult([FlutterError errorWithCode:@"BT_OFF"
                                                   message:@"Bluetooth is not powered on"
                                                   details:nil]);
            self.flutterResult = nil;
        }
    }
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    // Optional: handle different states
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                  RSSI:(NSNumber *)RSSI {

    NSDictionary *device = @{
        @"name": peripheral.name ? peripheral.name : @"Unknown",
        @"id": peripheral.identifier.UUIDString
    };

    [self.deviceArray addObject:device];
}

@end
