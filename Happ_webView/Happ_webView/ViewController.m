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
    NSString *urlString = @"https://192.168.33.10/webLink/";
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
    
    
    self.myWebView.delegate = self;
    
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

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // もしNative連携用のURLスキームの場合には、処理する。
    NSString *urlStr = request.URL.absoluteString;
    if ([urlStr hasPrefix:@"api-yoheim://"]) {
        
    	// %エスケープされた内容を、デコードする。
        urlStr = [urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // 不要な部分を削除する。
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"api-yoheim://" withString:@""];
        
        // カスタムURLスキームで指定された指示を、正規表現を利用して特定します。
        NSRegularExpression *regexp = [[NSRegularExpression alloc]
                                       initWithPattern:@"^(.*?)\\{(.*?)\\}$"
                                       options:0
                                       error:nil];
        
        NSArray *matches = [regexp matchesInString:urlStr
                                           options:0
                                             range:NSMakeRange(0, urlStr.length)];
        
        for (NSTextCheckingResult *match in matches) {
            // URLの内容から、メソッドとその引数を取得します。
            NSString *method = [urlStr substringWithRange:[match rangeAtIndex:1]];
            NSString *params = [urlStr substringWithRange:[match rangeAtIndex:2]];
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            // メソッドをコールします。
            [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@:", method])
                       withObject:params];
            #pragma clang diagnostic pop
        }
        
        // カスタムスキームの場合には、リクエストを中止します。
        return NO;
    }
    
    // 上記以外は、リクエストが外部へ放出することを許可します。
    return YES;
}


#pragma mark - Actions
// JavaScriptから指定されて呼び出されるメソッド。
-(void)someAlert:(NSString *)message {
    UIAlertView *alert
    = [[UIAlertView alloc] initWithTitle:@""
                                 message:message
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil];
    [alert show];
}

@end
