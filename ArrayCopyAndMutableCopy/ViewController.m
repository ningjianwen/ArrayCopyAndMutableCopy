//
//  ViewController.m
//  ArrayCopyAndMutableCopy
//
//  Created by jianwen ning on 13/06/2019.
//  Copyright © 2019 jianwen ning. All rights reserved.
//  该demo主要是针对1、NSArray的copy和mutableCopy操作进行探究
//                2、NSMutableArray的copy和mutableCopy操作进行探究
//                3、NSString的strong和copy修饰的探究
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, copy)   NSString *secondName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self arrayUseCopyAndMutableCopy];
//    [self stringUseStrongOrCopy];
}

- (void)arrayUseCopyAndMutableCopy{
    
    //1、对NSArray分别使用`copy` & `mutableCopy`进行内存地址的对比
    NSArray *orgArr = @[@"ningjianwen", @"kongjiangmei"];
    NSArray *copyArr = [orgArr copy];
    NSMutableArray *mcopyArr = [orgArr mutableCopy];
    [mcopyArr addObject:@"jiangxianjin"];
    
    NSLog(@"NSArray 地址对比结果打印：");
    
    NSLog(@"orgArr 地址： %p", orgArr);
    NSLog(@"copyArr 地址： %p", copyArr);
    NSLog(@"mcopyArr 地址： %p", mcopyArr);
    
    /**
     2019-06-13 20:05:48.915949+0800 ArrayCopyAndMutableCopy[54942:3399095] NSArray 地址对比结果打印：
     2019-06-13 20:05:48.916073+0800 ArrayCopyAndMutableCopy[54942:3399095] orgArr 地址： 0x600003716bc0
     2019-06-13 20:05:48.916189+0800 ArrayCopyAndMutableCopy[54942:3399095] copyArr 地址： 0x600003716bc0
     2019-06-13 20:05:48.916266+0800 ArrayCopyAndMutableCopy[54942:3399095] mcopyArr 地址： 0x600003951b90
     */
    
    /**
     从打印结果可以看出**orgArr**与**copyArr**内存地址是一致的，说明`copy`对NSArray进行的是浅拷贝。
     **mcopyArr**与**orgArr**内存地址是不一致的，说明`mutableCopy`对NSArray进行的是深拷贝，且拷贝之后数组变成了一个可变数组。
     */
    
    //2、对NSMutableArray分别使用`copy` & `mutableCopy`进行内存地址的对比
    NSMutableArray *orgMArr = [NSMutableArray arrayWithObjects:@"星辰", @"江河",nil];
    NSArray *copyMArr = [orgMArr copy];
    NSMutableArray *mcopyMArr = [orgMArr mutableCopy];
    [mcopyMArr addObject:@"日月"];
    
    NSLog(@"NSMutableArray 地址对比结果打印：");
    
    NSLog(@"orgMArr 地址： %p", orgMArr);
    NSLog(@"copyMArr 地址： %p", copyMArr);
    NSLog(@"mcopyMArr 地址： %p", mcopyMArr);
    
    /**
     2019-06-13 20:05:48.916348+0800 ArrayCopyAndMutableCopy[54942:3399095] NSMutableArray 地址对比结果打印：
     2019-06-13 20:05:48.916418+0800 ArrayCopyAndMutableCopy[54942:3399095] orgMArr 地址： 0x600003951e90
     2019-06-13 20:05:48.916482+0800 ArrayCopyAndMutableCopy[54942:3399095] copyMArr 地址： 0x600003716ba0
     2019-06-13 20:05:48.916546+0800 ArrayCopyAndMutableCopy[54942:3399095] mcopyMArr 地址： 0x600003951da0
     */
    
    /**
     从打印结果可以看出**copyMArr**与**orgMArr**内存地址是不一致的，说明`copy`对NSMutableArray进行的是深拷贝，拷贝之后的新数组是一个不可变数组。
     **mcopyMArr**与**orgMArr**内存地址是不一致的，说明`mutableCopy`对NSMutableArray进行的是深拷贝，且拷贝之后是一个新的可变数组。
     */
}

