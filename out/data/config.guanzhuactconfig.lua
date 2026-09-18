

local __rs={
[1]="1.截图保存二维码\n2.打开微信扫一扫\n3.点击关注公众号\n4.领取关注礼包",
[2]="1.打开微信搜索公众号<color=\'#ca631d\'>“最强祖师”</color>\n2.按照提示完成订阅关注\n3.返回游戏即可领取奖励",
[3]="关注<color=\"#c82c2c\">微信公众号</color>即可领取好礼",
[4]="前往微信",
[5]="关注<color=\"#c82c2c\">微博</color>即可领取好礼",
[6]="前往微博",
[7]="按讃追蹤<color=\"#c82c2c\">官方FB粉絲專頁</color>即可領取好禮",
[8]="前往FB",
[9]="加入<color=\"#c82c2c\">官方FB社團</color>即可領取好禮",
[10]="Theo dõi trang chủ FB nhận ngay ",
[11]="Đi theo dõi",
[12]="Tham gia nhóm FB nhận ngay ",
[13]="Đi gia nhập",
}
local __r_1={
"ui/windows/welfare/sharedtextures/image_gzqrcode.ab",
"image_gzqrcode"
}
local __r_2={
"ui/windows/welfare/welfare_guanzhuact_atlas_pak.ab",
"image_meitiguanzhu_1"
}
local __r_3={
{
1,
__rs[3],
16,
1,
__rs[4]
},
{
2,
__rs[5],
18,
"https://weibo.com/u/7796806181",
__rs[6]
}
}
local ___noname___=
{
{
bgspineid=4101,
id=1,
qrcode=__r_1,
slogan=__r_2,
tasks=__r_3,
wxdesc1=__rs[1],
wxdesc2=__rs[2]
},
{
bgspineid=4101,
id=2,
qrcode=__r_1,
slogan={
"ui/windows/welfare/welfare_guanzhuact_atlas_pak.ab",
"image_guanzhuzuiqiangzushimsz_1"
},
tasks={
{
3,
__rs[7],
16,
"https://www.facebook.com/profile.php?id=61568205099095",
__rs[8]
},
{
4,
__rs[9],
18,
"https://www.facebook.com/groups/4077358295883895",
__rs[8]
}
},
wxdesc1=__rs[1],
wxdesc2=__rs[2]
},
{
bgspineid=4101,
id=3,
qrcode=__r_1,
slogan=__r_2,
tasks={
{
5,
__rs[10],
16,
"https://www.facebook.com/tutien.vsgame.vn/",
__rs[11]
},
{
6,
__rs[12],
18,
"https://www.facebook.com/groups/746592238143004/",
__rs[13]
}
},
wxdesc1=__rs[1],
wxdesc2=__rs[2]
},
{
bgspineid=4101,
id=4,
qrcode=__r_1,
slogan=__r_2,
tasks=__r_3,
wxdesc1=__rs[1],
wxdesc2=__rs[2]
}
}

return ___noname___
