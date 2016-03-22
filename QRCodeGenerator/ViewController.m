//
//  ViewController.m
//  QRCodeGenerator
//
//  Created by shejun.zhou on 16/3/21.
//  Copyright © 2016年 shejun.zhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *barCodeImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _qrCodeImageView.image = [self generateQRCode:@"1234567890" size:_qrCodeImageView.frame.size];
    _barCodeImageView.image = [self generateBarCode:@"123456789999" size:_barCodeImageView.frame.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size {
    
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *qrcodeImage = [filter outputImage];
    CGFloat scaleX = size.width/qrcodeImage.extent.size.width;
    CGFloat scaleY = size.height/qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

- (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size {
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding ];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];

    CIImage *barcodeImage = [filter outputImage];
    
    CGFloat scaleX = size.width/barcodeImage.extent.size.width;
    CGFloat scaleY = size.height/barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    return [UIImage imageWithCIImage:transformedImage];
}

@end
