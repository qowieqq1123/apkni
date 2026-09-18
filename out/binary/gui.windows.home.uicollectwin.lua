







def_class("UICollectWin",UIWindowBase)









function UICollectWin:bindComponents()

self.title=UIText.get(self,0)
self.desc=UIText.get(self,1)
self.rewardBtn=UIButton.get(self,2)
self.scrollview=UIObject.get(self,3)
self.icon=UIObject.get(self,4)
self.tips=UIText.get(self,5)
self.unlockText=UILinkImageText.get(self,6)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UICollectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
end
















local _this




function UICollectWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
notifySystem:listenNotify(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)
end


function UICollectWin:__delete()
notifySystem:removelistener(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)

_this=nil

self:unbindComponents()
end

function UICollectWin.on_area_unlock(sfId,areaId)
local id=_MapManager.GetAreaIDByObject(_this.data.guid)
if areaId==id then
_this:onClickClose()
end
end




function UICollectWin:onShow(argtable,afterOnloaded)
self.data=argtable
self:refresh()
end

function UICollectWin:refresh()
local id=self.data.id
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,id)
self.title:setText(cfg.name)
local scale=isometricMapSystem:getModelScale(cfg.model[1],true)
local modelParam=cfg.modeloffset or{0,0,4}
scale=scale*modelParam[3]
self.icon:setChildUIModelShowTarget(cfg.model[1],scale,cfg.model[2],eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(modelParam[1],modelParam[2])
self.desc:setText(cfg.desc)

local rewardid=cfg.rewards_conf.rewardid
local rwId
if type(rewardid)=='table'then
rwId=rewardid[self.data.areaId]
else
rwId=rewardid
end
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems or{}
self.rewards=rewards
local len=math.min(#rewards,5)
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=rewards[i+1]
local item=grids[i]
local stage
if not moneyConfig.isMoney(data[1])then
local rcfg=itemsConfig.getConfig(data[1])
stage=rcfg.stage
end
widgetHelper.setNormalRewardItem(item,0,{data[1],data[2],stage=stage,range=data.range})
end

self.rewardBtn:setActive(#rewards>5)

local areaId=self.data.areaId
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
self.tips:setText(FMT.fmt('解锁{0}后可开启',acfg.name))
self.unlockText:setText(FMT.fmt(cfgHelper.getlang('repair_link_text'),areaId))
end


function UICollectWin:onHide()

end




function UICollectWin:onRewardBtn()
UIManager:showWindow('UIShowRewardWin',self.rewards)
end

function UICollectWin:onClickClose()
self:closeSelf()
end
