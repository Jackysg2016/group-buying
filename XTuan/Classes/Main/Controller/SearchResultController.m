//
//  SearchResultController.m
//  XTuan
//
//  Created by dengwei on 15/8/15.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "SearchResultController.h"
#import "City.h"
#import "MetaDataTool.h"

#import "PinYin4Objc.h"

@interface SearchResultController ()
{
    NSMutableArray *_resultCities; //放所有搜索到的城市
}

@end

@implementation SearchResultController

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resultCities = [NSMutableArray array];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    // 1.清除之前的搜索结果
    [_resultCities removeAllObjects];
    
    // 2.筛选城市
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase; //大小写设置
    fmt.toneType = ToneTypeWithoutTone; //音调设置
    fmt.vCharType = VCharTypeWithUUnicode; //v的设置
    
    NSDictionary *cities = [MetaDataTool sharedMetaDataTool].totalCities;
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, City *obj, BOOL *stop) {
        // SHI#JIA#ZHUANG
        // 1.拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        XLog(@"pinyin:%@", pinyin);
        
        // 2.拼音首字母
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyinHeader = [NSMutableString string];
        for (NSString *word in words) {
            [pinyinHeader appendString:[word substringToIndex:1]];
        }
        
        /*
         补充：这里少加一行代码
         */
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // 3.城市名中包含了搜索条件
        // 拼音中包含了搜索条件
        // 拼音首字母中包含了搜索条件
        if (([obj.name rangeOfString:searchText].length != 0) ||
            ([pinyin rangeOfString:searchText.uppercaseString].length != 0)||
            ([pinyinHeader rangeOfString:searchText.uppercaseString].length != 0))
        {
            // 说明城市名中包含了搜索条件
            [_resultCities addObject:obj];
        }
    }];
    
    // 3.刷新表格
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共%lu个搜索结果", (unsigned long)_resultCities.count];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    City *city = _resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City *city = _resultCities[indexPath.row];
    
    [MetaDataTool sharedMetaDataTool].currentCity = city;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
