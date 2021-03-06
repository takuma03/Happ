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
    NSLog(@"%@" ,samplePath);
	NSData *sampleData = [NSData dataWithContentsOfFile:samplePath];
    //NSLog(@"%@",sampleData);
    
	//送信先URL
	NSURL *url = [NSURL URLWithString:@"http://192.168.33.20/"];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
    
	//multipart/form-dataのバウンダリ文字列生成
	CFUUIDRef uuid = CFUUIDCreate(nil);
	CFStringRef uuidString = CFUUIDCreateString(nil, uuid);
	CFRelease(uuid);
	NSString *boundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
    
    NSLog(@"%@",boundary);
    
	//アップロードする際のパラメーター名
	NSString *parameter = @"csv";
    
	//アップロードするファイルの名前
	NSString *fileName = [[samplePath componentsSeparatedByString:@"/"] lastObject];
    //NSLog(@"%@",fileName);
    
	//アップロードするファイルの種類
	NSString *contentType = @"text/csv";
    
	NSMutableData *postBody = [NSMutableData data];
    
	//HTTPBody
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",parameter,fileName] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", contentType] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:sampleData];
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	//リクエストヘッダー
	NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    NSLog(@"%@",header);
    
    
	[request addValue:header forHTTPHeaderField:@"Content-Type"];
    
	[request setHTTPBody:postBody];
	
	[NSURLConnection connectionWithRequest:request delegate:self];

 }






-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	if(httpResponse.statusCode == 200) {
        
		NSLog(@"Success ٩꒰๑ ´∇`๑꒱۶✧");
        
	} else {
		
		NSLog(@"Failed (´；ω；｀)");
    }
}
              
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", jsonObject);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"%@", error);
}
              





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
