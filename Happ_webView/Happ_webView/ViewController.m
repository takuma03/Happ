//
//  ViewController.m
//  Happ_webView
//
//  Created by tkm03 on 2014/05/03.
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
    NSString *urlString = @"https://192.168.33.10/login/";
    NSURL *loginURL = [NSURL URLWithString:urlString];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:loginURL];
    
    //↓オレオレ証明書を使用しているために必要な処理
    [NSURLConnection connectionWithRequest:myRequest delegate:self];
    
    
    
    
    [self.myWebView loadRequest:myRequest];
    
    //以下はバウンドさせないための処理
    for (id subview in self.myWebView.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
    }
    
    //長押し禁止の設定はcssに以下の記述を追加
    //-webkit-touch-callout: none;
    //-webkit-user-select: none;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//↓オレオレ証明書を使用しているために必要な処理
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
//↓オレオレ証明書を使用しているために必要な処理
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        // "192.168.33.10"か確認
        if ([challenge.protectionSpace.host isEqualToString:@"192.168.33.10"]) {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        }
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
