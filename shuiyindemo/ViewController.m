//
//  ViewController.m
//  shuiyindemo
//
//  Created by zhqh on 2024/12/23.
//

#import "ViewController.h"
#import "UIImage+WaterMark.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.cyanColor;
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *waterImage = [[UIImage imageNamed:@"upload_card_front_placehoder"] addWaterMark:@"2024-12-01" size:imgV.frame.size];
    imgV.image = waterImage;
    [self.view addSubview:imgV];
    
}




@end
