//
//  DealInfoController.m
//  XTuan
//
//  Created by dengwei on 15/8/19.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "DealInfoController.h"
#import "DetailInfoHeaderView.h"
#import "DealModel.h"
#import "DealTool.h"
#import "RestrictionModel.h"
#import "InfoText.h"

#define kVerticalMargin 20

@interface DealInfoController ()
{
    UIScrollView *_scrollView;
    DetailInfoHeaderView *_header;
}

@end

@implementation DealInfoController

-(instancetype)initWithDeal:(DealModel *)deal
{
    
    self = [super init];
    if (self) {
        _deal = deal;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加scrolllview
    [self addScrollView];
    
    //添加头部控件
    [self addHeaderView];
    
    //加载更详细的团购数据
    [self loadDetailDeal];
    
}

#pragma mark 加载更详细的团购数据
-(void)loadDetailDeal
 {
     //添加转圈圈界面
     UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
     CGFloat x = _scrollView.frame.size.width * 0.5;
     CGFloat y = CGRectGetMaxY(_header.frame) + kVerticalMargin;
     indicator.center = CGPointMake(x, y);
     [_scrollView addSubview:indicator];
     [indicator startAnimating];
     
     //发送请求
     [[DealTool sharedDealTool] dealWithID:_deal.deal_id success:^(DealModel *deal) {
         _header.deal = deal;
         _deal = deal;
         
         //添加详情数据
         [self addDetailViews];
         
         //移除转圈圈界面
         [indicator removeFromSuperview];
     } failure:^(NSError *error) {
         XLog(@"%@", error);
     }];
 }

#pragma mark 添加详情数据（其它控件）
-(void)addDetailViews
{
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_header.frame) + kVerticalMargin);
    //团购详情
    [self addInfoTextView:@"ic_content.png" title:@"团购详情" content:_deal.details];
    //XLog(@"团购详情 %@",_deal.details);
    
    //团购须知
    [self addInfoTextView:@"ic_tip.png" title:@"团购须知" content:_deal.restrictions.special_tips];
    //XLog(@"团购须知 %@",_deal.restrictions.special_tips);
    
    //重要通知
    [self addInfoTextView:@"ic_tip.png" title:@"重要通知" content:_deal.notice];
    //XLog(@"重要通知 %@",_deal.notice);
}

#pragma mark 添加一个InfoText
-(void)addInfoTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    if (content.length == 0) {
        return;
    }
    
    //创建InfoText
    InfoText *textView = [InfoText infoText];
    
    CGFloat y = _scrollView.contentSize.height;
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = textView.frame.size.height;
    
    textView.frame = CGRectMake(0, y, w, h);
    
    //基本文字设置
    textView.title = title;
    textView.content = content;
    textView.icon = icon;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //添加到scrollview
    [_scrollView addSubview:textView];
    
    //设置scrollview的内容尺寸
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(textView.frame) + kVerticalMargin);

}

#pragma mark 添加头部控件
-(void)addHeaderView
{
    DetailInfoHeaderView *header = [DetailInfoHeaderView detailInfoHeaderView];
    header.frame = CGRectMake(0, 0, _scrollView.frame.size.width, header.frame.size.height);
    header.deal = _deal;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_scrollView addSubview:header];
    _header = header;
}

#pragma mark 添加scrolllview
-(void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounds = CGRectMake(0, 0, 430, self.view.frame.size.height);
    CGFloat x = self.view.frame.size.width * 0.3;
    CGFloat y = self.view.frame.size.height * 0.5;
    scrollView.center = CGPointMake(x, y);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;

    [self.view addSubview:scrollView];
    
    CGFloat height = 70;
    //顶部添加height空间
    scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    //往下滚动height
    scrollView.contentOffset = CGPointMake(0, -height);
    
    _scrollView = scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
