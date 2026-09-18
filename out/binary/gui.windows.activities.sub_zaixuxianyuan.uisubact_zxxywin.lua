







def_class("UISubAct_zxxyWin",UIWindowBase)









function UISubAct_zxxyWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.btnJieYin=UIButton.get(self,1)
self.btnLiBao=UIButton.get(self,2)
self.btnQianDao=UIButton.get(self,3)
self.btnWenJuan=UIButton.get(self,4)
self.btnXiuXing=UIButton.get(self,5)
self.btnZengYi=UIButton.get(self,6)
self.helpBtn=UIButton.get(self,7)
self.infoBg=UIObject.get(self,8)
self.infoText=UIText.get(self,9)
self.jieYinIcon=UIImage.get(self,10)
self.jieYinTitle=UIImage.get(self,11)
self.liBaoIcon=UIImage.get(self,12)
self.liBaoTitle=UIImage.get(self,13)
self.modelClick=UIButton.get(self,14)
self.qianDaoIcon=UIImage.get(self,15)
self.qianDaoTitle=UIImage.get(self,16)
self.rewardList=UIObject.get(self,17)
self.showModel=UIObject.get(self,18)
self.timeText=UIText.get(self,19)
self.title=UIImage.get(self,20)
self.xiuXingIcon=UIImage.get(self,21)
self.xiuXingTitle=UIImage.get(self,22)
self.zengYiIcon=UIImage.get(self,23)
self.zengYiTitle=UIImage.get(self,24)

self.btnJieYin:setButtonClick(function()self:onBtnJieYin()end)

self.btnLiBao:setButtonClick(function()self:onBtnLiBao()end)

self.btnQianDao:setButtonClick(function()self:onBtnQianDao()end)

self.btnWenJuan:setButtonClick(function()self:onBtnWenJuan()end)

self.btnXiuXing:setButtonClick(function()self:onBtnXiuXing()end)

self.btnZengYi:setButtonClick(function()self:onBtnZengYi()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.modelClick:setButtonClick(function()self:onModelClick()end)



end


function UISubAct_zxxyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btnJieYin);self.btnJieYin=nil;
_UIObject_release(self.btnLiBao);self.btnLiBao=nil;
_UIObject_release(self.btnQianDao);self.btnQianDao=nil;
_UIObject_release(self.btnWenJuan);self.btnWenJuan=nil;
_UIObject_release(self.btnXiuXing);self.btnXiuXing=nil;
_UIObject_release(self.btnZengYi);self.btnZengYi=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.jieYinIcon);self.jieYinIcon=nil;
_UIObject_release(self.jieYinTitle);self.jieYinTitle=nil;
_UIObject_release(self.liBaoIcon);self.liBaoIcon=nil;
_UIObject_release(self.liBaoTitle);self.liBaoTitle=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.qianDaoIcon);self.qianDaoIcon=nil;
_UIObject_release(self.qianDaoTitle);self.qianDaoTitle=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.showModel);self.showModel=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.xiuXingIcon);self.xiuXingIcon=nil;
_UIObject_release(self.xiuXingTitle);self.xiuXingTitle=nil;
_UIObject_release(self.zengYiIcon);self.zengYiIcon=nil;
_UIObject_release(self.zengYiTitle);self.zengYiTitle=nil;
end
















local _this
local subMenuType=
{
qianDao=0,
xiuXing=0,
zengYi=0,
liBao=0,
jieYin=0,
}




function UISubAct_zxxyWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zxxyWin:__delete()
self:clearTimer()
self:clearDelayClickTimer()
self:unbindComponents()
_this=nil
end




