







def_class("UIWXAddRewardWin",UIWindowBase)









function UIWXAddRewardWin:bindComponents()

self.btnScrollView=UIObject.get(self,0)
self.countIcon=UIObject.get(self,1)
self.dayCount=UIText.get(self,2)
self.fbg=UIObject.get(self,3)
self.freeReward=UIButton.get(self,4)
self.freeRewardReddot=UIObject.get(self,5)
self.gridContent=UIObject.get(self,6)
self.gridItem_1=UIObject.get(self,7)
self.gridItem_2=UIObject.get(self,8)
self.gridItem_3=UIObject.get(self,9)
self.gridScrollView=UIObject.get(self,10)
self.itemContent=UIObject.get(self,11)
self.ItemScrollView=UIObject.get(self,12)
self.normalBG=UIObject.get(self,13)
self.normalPanel=UIObject.get(self,14)
self.rewarditem_1=UIObject.get(self,15)
self.rewarditem_2=UIObject.get(self,16)
self.rewarditem_3=UIObject.get(self,17)
self.rewarditem_4=UIObject.get(self,18)
self.rewardRoot1=UIObject.get(self,19)
self.rewardRoot2=UIObject.get(self,20)
self.rewardRoot3=UIObject.get(self,21)
self.Root=UIObject.get(self,22)
self.signInBG=UIObject.get(self,23)
self.signInPanel=UIObject.get(self,24)
self.speakObj=UIObject.get(self,25)
self.speakText=UIText.get(self,26)
self.verContent=UIObject.get(self,27)
self.verScrollView=UIObject.get(self,28)

self.freeReward:setButtonClick(function()self:onFreeReward()end)
self.gridItem={
self.gridItem_1,
self.gridItem_2,
self.gridItem_3,
}
self.rewarditem={
self.rewarditem_1,
self.rewarditem_2,
self.rewarditem_3,
self.rewarditem_4,
}



end


function UIWXAddRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnScrollView);self.btnScrollView=nil;
_UIObject_release(self.countIcon);self.countIcon=nil;
_UIObject_release(self.dayCount);self.dayCount=nil;
_UIObject_release(self.fbg);self.fbg=nil;
_UIObject_release(self.freeReward);self.freeReward=nil;
_UIObject_release(self.freeRewardReddot);self.freeRewardReddot=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
_UIObject_release(self.gridItem_1);self.gridItem_1=nil;
_UIObject_release(self.gridItem_2);self.gridItem_2=nil;
_UIObject_release(self.gridItem_3);self.gridItem_3=nil;
_UIObject_release(self.gridScrollView);self.gridScrollView=nil;
_UIObject_release(self.itemContent);self.itemContent=nil;
_UIObject_release(self.ItemScrollView);self.ItemScrollView=nil;
_UIObject_release(self.normalBG);self.normalBG=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.rewarditem_1);self.rewarditem_1=nil;
_UIObject_release(self.rewarditem_2);self.rewarditem_2=nil;
_UIObject_release(self.rewarditem_3);self.rewarditem_3=nil;
_UIObject_release(self.rewarditem_4);self.rewarditem_4=nil;
_UIObject_release(self.rewardRoot1);self.rewardRoot1=nil;
_UIObject_release(self.rewardRoot2);self.rewardRoot2=nil;
_UIObject_release(self.rewardRoot3);self.rewardRoot3=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.signInBG);self.signInBG=nil;
_UIObject_release(self.signInPanel);self.signInPanel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.verContent);self.verContent=nil;
_UIObject_release(self.verScrollView);self.verScrollView=nil;
self.gridItem=nil;
self.rewarditem=nil;
end


















local verItemCmp=
{
verItem=0,
bg=1,
desc=2,
select=3,
reddot=4,
click=5,
}

local gridItemCmp=
{
gridItem=0,
bg=1,
contenImage=2,
}

