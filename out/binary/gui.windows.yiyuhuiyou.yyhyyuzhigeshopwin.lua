







def_class("YYHYyuzhigeShopWin",UIWindowBase)









function YYHYyuzhigeShopWin:bindComponents()

self.bottomPanel=UIObject.get(self,0)
self.middlePanel=UIObject.get(self,1)
self.topPanel=UIObject.get(self,2)
self.topUIPanel=UIObject.get(self,3)
self.speakObj=UIObject.get(self,4)
self.npcModel=UIObject.get(self,5)
self.goodsScrollview=UIObject.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.title=UIText.get(self,8)
self.moneyRoot=UIButton.get(self,9)
self.menuList=UIObject.get(self,10)
self.timeText=UIText.get(self,11)
self.mutiaoScroller=UIObject.get(self,12)
self.moneyIcon=UIObject.get(self,13)
self.moneyText=UIText.get(self,14)
self.speakText=UIText.get(self,15)
self.yujupanel=UIObject.get(self,16)
self.yujutext1=UIText.get(self,17)
self.yujugan=UIButton.get(self,18)
self.yujuxian=UIButton.get(self,19)
self.yujugou=UIButton.get(self,20)
self.manji=UIObject.get(self,21)
self.yujuimg=UIImage.get(self,22)
self.yujuname=UIText.get(self,23)
self.yujushuxing=UIText.get(self,24)
self.yujumiaoshu=UIText.get(self,25)
self.yujusx=UIText.get(self,26)
self.yujums=UIText.get(self,27)
self.weimanji=UIObject.get(self,28)
self.oldimg=UIImage.get(self,29)
self.oldname=UIText.get(self,30)
self.oldsxtext=UIText.get(self,31)
self.oldxgtext=UIText.get(self,32)
self.newimg=UIImage.get(self,33)
self.newname=UIText.get(self,34)
self.newsxtext=UIText.get(self,35)
self.newxgtext=UIText.get(self,36)
self.shuxing=UIText.get(self,37)
self.xiaoguo=UIText.get(self,38)
self.shengjitext=UIText.get(self,39)
self.sjimg=UIObject.get(self,40)
self.btnshengji=UIButton.get(self,41)
self.sjzimg=UIObject.get(self,42)
self.bgygan=UIObject.get(self,43)
self.bgyx=UIObject.get(self,44)
self.bgyg=UIObject.get(self,45)
self.newnexttext=UIText.get(self,46)
self.moneynum=UIText.get(self,47)
self.btntext=UIText.get(self,48)
self.mjimg=UIObject.get(self,49)
self.moneyicons=UIObject.get(self,50)
self.moneynums=UIText.get(self,51)
self.gdtexiao=UIObject.get(self,52)
self.yganreddot=UIObject.get(self,53)
self.yxianreddot=UIObject.get(self,54)
self.ygoureddot=UIObject.get(self,55)
self.xiangxibtn=UIButton.get(self,56)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.moneyRoot:setButtonClick(function()self:onMoneyRoot()end)

self.yujugan:setButtonClick(function()self:onYujugan()end)

self.yujuxian:setButtonClick(function()self:onYujuxian()end)

self.yujugou:setButtonClick(function()self:onYujugou()end)

self.btnshengji:setButtonClick(function()self:onBtnshengji()end)

self.xiangxibtn:setButtonClick(function()self:onXiangxibtn()end)



end


function YYHYyuzhigeShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.middlePanel);self.middlePanel=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.topUIPanel);self.topUIPanel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.yujupanel);self.yujupanel=nil;
_UIObject_release(self.yujutext1);self.yujutext1=nil;
_UIObject_release(self.yujugan);self.yujugan=nil;
_UIObject_release(self.yujuxian);self.yujuxian=nil;
_UIObject_release(self.yujugou);self.yujugou=nil;
_UIObject_release(self.manji);self.manji=nil;
_UIObject_release(self.yujuimg);self.yujuimg=nil;
_UIObject_release(self.yujuname);self.yujuname=nil;
_UIObject_release(self.yujushuxing);self.yujushuxing=nil;
_UIObject_release(self.yujumiaoshu);self.yujumiaoshu=nil;
_UIObject_release(self.yujusx);self.yujusx=nil;
_UIObject_release(self.yujums);self.yujums=nil;
_UIObject_release(self.weimanji);self.weimanji=nil;
_UIObject_release(self.oldimg);self.oldimg=nil;
_UIObject_release(self.oldname);self.oldname=nil;
_UIObject_release(self.oldsxtext);self.oldsxtext=nil;
_UIObject_release(self.oldxgtext);self.oldxgtext=nil;
_UIObject_release(self.newimg);self.newimg=nil;
_UIObject_release(self.newname);self.newname=nil;
_UIObject_release(self.newsxtext);self.newsxtext=nil;
_UIObject_release(self.newxgtext);self.newxgtext=nil;
_UIObject_release(self.shuxing);self.shuxing=nil;
_UIObject_release(self.xiaoguo);self.xiaoguo=nil;
_UIObject_release(self.shengjitext);self.shengjitext=nil;
_UIObject_release(self.sjimg);self.sjimg=nil;
_UIObject_release(self.btnshengji);self.btnshengji=nil;
_UIObject_release(self.sjzimg);self.sjzimg=nil;
_UIObject_release(self.bgygan);self.bgygan=nil;
_UIObject_release(self.bgyx);self.bgyx=nil;
_UIObject_release(self.bgyg);self.bgyg=nil;
_UIObject_release(self.newnexttext);self.newnexttext=nil;
_UIObject_release(self.moneynum);self.moneynum=nil;
_UIObject_release(self.btntext);self.btntext=nil;
_UIObject_release(self.mjimg);self.mjimg=nil;
_UIObject_release(self.moneyicons);self.moneyicons=nil;
_UIObject_release(self.moneynums);self.moneynums=nil;
_UIObject_release(self.gdtexiao);self.gdtexiao=nil;
_UIObject_release(self.yganreddot);self.yganreddot=nil;
_UIObject_release(self.yxianreddot);self.yxianreddot=nil;
_UIObject_release(self.ygoureddot);self.ygoureddot=nil;
_UIObject_release(self.xiangxibtn);self.xiangxibtn=nil;
end

















local _this
local fishcolors=
{
[1]='小型',
[2]='中型',
[3]='大型',
[4]='异种',
[5]='灵物',
}
local abname_yyhy='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'


function YYHYyuzhigeShopWin:onLoaded(...)
self:bindComponents()
_this=self
self.goodsScrollview:setChildScrollViewInit(0.5,true,self.clickGood,nil)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function YYHYyuzhigeShopWin:__delete()
_this=nil
self:stopTimerByName('flushtimer')
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end




function YYHYyuzhigeShopWin:onShow(argtable,afterOnloaded)






















_this.yujupanel:setActive(true)
_this.goodsScrollview:setActive(false)
_this.topUIPanel:setActive(false)


YYHYyuzhigeShopWin:refreshYuJuShengji(nil)

self:refreshTime()
local func=function(...)
self:refreshTime()
end
self.flushtimer=self:setTimer(1,0,func)



end

function YYHYyuzhigeShopWin:texiaobofang()
_this.gdtexiao:setChildShowEffect(10060,true)
end

function YYHYyuzhigeShopWin:doOpenAnim()
self.middlePanel:setChildCanvasGroupAlpha(0)
self.topUIPanel:setChildCanvasGroupAlpha(0)
self.bottomPanel:setLocalPosY(-750)
self.topPanel:setLocalPosY(-750)
self.bottomPanel:setChildDOLocalMoveY(0,0.35,nil)
self.topPanel:setChildDOLocalMoveY(0,0.35,nil)
self:delayDo(0.15,function()
self.bottomPanel:setChildDOScale(1.1,0.2,function()
if _this==nil then return end
_this.bottomPanel:setChildDOScale(1,0.1,nil)
end)
self.topPanel:setChildDOScale(1.1,0.2,function()
if _this==nil then return end
_this.topPanel:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this:onOpenAnimFinish()
end)
end)
end)
end