function UISubAct_zxxyWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.sublist=activitiesModel:getActSubList_open_doing(self.activityId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time


self:refreshBgModel()

self:refresh()
self:recountMenuIndex()
end


function UISubAct_zxxyWin:onHide()
self:clearTimer()
self:clearDelayClickTimer()
end


function UISubAct_zxxyWin:recountMenuIndex()
local textConfig=self.config.sub_btnIcons
local iconConfig=self.config.subIcons
local abname='ui/windows/activities/sub_zaixuxianyuan/zaixuxianyuan_atlas_pak.ab'

for k,v in ipairs(self.sublist)do

if v.sub_act_type==63 then
subMenuType.jieYin=k
self.winlua:SetChildActive(self.btnJieYin:getID(),true)
if textConfig and next(textConfig)then
local icon=textConfig[63]
if icon then
self.winlua:SetChildCSImageSprite(self.jieYinTitle:getID(),abname,icon)
end
end

if iconConfig and next(iconConfig)then
local icon=iconConfig[63]
if icon then
self.winlua:SetChildCSImageSprite(self.jieYinIcon:getID(),abname,icon)
end
end
end
if v.sub_act_type==64 then
subMenuType.qianDao=k
self.winlua:SetChildActive(self.btnQianDao:getID(),true)

if textConfig and next(textConfig)then
local icon=textConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.qianDaoTitle:getID(),abname,icon)
end
end

if iconConfig and next(iconConfig)then
local icon=iconConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.qianDaoIcon:getID(),abname,icon)
end
end
end
if v.sub_act_type==34 or v.sub_act_type==81 then
subMenuType.liBao=k
self.winlua:SetChildActive(self.btnLiBao:getID(),true)

if textConfig and next(textConfig)then
local icon=textConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.liBaoTitle:getID(),abname,icon)
end
end

if iconConfig and next(iconConfig)then
local icon=iconConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.liBaoIcon:getID(),abname,icon)
end
end
end
if v.sub_act_type==65 then
subMenuType.zengYi=k
self.winlua:SetChildActive(self.btnZengYi:getID(),true)

if textConfig and next(textConfig)then
local icon=textConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.zengYiTitle:getID(),abname,icon)
end
end

if iconConfig and next(iconConfig)then
local icon=iconConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.zengYiIcon:getID(),abname,icon)
end
end
end
if v.sub_act_type==67 then
subMenuType.xiuXing=k
self.winlua:SetChildActive(self.btnXiuXing:getID(),true)

if textConfig and next(textConfig)then
local icon=textConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.xiuXingTitle:getID(),abname,icon)
end
end

if iconConfig and next(iconConfig)then
local icon=iconConfig[v.sub_act_type]
if icon then
self.winlua:SetChildCSImageSprite(self.xiuXingIcon:getID(),abname,icon)
end
end
end
end
end




function UISubAct_zxxyWin:onModelClick()
end


function UISubAct_zxxyWin:onBtnWenJuan()
newQuestionController:showClientShowQuestionWin()
end


function UISubAct_zxxyWin:onHelpBtn()
local str=self.config.infoDesc
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name=str})
end


function UISubAct_zxxyWin:onBtnQianDao()
UI_activity_main_Win:onItemClick(subMenuType.qianDao)
end


function UISubAct_zxxyWin:onBtnXiuXing()
UI_activity_main_Win:onItemClick(subMenuType.xiuXing)
end


function UISubAct_zxxyWin:onBtnZengYi()
UI_activity_main_Win:onItemClick(subMenuType.zengYi)
end


function UISubAct_zxxyWin:onBtnLiBao()
UI_activity_main_Win:onItemClick(subMenuType.liBao)
end


function UISubAct_zxxyWin:onBtnJieYin()
UI_activity_main_Win:onItemClick(subMenuType.jieYin)
end

function UISubAct_zxxyWin:refresh()

local abName="ui/windows/activities/sub_zaixuxianyuan/zaixuxianyuan_atlas_pak.ab"
local iconname=self.config.titleImage

if iconname then
self.title:setSprite(abName,iconname)
self.title:setActive(true)
else
self.title:setActive(false)
end


self:setRemainingTimeTimer()
end


function UISubAct_zxxyWin:refreshBgModel()
local bgModelId=self.config.bgModelId
if bgModelId then
local animId=eAnimationID.stand
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},animId,false,false,0)
self.bgModel:setActive(true)
else
self.bgModel:setActive(false)
self.bgModel:setChildUIModelRemoveTarget()
end
end


function UISubAct_zxxyWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_zxxyWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_zxxyWin:clearDelayClickTimer()
if self.delayClickTimer then
self:stopTimerByID(self.delayClickTimer)
end
end