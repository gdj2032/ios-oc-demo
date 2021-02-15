//
//  AlertVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "AlertVC.h"
#import "AlertView.h"
#import "CustomAlert.h"

@interface AlertVC ()<UITableViewDelegate, UITableViewDataSource>

// 数据源
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation AlertVC

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = white_color;
    [self.dataArray addObject:@"普通的alert"];
    [self.dataArray addObject:@"textField对话框"];
    [self.dataArray addObject:@"上拉菜单"];
    [self.dataArray addObject:@"隐私协议弹窗 含富文本点击"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    //先从缓存池中区
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];;
    //缓存池中没有再创建，并添加标识，cell移出缓存池以复用
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = blue_color;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //普通的alert
        [[AlertView shareAlertView] alertWithTitle:@"标题" message:@"这是message" btnTitle:@"确定" btnTitleColor:nil completion:nil];
    } else if (indexPath.row == 1) {
        //input对话框
        [self textFieldAlert];
    } else if (indexPath.row == 2) {
        //上拉菜单
        [self dropDownMenu];
    } else if (indexPath.row == 3) {
        //隐私协议弹窗 含富文本点击
        NSString*title = @"标题";
        NSString*msg= @"shkjadhk哈卡时间段哈哈打瞌睡爱看的好看的我是谁好速度很快ahjsdhkjahd爱好的哈可接受的海口市";
        NSString*clickTitle = @"我是谁";
        CustomAlert *alert = [[CustomAlert shareCustomAlert] initCustomAlertWithTitle:title withMessage:msg clickTitle:clickTitle withLeftText:@"确定" withRightText:@"取消" withleftComplete:^{
            NSLog(@"点击确定");
        } withrightComplete:^{
            NSLog(@"点击取消");
        } withKey:@"alert_key"];
        [alert richTextClick:^(NSString * _Nonnull key) {
            NSLog(@"key = %@",key);
        }];
    } else if (indexPath.row == 4) {
    } else if (indexPath.row == 5) {
    } else if (indexPath.row == 6) {
    } else if (indexPath.row == 7) {
    }
}

- (void) openWithVC:(UIViewController *) vc {
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    [topVC presentViewController:vc animated:YES completion:nil];
}

-(void) textFieldAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"文本对话框"message:@"登录和密码对话框示例" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:
     ^(UITextField *textField){
        textField.placeholder = @"登录";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name: UITextFieldTextDidChangeNotification object:textField];
    }];
    [alertController addTextFieldWithConfigurationHandler:
     ^(UITextField *textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle: @"确定"style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
        UITextField *login = alertController.textFields.firstObject;
        UITextField *password = alertController.textFields.lastObject;
        NSLog(@"login = %@, password = %@", login.text, password.text);
    }];
    okAction.enabled = NO;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: @"取消"style:UIAlertActionStyleCancel handler: ^(UIAlertAction *action) {
        NSLog(@"cancel");
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//登录输入框和确定按钮
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if(alertController) {
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 2;
    }
}

//上拉菜单
-(void)dropDownMenu{
    /**
     您不能在上拉菜单中添加文本框，如果您强行作死添加了文本框，那么就会荣幸地得到一个运行时异常：
     *Terminating app due to uncaught exception
     ‘NSInternalInconsistencyException’, reason: ‘Text fields can only be
     added to an alert controller of style UIAlertControllerStyleAlert’
     
     如果上拉菜单中有“取消”按钮的话，那么它永远都会出现在菜单的底部，不管添加的次序是如何（就是这么任性）。其他的按钮将会按照添加的次序从上往下依次显示。《iOS 用户界面指南》要求所有的“毁坏”样式按钮都必须排名第一（红榜嘛，很好理解的，对不对？）。
     别激动得太早，我们现在还有一个很严重的问题，这个问题隐藏得比较深。当我们使用iPad或其他常规宽度的设备时，就会得到一个运行时异常：
     Terminating app due to uncaught exception ‘NSGenericException’, reason:
     ‘UIPopoverPresentationController
     (<_uialertcontrolleractionsheetregularpresentationcontroller:
     0x7fc619588110="">) should have a non-nil sourceView or barButtonItem
     set before the presentation occurs.’


     */
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:
      @"保存或删除数据"message:@"删除数据将不可恢复"
      preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
      style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除"
      style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存"
      style:UIAlertActionStyleDefault handler:nil];

    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
//    UIPopoverPresentationController *popover =
//      alertController.popoverPresentationController;
//    if(popover){
//      popover.sourceView = sender;
//      popover.sourceRect = sender.bounds;
//      popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    }

}

@end
