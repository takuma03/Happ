//
//  ViewController.m
//  Happ_csvUpload
//
//  Created by tkm03 on 2014/02/09.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *samplePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"csv"];
	NSData *sampleData = [NSData dataWithContentsOfFile:samplePath];
    
    NSLog(@"%@",samplePath);
    NSLog(@"%@",sampleData);
    
	//送信先URL
	NSURL *url = [NSURL URLWithString:@"192.168.33.20"];
    
    NSLog(@"%@",url);
    

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
    
	//multipart/form-dataのバウンダリ文字列生成
	CFUUIDRef uuid = CFUUIDCreate(nil);
	CFStringRef uuidString = CFUUIDCreateString(nil, uuid);
	CFRelease(uuid);
	NSString *boundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
    
	//アップロードする際のパラメーター名
	NSString *parameter = @"movie";
    
	//アップロードするファイルの名前
	NSString *fileName = [[samplePath componentsSeparatedByString:@"/"] lastObject];
    
	//アップロードするファイルの種類
	NSString *contentType = @"video/mp4";
    
	NSMutableData *postBody = [NSMutableData data];
    
	//HTTPBody
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",parameter,fileName] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", contentType] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:sampleData];
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	//リクエストヘッダー
	NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
	[request addValue:header forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postBody];
	
	[NSURLConnection connectionWithRequest:request delegate:self];

 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
