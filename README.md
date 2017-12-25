# NIMOnlyRTC
### 云信独立音视频demo介绍
* 使用云信官方demo appkey，所以如果需要注册账号的话可以直接先通过云信官方的webdemo进行账号注册，然后在登录demo。[云信线上注册页面](https://app.netease.im/webdemo/im/register.html)
* 由于云信demo的token 使用的md5加密，所以我也做了一个md5对token加密，不过做了appkey判断，只有在使用云信appkey的情况下会进行加密
* 这个demo十分简陋，制作了基础的一对一呼叫，用户展示基础接口如何调用，一些特殊的功能后面再说吧。

### 注意事项
* demo中使用了云信基于哔哩哔哩开源`ikj`框架修改后的 `NTESGLView` ，如果你这边没有很好的YUV渲染，建议使用跟我项目相同的View文件夹：
  + 将文件夹拷贝到项目目录中，建议不要直接拖拽
  + 在Xcode项目目录中右键选择`add files` 将对应的View文件夹添加到你的项目中。
  + 在Xcode中的`Build Settings`中，找到`Header Search Paths`这一栏，将对应的View文件夹路径（或者是你的ijk项目父路径）加入到对应的栏目中，可参考我demo的写法。
  + 如果你使用的PCH作为你项目头文件的加载方式，那么由于`ijk`是C语言框架，所以需要在你的PCH文件中增加`#ifdef __OBJC__`来避免直接预编译C语言库。
  ```
  #ifdef __OBJC__
   #import <UIKit/UIKit.h>
  #endif
  ```
