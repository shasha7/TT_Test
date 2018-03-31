//
//  ViewController.m
//  TTTestProject
//
//  Created by hu hu on 2018/3/31.
//  Copyright © 2018年 hu hu. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+HCYLabelTapAction.h"
#import "TTFeedbackViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (copy, nonatomic) NSString *totalText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.outputTextView.textContainerInset = UIEdgeInsetsMake(0,0, 0, 0);//文本距离边界值
    self.inputTextView.text = @"欢迎使用探探, 在使用过程中有疑问请< a href=”tantanapp://feedback”>反馈</ a>";
    _totalText = [self getZZwithString:self.inputTextView.text];


}
//使用textView实现
- (IBAction)confirmTextViewButton:(id)sender {
    if ([_totalText containsString:@"反馈"]) {
        NSRange startRange = [_totalText rangeOfString:@"反馈"];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString: _totalText];
        [attStr addAttribute:NSLinkAttributeName value:@"feedback://" range:startRange];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, attStr.length)];
        self.outputTextView.attributedText = attStr;
        self.outputTextView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                         NSUnderlineColorAttributeName: [UIColor lightGrayColor]};
    }else{
        self.outputTextView.text = @"";
        [self alertShowWithMessage:@"未找到关键字"];
        
    }

}
//使用label实现，参考YBAttributeTextTapAction
- (IBAction)confirmLabel:(id)sender {
     if ([_totalText containsString:@"反馈"]) {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString: _totalText];
    //        设置字体大小，一定要设置
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, _totalText.length)];
    self.outputLabel.attributedText = attStr;
    [self.outputLabel addAttributeTapActionWithStrings:@"反馈" tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        
        TTFeedbackViewController *feedVC = [[TTFeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedVC animated:YES];
        
    }];
     }else{
         self.outputLabel.text = @"";
         [self alertShowWithMessage:@"未找到关键字"];

     }
}

- (void)alertShowWithMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
//正则去除网络标签
-(NSString *)getZZwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|&nbsp"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}
//textView代理
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    if ([[URL scheme] isEqualToString:@"feedback"]) {
//        NSRange startRange = [_totalText rangeOfString:@"反馈"];

    
        TTFeedbackViewController *feedVC = [[TTFeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedVC animated:YES];
        return NO;
    }
     return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