function YYHYyuzhigeShopWin:onOpenAnimFinish()
self.middlePanel:setChildCanvasGroupDOFade(1,0.3)
self.topUIPanel:setChildCanvasGroupDOFade(1,0.3)
self:delayDo(0.3,function()

end)
local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
local delay1=0
local count=0
for i=1,grids.Count do
local item=grids[i-1]
item:SetChildCanvasGroupAlpha(-1,0)
if delay1>0 then
self:delayDo(delay1,function()
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end)
else
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end
count=count+1
if count>=3 then
count=0
delay1=delay1+0.1
end
end
local grids2=self.mutiaoScroller:getChildScrollViewItemWidgets()
local delay2=0
for i=1,grids2.Count do
local item=grids2[i-1]
item:SetChildCanvasGroupAlpha(-1,0)
if delay2>0 then
self:delayDo(delay2,function()
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end)
else
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end
delay2=delay2+0.1
end
end


function YYHYyuzhigeShopWin:onHide()

end

function YYHYyuzhigeShopWin:refreshTime()
local index=timeHelper.getWeakDateEx()
local remainTime=timeHelper.getServerTodayLeft2()
local endTime=0
if index>0 then
endTime=(7-index)*86400+remainTime
else
endTime=remainTime
end
self.timeText:setText(FMT.fmt('补货倒计时：{0}',timeHelper.format_time_stamp3(endTime)))
if endTime<=0 then

funcShopController.send_23_1(_this.shopId)
end
end

function YYHYyuzhigeShopWin:initMenu()

local pageList={{1,"icon_bbtabdaoju_1"},{2,"icon_tytabgubao_1"}}
local c=#pageList
self.menuList:setChildLayoutGroupCreateItems(c)
local gridlist=self.menuList:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
local pageTab=pageList[i]
item:SetChildCSImageSprite(0,globalABLookup.global,pageTab[2])
item:SetChildButtonClickWithID(0,self.clickMenu,pageTab[1])
end
self.clickMenu(1)
end


function YYHYyuzhigeShopWin.clickMenu(index)
if _this.selectPageId==index then return end
if _this.selectPageId then
local lastItem=_this.menuList:getChildLayoutGroupGridItem(_this.selectPageId-1)
lastItem:SetChildActive(1,false)
end
_this.selectPageId=index
local item=_this.menuList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(1,true)


_this.goodDatas=_this.shopDatas

if index==1 then
_this:refreshGoods()
_this.yujupanel:setActive(false)
_this.goodsScrollview:setActive(true)
elseif index==2 then


_this.yujupanel:setActive(true)
_this.goodsScrollview:setActive(false)
YYHYyuzhigeShopWin:refreshYuJuShengji(nil)
end
end


function YYHYyuzhigeShopWin:onYujugan()
if _this.selectyuju==1 then
return
end
_this.selectyuju=1
YYHYyuzhigeShopWin:refreshYuJuShengjiPanel(1)
end
function YYHYyuzhigeShopWin:onYujuxian()
if _this.selectyuju==3 then
return
end
_this.selectyuju=3
YYHYyuzhigeShopWin:refreshYuJuShengjiPanel(3)
end
function YYHYyuzhigeShopWin:onYujugou()
if _this.selectyuju==2 then
return
end
_this.selectyuju=2
YYHYyuzhigeShopWin:refreshYuJuShengjiPanel(2)
end


function YYHYyuzhigeShopWin:refreshchoose(index)
if index==1 then
_this.bgygan:setActive(true)
_this.bgyx:setActive(false)
_this.bgyg:setActive(false)
elseif index==2 then
_this.bgygan:setActive(false)
_this.bgyx:setActive(false)
_this.bgyg:setActive(true)
elseif index==3 then
_this.bgygan:setActive(false)
_this.bgyx:setActive(true)
_this.bgyg:setActive(false)
end
end


function YYHYyuzhigeShopWin:refreshShengjiyugan()
local red=YiYuHuiYouController:yyhyShopShengjiyujuReddot(1)
_this.yganreddot:setActive(red)
end


function YYHYyuzhigeShopWin:refreshShengjiyugou()
local red=YiYuHuiYouController:yyhyShopShengjiyujuReddot(2)
_this.ygoureddot:setActive(red)
end