- (void)stringUseStrongOrCopy{
    
    //1、对于不可变字符串探究
    NSString *orgStr = @"ning";
    self.firstName = orgStr;
    NSLog(@"first print: firstName = %@, orgStr = %@", self.firstName, orgStr);
    orgStr = @"kong";
    //update orgStr value, print self.firstName again
    NSLog(@"second print: firstName = %@, orgStr = %@", self.firstName,orgStr);
    
    NSString *orgSecondStr = @"jianwen";
    self.secondName = orgSecondStr;
    NSLog(@"first print: secondName = %@, orgSecondStr = %@", self.secondName, orgSecondStr);
    orgSecondStr = @"jiangmei";
    //update orgSecondStr value, print self.secondName again
    NSLog(@"second print: secondName = %@, orgSecondStr = %@", self.secondName, orgSecondStr);
    
    /**
     2019-06-13 19:49:07.604338+0800 ArrayCopyAndMutableCopy[54809:3391476] first print: firstName = ning, orgStr = ning
     2019-06-13 19:49:07.604479+0800 ArrayCopyAndMutableCopy[54809:3391476] second print: firstName = ning, orgStr = kong
     2019-06-13 19:49:07.604575+0800 ArrayCopyAndMutableCopy[54809:3391476] first print: secondName = jianwen, orgSecondStr = jianwen
     2019-06-13 19:49:07.604653+0800 ArrayCopyAndMutableCopy[54809:3391476] second print: secondName = jianwen, orgSecondStr = jiangmei
     */
    
    /**
     从打印结果可以看出，对于静态字符串，无论是使用`strong`还是`copy`修饰，字符串之间的修改的都是独立的，不会互相影响。
     */
    
    //2、对于可变字符串的探究
    NSMutableString *orgMStr = [NSMutableString stringWithFormat:@"宁"];
    self.firstName = orgMStr;
    NSLog(@"使用 strong 修饰，第一次打印 self.firstName = %@",self.firstName);
    [orgMStr appendFormat:@"建文"];
    NSLog(@"使用 strong 修饰，第二次打印 self.firstName = %@",self.firstName);
    
    NSMutableString *orgMStr2 = [NSMutableString stringWithFormat:@"孔"];
    self.secondName = orgMStr2;
    NSLog(@"使用 copy 修饰，第一次打印 self.secondName = %@",self.secondName);
    [orgMStr appendFormat:@"jiangmei"];
    NSLog(@"使用 copy 修饰，第二次打印 self.secondName = %@",self.secondName);
    
    /**
     2019-06-13 19:49:07.604758+0800 ArrayCopyAndMutableCopy[54809:3391476] 使用 strong 修饰，第一次打印 self.firstName = 宁
     2019-06-13 19:49:07.604857+0800 ArrayCopyAndMutableCopy[54809:3391476] 使用 strong 修饰，第二次打印 self.firstName = 宁建文
     2019-06-13 19:49:07.604953+0800 ArrayCopyAndMutableCopy[54809:3391476] 使用 copy 修饰，第一次打印 self.secondName = 孔
     2019-06-13 19:49:07.605043+0800 ArrayCopyAndMutableCopy[54809:3391476] 使用 copy 修饰，第二次打印 self.secondName = 孔
     */
    
    /**
     从打印的结果可以看出`strong`修饰的self.firstName两次的打印值是不一样的，第二次打印值和orgMstr是一样的，对orgMstr的修改，竟然影响了self.firstName的值，产生了我们不想要的结果（意外值串改）。这在开发中会导致预想不到的bug，排查困难。
     而使用`copy`修饰的self.secondName两次的打印值是一样的，就是说orgMStr和self.secondName的修改是独立的，不会互相影响，这才是开发真正需要的效果。
     
     总结：当字符串作为属性我们应该根据实际情况合理的选择修饰符（strong 或者 copy）。对于只是简单的字符串赋值的属性，我们使用strong和copy修饰，效果是一样的；
     但是对于涉及到可变字符串的修改赋值的属性，我们一定要使用copy进行修饰，这样才能保证代码的封装性，否则会产生值被意外修改的bug。对于不好区分的情况，为了保证代码的封装性，就全部使用copy进行修饰吧。
     */
}

@end
