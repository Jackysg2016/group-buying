//
//  DealWebController.m
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealWebController.h"
#import "DealModel.h"

@interface DealWebController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIView *_cover;
    NSString *_ID;

}

@end

@implementation DealWebController

-(void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", ID];
    _ID = ID;
    
    //XLog(@"%@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [_webView loadRequest:request];
    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        XLog(@"%@", data);
//        [data writeToFile:@"/Users/dengw/Desktop/test.html" atomically:YES];
//    }];
    
    
    //添加遮盖
    _cover = [[UIView alloc]init];
    _cover.frame = _webView.bounds;
    _cover.backgroundColor = kGlobalBackgroundColor;
    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_webView addSubview:_cover];
    
    //添加圈圈
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    CGFloat x = _cover.frame.size.width * 0.3;
    CGFloat y = _cover.frame.size.height * 0.5;
    indicator.center = CGPointMake(x, y);
    [_cover addSubview:indicator];
    [indicator startAnimating];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyDeal) name:kBuyDealNote object:nil];
}

#pragma mark 购买团购
-(void)buyDeal
{
    //http://m.dianping.com/tuan/buy/12695234
    NSString *url = [NSString stringWithFormat:@"http://o.p.dianping.com/buy/d%@", _ID];
    //XLog(@"buy deal url%@", url);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark 移除通知
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //删除scrollview顶部和底部灰色的view
    for (UIView *view in webView.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat height = 40;
    //顶部添加height空间
    webView.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    //往下滚动height
    webView.scrollView.contentOffset = CGPointMake(0, -height);
    
//    //1.拼接脚本
//    NSMutableString *script = [NSMutableString string];
//    //取出body
//    [script appendString:@"var body = document.getElementsByTagName('body')[0];"];
//    //取出section
//    [script appendString:@"var section = document.getElementById('J_shop_frameMobile');"];
//    //清空body
//    [script appendString:@"body.innerHTML = '';"];
//    //添加section到body
//    [script appendString:@"body.appendChild(section);"];
//    
//    //2.执行脚本
//    [webView stringByEvaluatingJavaScriptFromString:script];
    
    //3.移除遮盖
    [_cover removeFromSuperview];
    _cover = nil;
//
//    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"(document.getElementsByTagName('html')[0]).innerHTML"];
//    XLog(@"str %@", str);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //XLog(@"request %@", request.URL);
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