local listItemCmp=
{
gridItem=0,
contenImage=1,
desc=2,
desc2=3,
click=4,
}

local ItemCmp=
{
UINormalRewardItem=0,
select=1,
recvmask=2,
}

local abName="ui/windows/welfare/welfare_wxaddreward_atlas_pak.ab"

local _this


function UIWXAddRewardWin:onLoaded(...)
self:bindComponents()

_this=self

self.rewardRoot={
self.rewardRoot1,
self.rewardRoot2,
self.rewardRoot3,
}

self.btnScrollView:setChildScrollViewInit(0.5,true,function(num,index)self:onVerItemClick(index)end,nil)

self.isRunDouYin=webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()
self.isRunHuaWei=webGLHelper:isRunHuaWeiMiniGame()
self.isRunAlipay=webGLHelper:isRunAlipayMiniGame()
self.isRunKuaiShou=webGLHelper:isRunKuaiShouMiniGame()
self.isRunBzhan=webGLHelper:isRunBzhan()
self.config=welfareController:getAddRewardConfig()
end


function UIWXAddRewardWin:__delete()
self:unbindComponents()

_this=nil
end

function UIWXAddRewardWin:testBzhan()
self.isRunBzhan=true
self.config=cfg_bzhanaddrewardconfig()
self.curIndex=nil
self.showIndex=nil
self:onShow()

end
function UIWXAddRewardWin:testWeinXinZuShiTwo()
self.isRunDouYin=true
self.config=cfg_wechattwoaddrewardconfig()
self.curIndex=nil
self.showIndex=nil
self:onShow()

end


function UIWXAddRewardWin:testDouYinHeTu()
self.isRunDouYin=true
self.config=cfg_douyinhetuaddrewardconfig()
self.curIndex=nil
self.showIndex=nil
self:onShow()
end

function UIWXAddRewardWin:testDouYin()
self.isRunDouYin=true
self.config=cfg_douyinaddrewardconfig()
self.curIndex=nil
self.showIndex=nil
self:onShow()
end

function UIWXAddRewardWin:testHuaWei()
self.isRunHuaWei=true
self.config=cfg_huaweiaddrewardconfig()
self.curIndex=nil
self.showIndex=nil
self:onShow()
end

function UIWXAddRewardWin:testAlipay()
self.isRunAlipay=true
self.config=cfg_alipayaddrewardconfig()
self.curIndex=nil
self.showIndex=nil
self:onShow()
end

function UIWXAddRewardWin:testKuaiShow()
self.isRunKuaiShou=true
self.config=cfg_kuaishouaddrewardconfig()
self.curIndex=nil
self.showIndex=nil
self:onShow()
end