function YYHYyuzhigeShopWin:refreshShengjiyuxian()
local red=YiYuHuiYouController:yyhyShopShengjiyujuReddot(3)
_this.yxianreddot:setActive(red)
end



function YYHYyuzhigeShopWin:refreshYuJuShengji(yuju_idx)










local severdata_yugan=YiYuHuiYouModel:getYgLevel()
if not severdata_yugan then

YiYuHuiYouController.send_248_51()
end

_this.selectyuju=yuju_idx or 1
YYHYyuzhigeShopWin:refreshYuJuShengjiPanel(_this.selectyuju)
YYHYyuzhigeShopWin:refreshchoose(_this.selectyuju)
local yuganlevel=YiYuHuiYouModel:getYgLevel()or 1
local yuxianlevel=YiYuHuiYouModel:getYxLevel()or 1
local yugoulevel=YiYuHuiYouModel:getYwLevel()or 1
local yugan_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugan)[yuganlevel]
local yugou_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugou)[yugoulevel]
local yuxian_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yuxian)[yuxianlevel]

_this.winlua:SetChildCSImageSprite(_this.yujugan:getID(),abname_yyhy,FMT.fmt('yyhy_yugan_shop_{0}',yugan_cfg.yujuImg))
_this.winlua:SetChildCSImageSprite(_this.yujuxian:getID(),abname_yyhy,FMT.fmt('yyhy_yugxian_shop_{0}',yuxian_cfg.yujuImg))
_this.winlua:SetChildCSImageSprite(_this.yujugou:getID(),abname_yyhy,FMT.fmt('yyhy_yugou_shop_{0}',yugou_cfg.yujuImg))

YYHYyuzhigeShopWin:refreshShengjiyugan()
YYHYyuzhigeShopWin:refreshShengjiyugou()
YYHYyuzhigeShopWin:refreshShengjiyuxian()
end


function YYHYyuzhigeShopWin:refreshYuJuSJPanel(index,level)
local cfg=cfg_yiyuhuiyouyujuconfig_get(index)[level]
local cfg2=cfg_yiyuhuiyouyujuconfig_get(index)[level+1]
_this.oldname:setText(cfg.yj_name)

