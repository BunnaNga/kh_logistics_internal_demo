
import Flutter
import UIKit
import CoreBluetooth

@main
@objc class AppDelegate: FlutterAppDelegate {

    var deviceArray: [CBPeripheral] = []
    var deviceNameArray: [String] = []
    var status: [Int]=[]

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller = window?.rootViewController as! FlutterViewController
        let bluetoothChannel = FlutterMethodChannel(
            name: "com.example.kh_logistics_internal_demo/bluetooth",
            binaryMessenger: controller.binaryMessenger
        )

        bluetoothChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }

            switch call.method {
            case "checkConnection":
                result(Kmbluetooth.shareTools().connectStatus())
                
            case "openBluetoothAdapter":
//                self.deviceArray.removeAll()
//                self.deviceNameArray.removeAll()
                Kmbluetooth.shareTools().openBluetoothAdapter { state in
                    print("Adapter has been opened")
                    
                    Kmbluetooth.shareTools().startBluetoothDevicesDiscovery { peripheral in
                        self.deviceArray.append(peripheral)
                        self.deviceNameArray.append(peripheral.name ?? "")
                        print("name", peripheral.name ?? "")
                    }
                }
                
            case "getBluetoothDevices":
                result(self.deviceNameArray)
                
            case "selectBluetoothDevice":
                self.status.removeAll()
                guard
                    let args = call.arguments as? [String: Any],
                    let getindex = args["index"] as? Int
                else {
                    result(FlutterError(
                        code: "INVALID_ARGUMENT",
                        message: "Index not received",
                        details: nil
                    ))
                    return
                }
//                print("Index from Flutter:", getindex)

                Kmbluetooth.shareTools().createBLEConnection(deviceArray[getindex]) { CBPeripheralState in
                   
//                    self.status = CBPeripheralState.rawValue
                    self.status.append(CBPeripheralState.rawValue)
//                    print("statue connection is: ", self.status)
                    
                    print("statue connection is: ",  Kmbluetooth.shareTools().connectStatus())

                    if self.status.contains(2) {
                        let fastCase = FastCase()
                        fastCase.crtiCmdtype(Int32(0))
                        self.writeData(fastCase.printCmd as Data)
//                        print("The list contains 2")
                        result("1")
                        
                        
                    }
                    
                }
                

            case "sendImageReceipt":
                guard
                    let args = call.arguments as? [String: Any],
                    let getImage = args["receipt"] as? FlutterStandardTypedData
                else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing receipt data", details: nil))
                    return
                }

                let imageData = getImage.data

                guard let image = UIImage(data: imageData) else {
                    result(FlutterError(code: "IMAGE_CONVERSION_FAILED", message: "Failed to convert data to UIImage", details: nil))
                    return
                }
                let printData = KmCase.tspl_caseImage(image)
                // Send data with progress callback
                Kmbluetooth.shareTools().writeData(printData,
                    writeSuccess: { time, dataLength in
                        print("Printing finished: \(dataLength) bytes in \(time) seconds")

                        // Send completion with labelPrint
                        bluetoothChannel.invokeMethod("printCompleted", arguments: [
                            "message": "Printing finished",
//                            "labelPrint": "Receipt print completed"
                        ])
                        result("Printing finished")
                    },
                    writeProgress: { progress in
                        print("Receipt Print progress: \(progress)%")

                        // Send progress with labelPrint
                        bluetoothChannel.invokeMethod("printProgress", arguments: [
                            "progress": progress,
//                            "labelPrint": "Receipt is printing...."
                        ])
                    }
                )
                
//                Kmbluetooth.shareTools().writeData(KmCase.tspl_caseImage(image)) { progress, status in
//                    print("Print success! progress: \(progress), status: \(status)")
//                   // result("Image printed successfully")
//                }

            case "sendImageQrcode":
                guard
                    let args = call.arguments as? [String: Any],
                    let qrCodeList = args["qrCode"] as? [FlutterStandardTypedData]
                else {
                    result(FlutterError(
                        code: "INVALID_ARGUMENT",
                        message: "qrCode not found or invalid",
                        details: nil
                    ))
                    return
                }

//                var images: [UIImage] = []
                for (index, item) in qrCodeList.enumerated() {
                    let data = item.data
                    if let image = UIImage(data: data) {
                        let printData = KmCase.tspl_caseImage(image)
                        // Send data with progress callback
                        Kmbluetooth.shareTools().writeData(printData,
                            writeSuccess: { time, dataLength in
                                print("Printing finished: \(dataLength) bytes in \(time) seconds")

                                // Send completion with labelPrint
                                bluetoothChannel.invokeMethod("printCompleted"
                                                              , arguments: [
                                    "message": "Printing finished",
//                                    "labelPrint": "Qrcode \(index + 1) print completed"
                                ]
                                )
                                result("Printing finished")
                            },
                            writeProgress: { progress in
                                print("Qrcode Print progress: \(progress)%")

                                // Send progress with labelPrint
                                bluetoothChannel.invokeMethod("printProgress", arguments: [
                                    "progress": progress,
//                                    "labelPrint": "Qrcode \(index + 1) is printing...."
                                ])
                            }
                        )
                    }
                }

//                for item in qrCodeList {
//                    let data = item.data
//                    if let image = UIImage(data: data) {
////                        images.append(image)
//                        Kmbluetooth.shareTools().writeData(KmCase.tspl_caseImage(image)) { progress, status in
//                            print("Print success! progress: \(progress), status: \(status)")}writeProgress: { progress in
//                                <#code#>
//                                print("print progress",progress)
//                            }
//                        
//                        
//                    }
//                }
                
  
//                let imageData = getImage.data
//
//                // Convert to UIImage once
//                guard let image = UIImage(data: imageData) else {
//                    result(FlutterError(code: "IMAGE_CONVERSION_FAILED", message: "Failed to convert data to UIImage", details: nil))
//                    return
//                }
//
//                // Send to printer
                

            default:
                result(FlutterMethodNotImplemented)
            }
        }
        

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
   
    func isPrinterConnected(peripheral: CBPeripheral?) -> Bool {
        guard let p = peripheral else {
            return false
        }
        return p.state == .connected
    }

    func writeData(_ data: Data) {
        print(data.count)
        if data.count > 1000 {
            if Kmbluetooth.shareTools().cbPeripheral != nil {

            print("Start printing----")

                Kmbluetooth.shareTools().writeData(
                    data,
                    writeSuccess: { time, dataLength in

                        print(String(format: "Printing completion time：%.2f", time))

                        let speed = (Float(dataLength) / time) / 1024
                        let message = String(
                            format: "Data %d bytes - Time taken%. 2f seconds - Speed%.2fk/s",
                            dataLength, time, speed
                        )

                        print(message)

                    },
                    writeProgress: { progress in

                        DispatchQueue.main.async {
                            print("Print progress：\(progress)")

                        }
                    }
                )

            }
            

        } else {

            if Kmbluetooth.shareTools().cbPeripheral != nil {

                print("Start printing----")

                Kmbluetooth.shareTools().writeData(
                    data,
                    writeSuccess: { time, dataLength in

                        print(String(format: "Printing completion time：%.2f", time))

                        let speed = (Float(dataLength) / time) / 1024
                        let message = String(
                            format: "Data %d bytes - Time taken%. 2f seconds - Speed%.2fk/s",
                            dataLength, time, speed
                        )

                        print(message)

                    }
                )

            }
        }
    }

    
}

