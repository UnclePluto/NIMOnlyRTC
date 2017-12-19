//
//  ViewController.m
//  NIMOnlyRTC
//
//  Created by Nick Deng on 2017/6/28.
//  Copyright © 2017年 Nick Deng. All rights reserved.
//

#import "ViewController.h"
#import <NIMSDK/NIMSDK.h>
#import "NSString+MD5.h"
#import "CallViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txfToken;
@property (weak, nonatomic) IBOutlet UIButton *btLogin;
@property (weak, nonatomic) IBOutlet UITextField *txfAccount;

@property (strong, nonatomic) CallViewController *avChatVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLogin:(id)sender {
    
    NSString *account = _txfAccount.text;
    NSString *token = _txfToken.text;
    
    [[NIMSDK sharedSDK].loginManager login:account token:[self isDemoAppkey:token] completion:^(NSError * _Nullable error) {
        if (!error) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.avChatVC = [storyboard instantiateViewControllerWithIdentifier:@"avChat"];
            
//            [self showToast:@"登录成功！"];
            [self presentViewController:self.avChatVC animated:YES completion:nil];
            
        }else{
            //如果抱错302，说明accid与token不对，请与服务端确认，或者重新申请账号
            NSString *strError = [NSString stringWithFormat:@"error code:%@",error];
            NSLog(@"%@",strError);
            [self showToast:strError];
            
        }
    }];
}
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}


//判断是否是云信demo的key，如果是进行MD5加密
-(NSString *)isDemoAppkey:(NSString *)token{
    if ([[NIMSDK sharedSDK].appKey isEqualToString:@"45c6af3c98409b18a84451215d0bdd6e"]) {
        return [token stringToMD5];
    } else {
        return token;
    }
}


-(void)showToast:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