if index==1 then
_this.oldsxtext:setText(FMT.fmt('效果：{0}',cfg.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.oldimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugan_shop_{0}',cfg.yujuImg))
elseif index==2 then
_this.oldsxtext:setText(FMT.fmt('效果：{0}',cfg.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.oldimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugou_shop_{0}',cfg.yujuImg))
elseif index==3 then
_this.oldsxtext:setText(FMT.fmt('效果：{0}',cfg.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.oldimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugxian_shop_{0}',cfg.yujuImg))
end
local str='无'
if cfg.strarry then
str=cfg.strarry[1][3]
end
_this.oldxgtext:setText(FMT.fmt('渔技：{0}',str))

if cfg2 then
_this.newname:setText(cfg2.yj_name)
if index==1 then
_this.newsxtext:setText(FMT.fmt('效果：{0}',cfg2.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.newimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugan_shop_{0}',cfg2.yujuImg))
elseif index==2 then
_this.newsxtext:setText(FMT.fmt('效果：{0}',cfg2.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.newimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugou_shop_{0}',cfg2.yujuImg))
elseif index==3 then
_this.newsxtext:setText(FMT.fmt('效果：{0}',cfg2.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.newimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugxian_shop_{0}',cfg2.yujuImg))
end
local str='无'
if cfg2.strarry then
str=cfg2.strarry[1][3]
end
_this.newxgtext:setText(FMT.fmt('渔技：<color=#CA631D>{0}</color>',str))
end

local up_level=cfg.up_level
local up_cost=cfg.up_cost[1]
local enough=moneyModel.checkEnoughMoney(up_cost[1],up_cost[2])
local name=itemsConfig.getItemName(up_cost[1])
local moneystr=""
if enough then
moneystr=FMT.fmt('<color=#000000>{0}</color>',up_cost[2])
else
moneystr=FMT.fmt('<color=#c82c2c>{0}</color>',up_cost[2])
end
_this.moneynum:setText(moneystr)


local up_cost2=cfg.up_cost[2]
local enough2=moneyModel.checkEnoughMoney(up_cost2[1],up_cost2[2])
local iconName=iconHelper.getIconName(up_cost2[1])
_this.moneyicons:setChildIcon(iconName,false)
local moneystr2=""
local up_cost2num=mathHelper.formatNumber2(up_cost2[2])
if enough2 then
moneystr2=FMT.fmt('<color=#000000>{0}</color>',up_cost2num)
else
moneystr2=FMT.fmt('<color=#c82c2c>{0}</color>',up_cost2num)
end
_this.moneynums:setText(moneystr2)

if up_level then
_this.shengjitext:setActive(true)

local yuhuolist=YiYuHuiYouModel:getPinZhiFishlist()
if yuhuolist[up_level[1]]>=up_level[2]and enough and enough2 then
_this.shengjitext:setText(FMT.fmt("<color=#549327>升级条件: 捕获{0}条{1}鱼({2}/{3})</color>",up_level[2],fishcolors[up_level[1]],math.min(yuhuolist[up_level[1]],up_level[2]),up_level[2]))
_this.sjzimg:setActive(true)
_this.winlua:SetChildImageExGray(_this.btnshengji:getID(),false)
_this.btntext:setText('升级')
else
_this.shengjitext:setText(FMT.fmt("<color=#686868>升级条件: 捕获{0}条{1}鱼({2}/{3})</color>",up_level[2],fishcolors[up_level[1]],math.min(yuhuolist[up_level[1]],up_level[2]),up_level[2]))
_this.sjzimg:setActive(false)

_this.btntext:setText('条件未满足')
end
else
_this.shengjitext:setActive(false)
end

end

function YYHYyuzhigeShopWin:refreshYuJuManJiPanel(index,level)
local cfg=cfg_yiyuhuiyouyujuconfig_get(index)[level]
_this.yujuname:setText(cfg.yj_name)
if index==1 then
_this.yujushuxing:setText(FMT.fmt('效果：{0}',cfg.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.yujuimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugan_shop_{0}',cfg.yujuImg))
elseif index==2 then
_this.yujushuxing:setText(FMT.fmt('效果：{0}',cfg.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.yujuimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugou_shop_{0}',cfg.yujuImg))
elseif index==3 then
_this.yujushuxing:setText(FMT.fmt('效果：{0}',cfg.yj_xiaoguo or'无'))
_this.winlua:SetChildCSImageSprite(_this.yujuimg:getID(),abname_yyhy,FMT.fmt('yyhy_yugxian_shop_{0}',cfg.yujuImg))
end
local str='无'
if cfg.strarry then
str=cfg.strarry[1][3]
end
_this.yujumiaoshu:setText(FMT.fmt('渔技：{0}',str))
end


function YYHYyuzhigeShopWin:refreshYuJuShengjiPanel(index)
YYHYyuzhigeShopWin:refreshchoose(index)
local cfg=cfg_yiyuhuiyoubaseconfig_get(1).yuju_maxlevel
local level
if index==1 then
level=YiYuHuiYouModel:getYgLevel()or 1
if level<cfg[index]then
_this.weimanji:setActive(true)
_this.manji:setActive(false)
_this.btnshengji:setActive(true)
YYHYyuzhigeShopWin:refreshYuJuSJPanel(index,level)
else
_this.weimanji:setActive(false)
_this.manji:setActive(true)
_this.btnshengji:setActive(false)
YYHYyuzhigeShopWin:refreshYuJuManJiPanel(index,level)
end
elseif index==2 then
level=YiYuHuiYouModel:getYwLevel()or 1
if level<cfg[index]then
_this.weimanji:setActive(true)
_this.manji:setActive(false)
_this.btnshengji:setActive(true)
YYHYyuzhigeShopWin:refreshYuJuSJPanel(index,level)
else
_this.weimanji:setActive(false)
_this.manji:setActive(true)
_this.btnshengji:setActive(false)
YYHYyuzhigeShopWin:refreshYuJuManJiPanel(index,level)
end
elseif index==3 then
level=YiYuHuiYouModel:getYxLevel()or 1
if level<cfg[index]then
_this.weimanji:setActive(true)
_this.manji:setActive(false)
_this.btnshengji:setActive(true)
YYHYyuzhigeShopWin:refreshYuJuSJPanel(index,level)
else
_this.weimanji:setActive(false)
_this.manji:setActive(true)
_this.btnshengji:setActive(false)
YYHYyuzhigeShopWin:refreshYuJuManJiPanel(index,level)
end
end


local yuganlevel=YiYuHuiYouModel:getYgLevel()or 1
local yuxianlevel=YiYuHuiYouModel:getYxLevel()or 1
local yugoulevel=YiYuHuiYouModel:getYwLevel()or 1
local yugan_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugan)[yuganlevel]
local yugou_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugou)[yugoulevel]
local yuxian_cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yuxian)[yuxianlevel]
_this.winlua:SetChildCSImageSprite(_this.yujugan:getID(),abname_yyhy,FMT.fmt('yyhy_yugan_shop_{0}',yugan_cfg.yujuImg))
_this.winlua:SetChildCSImageSprite(_this.yujuxian:getID(),abname_yyhy,FMT.fmt('yyhy_yugxian_shop_{0}',yugou_cfg.yujuImg))
_this.winlua:SetChildCSImageSprite(_this.yujugou:getID(),abname_yyhy,FMT.fmt('yyhy_yugou_shop_{0}',yugou_cfg.yujuImg))

YYHYyuzhigeShopWin:refreshShengjiyugan()
YYHYyuzhigeShopWin:refreshShengjiyugou()
YYHYyuzhigeShopWin:refreshShengjiyuxian()
end



function YYHYyuzhigeShopWin:refreshGoods()
local goodsCount=#self.goodDatas
self.goodsScrollview:setChildScrollViewCreateGrids(goodsCount,3)
self.mutiaoScroller:setChildScrollViewCreateGrids(math.ceil(goodsCount/3),1)
local grids=self.goodsScrollview:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]

local data=self.goodDatas[i]

local itemid=data.cfg.itemId

local sellout=YiYuHuiYouModel:checkGoodSellOut(_this.shopId,data)
item:SetChildActive(3,sellout)
local alpha=sellout and 0.7 or 1
item:SetChildDoBrightness(-1,alpha,0,nil)
local limitStr=self:getLimitStr(data,itemid)
item:SetChildText(5,limitStr)


local attach

local cost=data.cfg.money
if cost then
local useItemid=cost[1]
local needCount=cost[2]
attach={shopCostArgs={costItemId=useItemid,costNum=needCount}}
local iconName=iconHelper.getIconName(useItemid)
item:SetChildIcon(2,iconName,false)
item:SetChildText(1,needCount)
end


local getCount=data.cfg.itemNum
local conf={itemid=itemid,itemcount=getCount,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(itemid_,index_,itemguid_)
self:onClickBaseItem(itemid_,index_,itemguid_,attach)
end)


local special=data.xiyouFlag
item:SetChildActive(6,special==1)
end
end


function YYHYyuzhigeShopWin:getLimitStr(data,itemid)


local zhouLimit=data.cfg.buyLimit[1][2]
local zsLimit=data.cfg.buyLimit[1][2]

local shopData=funcShopModel:get_data(_this.shopId,data.cfg.id)
local limitStr=''
if zhouLimit then
local weekNum=zhouLimit
if shopData then
weekNum=zhouLimit-shopData.buyNum
end
limitStr=FMT.fmt('每周限购：{0}',weekNum)
elseif zsLimit then
local zsNum=zsLimit
if shopData then
zsNum=zsLimit-shopData.buyNum
end
limitStr=FMT.fmt('限购：{0}',zsNum)
end
return limitStr
end


function YYHYyuzhigeShopWin:refreshGoodItemByItemid(itemid)
local index
local data
for i,v in ipairs(self.goodDatas)do
local cfg=v[1]
if cfg.id==itemid then
index=i
data=cfg
break
end
end
local item=self.goodsScrollview:getChildScrollViewItemWidget(index-1)
local sellout=xianzhanModel:checkGoodSellOut(itemid)
item:SetChildActive(3,sellout)
local alpha=sellout and 0.7 or 1
item:SetChildDoBrightness(-1,alpha,0,nil)
local getCount=data.buyNum
item:SetChildItemData(0,PropIndex(DataPropKey.eWidgetText,3),getCount)
local limitStr=self:getLimitStr(data,itemid)
item:SetChildText(5,limitStr)
end


function YYHYyuzhigeShopWin.clickGood(clickCount,index)

local data=_this.goodDatas[index+1]

local shopid=data.cfg.itemId



local sellout=YiYuHuiYouModel:checkGoodSellOut(_this.shopId,data)
if sellout then
UIManager.error('该商品已售罄')
return
end


local cost=data.cfg.money
local itemid=cost[1]
local unitPrice=cost[2]
local max=YiYuHuiYouModel:checkGoodSellNumMax(_this.shopId,data)
local maxprice=max*unitPrice
local has=itemsModel.getCount(itemid)
local buymax
if has>=maxprice then
buymax=max
else
buymax=math.floor(has/unitPrice)
end
if buymax<=0 then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(itemid)))
gainControl:showGainWin(itemid)
return
end
local showdata=
{
type='UIUseItemDialouge',
title='提示',
itemId=itemid,
unitPrice=unitPrice,
max=buymax,
oktext='购买',
canceltext='取消',
okcallback=function(selectCnt)
if _this==nil then return end
local num=selectCnt*unitPrice
if not moneyModel.checkEnoughMoney(itemid,num)then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(itemid)))
gainControl:showGainWin(itemid)
return
end

funcShopController.send_23_2(_this.shopId,data.cfg.id,selectCnt)
_this.comfirmDialog:deleteSelf()
end,
showclosebtn=true,
}
_this.comfirmDialog=UIDialogManager.newDialog(showdata)
_this.comfirmDialog:show()
end


function YYHYyuzhigeShopWin:onClickBaseItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end


function YYHYyuzhigeShopWin:refreshMoneyRoot()
local iconName=iconHelper.getIconName(eMoneyType.mtYuBi)
self.moneyIcon:setChildIcon(iconName,false)
self.moneyText:setText(moneyModel.getMoney(eMoneyType.mtYuBi))

end

function YYHYyuzhigeShopWin:doSpeaking(speakType)
local speakList=self.speakContent
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end

function YYHYyuzhigeShopWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end


function YYHYyuzhigeShopWin:onCloseBtn()
self:closeSelf()
end

function YYHYyuzhigeShopWin:onMoneyRoot()
local moneyType=eMoneyType.mtYuBi
gainControl:showGainWin(moneyType)
end

function YYHYyuzhigeShopWin:onNPCClick()

end


function YYHYyuzhigeShopWin.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtYuBi then
_this:refreshMoneyRoot()
end
end


function YYHYyuzhigeShopWin:onBtnshengji()

if _this.selectyuju then
local level=1
if _this.selectyuju==1 then
level=YiYuHuiYouModel:getYgLevel()
elseif _this.selectyuju==2 then
level=YiYuHuiYouModel:getYwLevel()
elseif _this.selectyuju==3 then
level=YiYuHuiYouModel:getYxLevel()
end
local cfg=cfg_yiyuhuiyouyujuconfig_get(_this.selectyuju)[level]
local up_level=cfg.up_level
local up_cost=cfg.up_cost[1]
local enough=moneyModel.checkEnoughMoney(up_cost[1],up_cost[2])


local up_cost2=cfg.up_cost[2]
local enough2=moneyModel.checkEnoughMoney(up_cost2[1],up_cost2[2])


if up_level then
local yuhuolist=YiYuHuiYouModel:getPinZhiFishlist()
if enough and enough2 then
if yuhuolist[up_level[1]]>=up_level[2]then

YiYuHuiYouController.send_248_59(_this.selectyuju)
else
return

end
else
if enough then
if not enough2 then
gainControl:showGainWin(up_cost2[1])
end
else
gainControl:showGainWin(up_cost[1])
end
return

end
end

end
end


function YYHYyuzhigeShopWin:onXiangxibtn()
UIManager:showWindow('UIDiscipleyujuTipsWin',{_this.selectyuju or 1})
end