function UIWXAddRewardWin:onShow(argtable,afterOnloaded)
if argtable then
if self.isRunAlipay then
local vtype=argtable.visitType
if vtype then
if vtype==mgVisitEnterType.zfbFirstVisit then
webGLHelper:reportVisitEvent('center_setappc_panel_expo')
else
webGLHelper:reportVisitEvent('revisit_panel_expo')
end
end
end
end
self:checkSDKVersion()
self.showCfg={}
for i,v in ipairs(self.config)do
if self:checkNeedShow(v)then
self.showCfg[#self.showCfg+1]=i
end
end

local curIndex=self.showIndex or 1
self:onVerItemClick(curIndex-1)
end

function UIWXAddRewardWin:checkNeedShow(cfg)
if self.isRunAlipay then
if cfg.jumpType==2 then
local day=webGLHelper:getCreateRoleDay()
if day>7 then
return false
end
end
end
local giftId=cfg.giftId
local upgiftId=cfg.upgiftId
local ftype=cfg.ftype or 0

if ftype==0 then
if FreeGiftController.GetFreeGift(giftId)
or FreeGiftController.GetFreeGift(upgiftId)
or welfareController:checkVerify()
or cfg.dontClose then
return true
end
elseif ftype==1 then
if deviceHelper.getAPILevel()<360 then
return false
end

for i,v in ipairs(cfg.imageContent)do
local canRecv=FreeGiftController.GetFreeGift(v[2])
if canRecv then
return true
end
end
end
return false
end

function UIWXAddRewardWin:onShowArgRecv(argtable,afterOnloaded)
self:onShow()
end

function UIWXAddRewardWin:refreshItemContent()
self.itemContent:setChildLayoutGroupClearAllItems()
local cfg=self.config[self.curIndex]
local upgiftId=cfg.upgiftId
local freeCfg=cfg_freegiftconfig_get(upgiftId)
local rewards=freeCfg.rewards
local itemContentLen=#rewards
local reddotFlag,errcode=self:getUpFreeRecvFlag(self.curIndex)

if welfareController:checkVerify()then
errcode=0
end

for i,v in ipairs(self.rewarditem)do
local data=rewards[itemContentLen-i+1]
if data then
v:setActive(true)
local item=v:getWidgetBase()
widgetHelper.setNormalRewardItem(item,ItemCmp.UINormalRewardItem,data)
item:SetChildActive(ItemCmp.select,reddotFlag)
item:SetChildActive(ItemCmp.recvmask,errcode==1)
item:SetChildButtonClick(ItemCmp.select,function()
self:onItemClick(i)
end,true)
else
v:setActive(false)
end
end
end

function UIWXAddRewardWin:refreshFreeBtn()
local recvFlag=self:getFreeRecvFlag(self.curIndex)
self.freeReward:setActive(recvFlag)
end

function UIWXAddRewardWin:setSpeak()
local cfg=self.config[self.curIndex]
if cfg.speakTxt then
self.speakObj:setActive(true)
self.speakText:setText(cfg.speakTxt)
else
self.speakObj:setActive(false)
end
end

function UIWXAddRewardWin:setSignInContent()
local cfg=self.config[self.curIndex]
local enterIdStr=cfg.enterIdList[1]


local loginDays=webGLHelper:getEnterLoginDay(enterIdStr)

self.dayCount:setText(loginDays)
local widget=self.countIcon:getChildWidgetBase()
for i=0,6 do
local sw=widget:GetChildWidgetBase(i)
sw:SetChildActive(0,i<loginDays)
end

local imageContentList=cfg.imageContent
for i,v in ipairs(self.rewardRoot)do
local content=imageContentList[i]
local rwRoot=v:getWidgetBase()
rwRoot:SetChildText(0,content[3])
local upgiftId=content[2]
local freeCfg=cfg_freegiftconfig_get(upgiftId)
local rewards=freeCfg.rewards
local canRecv=FreeGiftController.GetFreeGift(upgiftId)
local active=loginDays>=content[1]

for ii=1,4 do
local rwd=rewards[ii]
if rwd then
rwRoot:SetChildActive(ii,true)
local item=rwRoot:GetChildWidgetBase(ii)
widgetHelper.setNormalRewardItem(item,0,rwd)
item:SetChildActive(ItemCmp.select,active and canRecv)
item:SetChildActive(ItemCmp.recvmask,active and not canRecv)
item:SetChildButtonClick(ItemCmp.select,function()
self:onItemClick(i)
end,true)
else
rwRoot:SetChildActive(ii,false)
end
end
end
end

function UIWXAddRewardWin:setNormalContent()
local cfg=self.config[self.curIndex]
local imageContentList=cfg.imageContent
for i,v in ipairs(self.gridItem)do
local content=imageContentList[i]
if content then
v:setActive(true)
local assetName=content[1]
local desc=content[2]
local griditem=v:getWidgetBase()
griditem:SetChildCSImageSprite(listItemCmp.contenImage,abName,assetName)
griditem:SetChildText(listItemCmp.desc,desc)
if i==1 then
local desc2=content[3]
if(self.isRunDouYin or self.isRunHuaWei or self.isRunAlipay or self.isRunKuaiShou or self.isRunBzhan)and desc2 then
griditem:SetChildActive(listItemCmp.click,true)
griditem:SetChildActive(listItemCmp.desc2,true)
griditem:SetChildButtonClick(listItemCmp.click,function()
if not _this then
return
end
if _this.isRunDouYin then
platformSDK:reqNavigateToSidebar()
elseif _this.isRunHuaWei then
_WXInterface.CreateShortcut(true,function(success,arg1,arg2)
if not success then
logErr('添加桌面失败',arg1,arg2)
end
end)
elseif _this.isRunAlipay then
if cfg.jumpType==1 then
webGLHelper:gameFirstVisit()
else
webGLHelper:gameReturnVisit()
end
elseif _this.isRunKuaiShou then
_this:handleKuaiShouJumpFunc(cfg)
elseif _this.isRunBzhan then
platformSDK:reqNavigateToSidebar()
end
end)
griditem:SetChildText(listItemCmp.desc2,desc2)
else
griditem:SetChildActive(listItemCmp.click,false)
griditem:SetChildActive(listItemCmp.desc2,false)
end
end
else
v:setActive(false)
end
end
end

function UIWXAddRewardWin:handleKuaiShouJumpFunc(cfg)
if cfg.jumpType==1 then
platformSDK:reqCheckCommonUse(function(success,result)
if success then
local data=jsonHelper.decode_josn(result)
if data then
if not data.isCommonUse then
platformSDK:reqAddCommonUse(function(success2,result2)
if success2 then
UIManager.info('成功设为常用')
else
logErr('设置常用失败',result2)
end
end)
else
UIManager.info('已设为常用')
end
end
else
logErr('检测设置常用失败',result)
end
end)
else
_WXInterface.IsShortcutExist(function(success,result)
if success then
local data=jsonHelper.decode_josn(result)
if data then
if not data.installed then
_WXInterface.CreateShortcut(false,function(success2,result2)
if success2 then
UIManager.info('成功添加到桌面')
else
logErr('添加桌面失败',result2)
end
end)
else
UIManager.info('已添加到桌面')
end
end
else
logErr('检测添加桌面失败',result)
end
end)
end
end

function UIWXAddRewardWin:createVerContent()















end

function UIWXAddRewardWin:refreshVerContent()










local len=#self.showCfg
self.btnScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.btnScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local showIndex=self.showCfg[i]
local selectFlag=self.curIndex==showIndex
local cfg=self.config[showIndex]
local ftype=cfg.ftype or 0
item:SetChildText(verItemCmp.desc,cfg.name)
local reddotFlag
if ftype==0 then
reddotFlag=self:getReddotFlag(showIndex)
elseif ftype==1 then
reddotFlag=self:isCanRecvLoginReward(cfg)
end
item:SetChildActive(verItemCmp.reddot,reddotFlag)
item:SetChildActive(verItemCmp.select,selectFlag)
end
end

function UIWXAddRewardWin:isCanRecvLoginReward(cfg)
local enterIdStr=cfg.enterIdList[1]
local loginDays=webGLHelper:getEnterLoginDay(enterIdStr)
for i,v in ipairs(cfg.imageContent)do
if loginDays>=v[1]then
local canRecv=FreeGiftController.GetFreeGift(v[2])
if canRecv then
return true
end
end
end
return false
end

function UIWXAddRewardWin:getReddotFlag(index)
return self:getFreeRecvFlag(index)or self:getUpFreeRecvFlag(index)
end


function UIWXAddRewardWin:getFreeRecvFlag(index)
local cfg=self.config[index]
local giftId=cfg.giftId
return FreeGiftController.GetFreeGift(giftId)
end

function UIWXAddRewardWin:getUpFreeRecvFlag(index)
local cfg=self.config[index]
local giftId=cfg.upgiftId
local canRecv=FreeGiftController.GetFreeGift(giftId)
if not canRecv then
return false,1
end
if _this.isRunBzhan then
if deviceHelper.isRunNoneOrEditor()then
return true,2
else
local scece=platformSDK:GetinitData(2)
local enterIdStr=cfg.enterIdList[1]
if scece==enterIdStr then
return true,2
end
end
return false
end

local enterFlag=welfareModel:getWXEnterFlag(index)
return enterFlag,2
end


function UIWXAddRewardWin:onHide()

end





function UIWXAddRewardWin:onFreeReward()
local cfg=self.config[self.curIndex]
local giftId=cfg.giftId
local isRunAlipay=self.isRunAlipay
local isRunDouYin=self.isRunDouYin
FreeGiftController.SendFreeGift(giftId,nil,function(result)
if result then
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshVerContent")
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshFreeBtn")

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
if isRunAlipay or isRunDouYin then
webGLHelper:checkAndShowMGEntryIcon()
end
end
end)
end

function UIWXAddRewardWin:onVerItemClick(index)
local showIndex=index+1
if self.showIndex==showIndex then
return
end
self.showIndex=showIndex
self.curIndex=self.showCfg[showIndex]

self:checkSDKVersion()

local cfg=self.config[self.curIndex]
local ftype=cfg.ftype or 0
if ftype==0 then
self.normalBG:setActive(true)
self.signInBG:setActive(false)
self.normalPanel:setActive(true)
self.signInPanel:setActive(false)

self:refreshVerContent()
self:setNormalContent()
self:refreshItemContent()
self:refreshFreeBtn()
self:setSpeak()
elseif ftype==1 then
self.normalBG:setActive(false)
self.signInBG:setActive(true)
self.normalPanel:setActive(false)
self.signInPanel:setActive(true)

self:refreshVerContent()
self:setSignInContent()
self:setSpeak()
end
end

function UIWXAddRewardWin:onItemClick(index)

local cfg=self.config[self.curIndex]
local isRunAlipay=self.isRunAlipay
local isRunDouYin=self.isRunDouYin
local ftype=cfg.ftype or 0
local received=function()
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshVerContent")
if ftype==0 then
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshItemContent")
elseif ftype==1 then
UIManager:invokeUIMethod("UIWXAddRewardWin","setSignInContent")
end

reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)

