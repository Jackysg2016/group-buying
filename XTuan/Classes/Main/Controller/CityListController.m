//
//  CityListController.m
//  XTuan
//
//  Created by dengwei on 15/8/14.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "CityListController.h"
#import "CitySection.h"
#import "City.h"
#import "MetaDataTool.h"
#import "SearchResultController.h"
#import "Cover.h"

#define kSearchHeight 44

@interface CityListController ()<UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate>
{
    NSMutableArray *_citySections;  //所有城市组信息
    Cover *_cover; //遮盖
    UITableView *_tableView;
    UISearchBar *_search;
    SearchResultController *_searchResult;
}

@end

@implementation CityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.添加搜索框
    [self addSearchBar];
    
    //2.添加tableView
    [self addTableView];
    
    //3.加载数据
    [self loadCitiesData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 添加搜索框
-(void)addSearchBar
{
    UISearchBar *search = [[UISearchBar alloc] init];
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, kSearchHeight);
    search.delegate = self;
    search.placeholder = @"请输入城市名或拼音";
    [search setContentMode:UIViewContentModeBottomLeft];
    [self.view addSubview:search];
    _search = search;
}

#pragma mark 添加tableView
-(void)addTableView
 {
     UITableView *tableView = [[UITableView alloc] init];
     CGFloat h = self.view.frame.size.height - kSearchHeight;
     tableView.frame = CGRectMake(0, kSearchHeight, self.view.frame.size.width, h);
     tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
     tableView.dataSource = self;
     tableView.delegate = self;
     [self.view addSubview:tableView];
     _tableView = tableView;
 }

#pragma mark 加载数据
-(void)loadCitiesData
{
    _citySections = [NSMutableArray array];
    
    NSArray *sections = [MetaDataTool sharedMetaDataTool].totalCitySections;
    
    [_citySections addObjectsFromArray:sections];
    
}

#pragma mark - SearchBar Delegate
#pragma mark 监听搜索框文字改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        //隐藏搜索界面
        [_searchResult.view removeFromSuperview];
    }else{
        //显示所搜界面
        if (_searchResult == nil) {
            _searchResult = [[SearchResultController alloc] init];
            _searchResult.view.frame = _cover.frame;
            _searchResult.view.autoresizingMask = _cover.autoresizingMask;
            [self addChildViewController:_searchResult];
        }
        _searchResult.searchText = searchText;
        [self.view addSubview:_searchResult.view];
    }
}

#pragma mark 开始编辑搜索框内文字域(开始聚焦)
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //1.显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //2.显示遮盖（蒙板）
    if (_cover == nil) {
        _cover = [Cover coverWithTarget:self action:@selector(coverClick)];
        //[_cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    }
    _cover.frame = _tableView.frame;//解决在横屏状态下，弹出一次之后，再次弹出时上次被键盘覆盖过的部分的蒙板被清除
    [self.view addSubview:_cover];
    _cover.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        [_cover reset];
    }];
}

#pragma mark 点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClick];
}

#pragma mark 监听蒙板点击
-(void)coverClick
{
    //1.移除遮盖
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    }completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    
    //2.隐藏取消按钮
    [_search setShowsCancelButton:NO animated:YES];
    
    //3.退出键盘
    [_search resignFirstResponder];
}

#pragma mark 当退出搜索框键盘时调用
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self coverClick];
}

#pragma mark - DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CitySection *s = _citySections[section];
    return s.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CitySection *s = _citySections[indexPath.section];
    City *c = s.cities[indexPath.row];
    
    cell.textLabel.text = c.name;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CitySection *s = _citySections[section];
    return s.name;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //取出_citySections中所有元素name属性的值，并且装到数组中
    NSArray *name = [_citySections valueForKeyPath:@"name"];
    
    return name;
}

#pragma mark - tableView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitySection *s = _citySections[indexPath.section];
    City *city = s.cities[indexPath.row];
    
    [MetaDataTool sharedMetaDataTool].currentCity = city;
    
}

@end
