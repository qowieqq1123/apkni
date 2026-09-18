







def_class("UIAutoBuildingWin",UIWindowBase)









function UIAutoBuildingWin:bindComponents()

self.rewardBtn=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.icon=UIObject.get(self,2)
self.bdLevel=UIText.get(self,3)
self.levelUpBtn=UIButton.get(self,4)
self.levelUpBtnText=UIText.get(self,5)
self.taskScroller=UIObject.get(self,6)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)



end


function UIAutoBuildingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
end
















local _this
local itemindex=
{
selfitem=0,
icon=1,
name=2,
time=3,
progvalue=4,
protxt=5,
locktxt=6,
lockimg=7,
progress=8,
}



function UIAutoBuildingWin:onLoaded(...)
self:bindComponents()
_this=self
self.timer={}
self.timermax=0

end


function UIAutoBuildingWin:__delete()
self:unbindComponents()
if self.timermax>0 then
for index=1,self.timermax do
self:clearTimer(index)
end
end
_this=nil

end

function UIAutoBuildingWin.on_building_event(etype,sfId,bdId,arg1,arg2)



end


function UIAutoBuildingWin:onClickRewardItem(itemId)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,move=TIPS_MOVE_POS.eCenter})
end

function UIAutoBuildingWin:onRewardBtn()
local canget=self:getIsReward()
if canget then

XianMengBaoXiaController:send_6_198(self.sfId,self.un_build_id)
else
UIManager.info('暂无奖励可领')
end
end

function UIAutoBuildingWin:onLevelUpBtn()
self:showWindow("UIAutoBuildingLvlupWin",{bdData=self.bdData,sfId=self.sfId})
end




function UIAutoBuildingWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.data
self.build_id=self.bdData.build_id
self.un_build_id=self.bdData.un_build_id
self.sfId=AutoBuildModel:getAutoBuildingSfid(self.un_build_id)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.build_id)


UIManager:callWindowFunc('UIBottomMaskWin','setTitle',"自动生产")


self:refreshModel()
self:refreshPanel()
end


function UIAutoBuildingWin:onHide()

end

function UIAutoBuildingWin:severfreah(un_build_id)
if un_build_id==_this.un_build_id then
_this:refreshPanel()
end
end


function UIAutoBuildingWin:refreshModel()
local cfg=self.config
local scale=isometricMapSystem:getModelScale(cfg.model[1],true)
local scales2Pram=isometricMapSystem:getModelScales2Pram(cfg.model[1],2)
scale=scale*scales2Pram[1]
local offset={scales2Pram[2],scales2Pram[3]}
self.icon:setChildUIModelShowTarget(cfg.model[1],scale,nil,eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(offset[1],offset[2])
end


function UIAutoBuildingWin:refreshPanel()

local buildlvl=AutoBuildModel:getAutoBuildingLvl(self.un_build_id)
local createList=AutoBuildModel:getAutoBuildingCreateList(self.un_build_id)
local _cfg=cfg_autocreatebuildconfig()
local list={}
for id,data in ipairs(_cfg)do


self.timermax=self.timermax+1
end
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
if cfg and cfg.create_conf then
list=cfg.create_conf
end


local desclist={}
desclist=cfg_autocreatebuildconfig_get(buildlvl).desc


local dataNum=#desclist
self.taskScroller:setActive(dataNum>0)
if dataNum>0 then
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local itemid=desclist[i][1]
local desc=desclist[i][2]



local iconname=iconHelper.getIconName(itemid)
item:SetChildIcon(itemindex.icon,iconname,false)
item:SetChildButtonClick(itemindex.icon,function()
_this:onClickRewardItem(itemid)
end)


item:SetChildText(itemindex.name,desc)


local starttime=createList[i]

local cfgdata=list[i]
if starttime and cfgdata then
item:SetChildLocalPosY(itemindex.name,23)
item:SetChildActive(itemindex.progress,true)
item:SetChildActive(itemindex.protxt,true)
item:SetChildActive(itemindex.time,true)
item:SetChildActive(itemindex.lockimg,false)
item:SetChildActive(itemindex.locktxt,false)

local num=cfgdata[2]
local time=cfgdata[3]
local maxnum=cfgdata[4]

local stamp=timeHelper.getServerShortTime()
local needtime=((maxnum/num)*time)
local endtime=starttime+needtime

if stamp>=endtime then

self:clearTimer(i)
item:SetChildText(itemindex.time,'<color=#549327>已存满</color>')
item:SetChildIconFillAmount(itemindex.progvalue,1/1)
item:SetChildText(itemindex.protxt,FMT.fmt("{0}/{1}",maxnum,maxnum))
else
local speed=num/time

self:startTimer(item,endtime,i,maxnum,speed)
end
else
item:SetChildLocalPosY(itemindex.name,0)
item:SetChildActive(itemindex.progress,false)
item:SetChildActive(itemindex.protxt,false)
item:SetChildActive(itemindex.time,false)
item:SetChildActive(itemindex.lockimg,true)
item:SetChildActive(itemindex.locktxt,true)


local str=FMT.fmt("建筑等级达到{0}级解锁",i)
item:SetChildText(itemindex.locktxt,str)
end
end
end

local canget=self:getIsReward()
self.winlua:SetChildGray(self.rewardBtn:getID(),not canget)
end


self.bdLevel:setText(FMT.fmt("{0}级",buildlvl))
end

function UIAutoBuildingWin:getIsReward()
local canget=false
local createList=AutoBuildModel:getAutoBuildingCreateList(self.un_build_id)
if createList then
local stamp=timeHelper.getServerShortTime()
for k,starttime in ipairs(createList)do
local cfg=cfg_autocreatebuildconfig_get(k)
local create_conf=cfg.create_conf[1]
local time=create_conf[3]

local delay=stamp-starttime
if delay>=time then
canget=true
break
end
end
end
return canget
end

function UIAutoBuildingWin:isUnLockUp(buildlvl)
local cfg=cfg_autocreatebuildconfig_get(buildlvl)
if cfg.need_level and cfg.need_level then
local zmLevel=zongmenModel:getLevel()
return zmLevel>=cfg.need_level,cfg.need_level
end
return true,0
end

function UIAutoBuildingWin:clearTimer(index)
if self.timer[index]then
self:stopTimerByID(self.timer[index])
self.timer[index]=nil
end
end
function UIAutoBuildingWin:startTimer(widget,endsec,index,maxnum,speed)
self:clearTimer(index)
local tick=function()
local stamp=timeHelper.getServerShortTime()
if endsec>stamp then
widget:SetChildText(itemindex.time,FMT.fmt('{0}后存满',timeHelper.format_time_stamp(endsec-stamp)))
local nownum=maxnum-math.floor(speed*(endsec-stamp))
widget:SetChildIconFillAmount(itemindex.progvalue,nownum/maxnum)
widget:SetChildText(itemindex.protxt,FMT.fmt("{0}/{1}",nownum,maxnum))
else
widget:SetChildText(itemindex.time,'<color=#549327>已存满</color>')
widget:SetChildIconFillAmount(itemindex.progvalue,1/1)
widget:SetChildText(itemindex.protxt,FMT.fmt("{0}/{1}",maxnum,maxnum))
self.winlua:SetChildGray(self.rewardBtn:getID(),false)
self:clearTimer(index)
end
end
tick()
self.timer[index]=self:setTimer(1,0,tick)
end














function UIAutoBuildingWin:onClickClose()
self:closeSelf()
end
