







def_class("UIZongmenLevelUpWin",UIWindowBase)









function UIZongmenLevelUpWin:bindComponents()

self.juanzhou=UIObject.get(self,0)
self.zmLevel=UIText.get(self,1)
self.unlockScrollerView=UIObject.get(self,2)
self.rewardList=UIObject.get(self,3)
self.continueBtn=UIButton.get(self,4)
self.lastWorldLevel=UIText.get(self,5)
self.curWorldLevel=UIText.get(self,6)
self.worldlevel=UIObject.get(self,7)
self.lastZMLevel=UIText.get(self,8)
self.curZMLevel=UIText.get(self,9)

self.continueBtn:setButtonClick(function()self:onContinueBtn()end)



end


function UIZongmenLevelUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.juanzhou);self.juanzhou=nil;
_UIObject_release(self.zmLevel);self.zmLevel=nil;
_UIObject_release(self.unlockScrollerView);self.unlockScrollerView=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.continueBtn);self.continueBtn=nil;
_UIObject_release(self.lastWorldLevel);self.lastWorldLevel=nil;
_UIObject_release(self.curWorldLevel);self.curWorldLevel=nil;
_UIObject_release(self.worldlevel);self.worldlevel=nil;
_UIObject_release(self.lastZMLevel);self.lastZMLevel=nil;
_UIObject_release(self.curZMLevel);self.curZMLevel=nil;
end

















local _format=string.format


function UIZongmenLevelUpWin:onLoaded(...)
self:bindComponents()
self.unlockScrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIZongmenLevelUpWin:__delete()
self:unbindComponents()
self:stopShowTimer()
msgWinControl.markLock(false)
if not UIManager:isActive('UIPlayerInfoWin')then
systemIconFlyControl.setFlyDelay(0.3)
end
if self.args.callback then
self.args.callback()
end
pfwindowslController:TriggerAtt_OuMei()
end




function UIZongmenLevelUpWin:onShow(argtable,afterOnloaded)
if not argtable then
return
end
self.args=argtable
self:stopShowTimer()
self.showTimer=self:delayDo(0.2,function()
self:showInfo(argtable)

self.juanzhou:setChildUIModelShowTarget(4870,1,{},eAnimationID.common_window_enter,false,false,0,nil)
end)
end


function UIZongmenLevelUpWin:onHide()

end

function UIZongmenLevelUpWin:stopShowTimer()
if self.showTimer then
self:stopTimerByID(self.showTimer)
self.showTimer=nil
end
end

function UIZongmenLevelUpWin:showInfo(argtable)
local last_level,cur_level=argtable[1],argtable[2]
self.zmLevel:setText(FMT.fmt('{0}级',cur_level))
self.lastZMLevel:setText(last_level)
self.curZMLevel:setText(cur_level)
local last_cfg=cfg_guildexpconfig_get(last_level)
local cur_cfg=cfg_guildexpconfig_get(cur_level)

local worldLevelUp=cur_cfg.worldlevel-last_cfg.worldlevel>0
self.worldlevel:setActive(worldLevelUp)
if worldLevelUp then
self.lastWorldLevel:setText(last_cfg.worldlevel)
self.curWorldLevel:setText(cur_cfg.worldlevel)
end

local contentList=self:getUnlockContent(cur_level)
local num=#contentList
self.unlockScrollerView:setChildScrollViewCreateGrids(num,num)
local grids=self.unlockScrollerView:getChildScrollViewItemWidgets()
for i=1,num do
local item=grids[i-1]
local list=contentList[i]
local config=list[1]
local index=list[2]
local unlockInfo=config.unlockinfo[index]
local icon=unlockInfo[1]
local content=unlockInfo[2]
local titile=content[1]
local desc=content[2]
local tipsTitle=content[3]
local tipsDesc=content[4]
local iconName=FMT.fmt('icon_zmleveluplock_{0}',icon)
item:SetChildIcon(0,iconName,false)
item:SetChildText(1,titile)
item:SetChildText(2,desc)
item:SetChildText(3,_format('（%s级解锁）',config.id))

local showTips=tipsTitle~=nil and tipsTitle~=""
item:SetChildActive(6,showTips)
if showTips then
item:SetChildToggleChange(6,function(name,isOn,data)
if isOn then
local args={}
args.posWidget=item
args.pivot=Vector2(0,0)
args.title=tipsTitle
args.iconName=iconName
args.iconnative=true
args.desclist={tipsDesc}
args.callback=function(...)
item:SetChildToggle(6,false)
end
UIManager:showWindow('UIDescribeTips4',args)
end
end)
end




end

local bindItem=function(index)
local widget=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=cur_cfg.rewards[index]
local count=data[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=data[2]
end
local prop=itemsComponentHelper.getCommonFillDataSmall({itemid=data[1],itemcount=countStr,showCountBG=showCountBG,showname=false})
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
self.rewardList:setChildLayoutGroupCreateItems(#cur_cfg.rewards,bindItem)
end

function UIZongmenLevelUpWin:getUnlockContent(start_lv)
local all_cfg=cfg_guildexpconfig()
local list={}
local config=cfgHelper.get1(cfg_guildexpconfig_get,start_lv)
local unlockinfo=config.unlockinfo
if unlockinfo then
for index,v in ipairs(unlockinfo)do
table.insert(list,{config,index})
end
else
for i=start_lv,#all_cfg do
local config=all_cfg[i]
local unlockinfo=config.unlockinfo
if unlockinfo then
for index,v in ipairs(unlockinfo)do
table.insert(list,{config,index})
end
break
end
end
end
return list
end


function UIZongmenLevelUpWin:onContinueBtn()
self:closeSelf()
end