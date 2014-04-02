//
//  ViewController.m
//  Happ_dataRecieve
//
//  Created by tkm03 on 2014/04/02.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSMutableData *receivedData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/csv/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLConnection *Connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (!Connection) {
        NSLog(@"connection error.");
    }
}

// データ受信時に１回だけ呼び出される。
// 受信データを格納する変数を初期化する。
- (void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response {
    // receiveDataはフィールド変数
    receivedData = [[NSMutableData alloc] init];
}

// データ受信したら何度も呼び出されるメソッド。
// 受信したデータをreceivedDataに追加する
- (void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

// データ受信が終わったら呼び出されるメソッド。
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // 今回受信したデータはHTMLデータなので、NSDataをNSStringに変換する。
    NSString *html
    = [[NSString alloc] initWithBytes:receivedData.bytes
                               length:receivedData.length
                             encoding:NSUTF8StringEncoding];
    
    // 受信したデータをUITextViewに表示する。
    _textView.text = html;
    
    // 終わった事をAlertダイアログで表示する。
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Finish Loading" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
