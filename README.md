# NIMOnlyRTC
### 云信独立音视频demo介绍
* 使用云信官方demo appkey，所以如果需要注册账号的话可以直接先通过云信官方的webdemo进行账号注册，然后在登录demo。[云信线上注册页面](https://app.netease.im/webdemo/im/register.html)
* 由于云信demo的token 使用的md5加密，所以我也做了一个md5对token加密，不过做了appkey判断，只有在使用云信appkey的情况下会进行加密
* 这个demo十分简陋，制作了基础的一对一呼叫，用户展示基础接口如何调用，一些特殊的功能后面再说吧。