if isRunAlipay or isRunDouYin then
if cfg.jumpType==1 then
webGLHelper:reportVisitEvent('center_setappc_prize_receive')
else
webGLHelper:reportVisitEvent('revisit_prize_receive')
end
webGLHelper:checkAndShowMGEntryIcon()
end
end

if ftype==0 then
local giftId=cfg.upgiftId
FreeGiftController.SendFreeGift(giftId,nil,function(result)
if result then
received()
end
end)
elseif ftype==1 then
local enterIdStr=cfg.enterIdList[1]
local loginDays=webGLHelper:getEnterLoginDay(enterIdStr)
local list={}
for i,v in ipairs(cfg.imageContent)do
if loginDays>=v[1]then
local canRecv=FreeGiftController.GetFreeGift(v[2])
if canRecv then
table.insert(list,v[2])
end
end
end
local len=#list
if len<=0 then
return
end









FreeGiftController.SendFreeGiftList(list,nil,function(result)
received()
end)
end
end

function UIWXAddRewardWin:checkSDKVersion(hidetips)
if not deviceHelper.isRunWeiXin()then
return true
end
local versionStr=welfareController.getWXSDKVersion()
local strList=string.split(versionStr,"%.")

local value1,value2,value3=tonumber(strList[1]),tonumber(strList[2]),tonumber(strList[3])
if value1>2 then
return true
end
if value1==2 and value2>29 then
return true
end
if value1==2 and value2==29 and value3>1 then
return true
end
if not hidetips then
UIManager.info("您的微信版本过低，请升级至最新版本")
end
return false
end

