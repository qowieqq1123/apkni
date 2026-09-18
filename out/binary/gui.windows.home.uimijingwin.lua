







def_class("UIMiJingWin",UIWindowBase)









function UIMiJingWin:bindComponents()

self.challengeTxt=UIText.get(self,0)
self.level=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.scrollview=UIObject.get(self,3)
self.challengeBtn=UIButton.get(self,4)
self.tips=UIText.get(self,5)
self.unlockText=UILinkImageText.get(self,6)
self.icon=UIObject.get(self,7)
self.title=UIText.get(self,8)
self.name=UIText.get(self,9)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)



end


function UIMiJingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.challengeTxt);self.challengeTxt=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.name);self.name=nil;
end
















local _this




function UIMiJingWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)

notifySystem:listenNotify(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)
end


function UIMiJingWin:__delete()
self:unbindComponents()
_this=nil
self.state=nil
self.waitToRefresh=false
notifySystem:removelistener(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)
end

function UIMiJingWin.on_area_unlock(sfId,areaId)
local id=_MapManager.GetAreaIDByObject(_this.data.guid)
if areaId==id then
_this:refresh()
end
end




function UIMiJingWin:onShow(argtable,afterOnloaded)
self.data=argtable
self:refresh()


end


function UIMiJingWin:onHide()

end


















function UIMiJingWin:refresh()
local id=self.data.id
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,id)
self.title:setText('秘境')
local scale=isometricMapSystem:getModelScale(cfg.model[1],true)
local modelParam=cfg.modeloffset or{0,0,4}
scale=scale*modelParam[3]
self.icon:setChildUIModelShowTarget(cfg.model[1],scale,cfg.model[2],eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(modelParam[1],modelParam[2])

self.mjId=cfg.rewards_conf.mijingid
local mjcfg=cfgHelper.get1(cfg_secretscenefubenconfig_get,self.mjId)
self.desc:setText(mjcfg.story)

self.name:setText(mjcfg.name)
local n,p,pN=UIDiscipleModel:getJJNameX(mjcfg.fixedJingJie or 0)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('境界：{0}{1}',n,pN)
else
jj_str=FMT.fmt('境界：{0}',n)
end
self.level:setText(jj_str)

local rwId=mjcfg.showReward
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
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

local isUnlock=isometricMapSystem:isInUnlockArea(self.data.guid)
self.challengeBtn:setActive(isUnlock)
self.tips:setActive(not isUnlock)
self.unlockText:setActive(not isUnlock)
if not isUnlock then
local areaId=self.data.areaId
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
self.tips:setText(FMT.fmt('解锁{0}后可挑战',acfg.name))
self.unlockText:setText(FMT.fmt(cfgHelper.getlang('repair_link_text'),areaId))
else





self:refreshState()
end
end

function UIMiJingWin:refreshState(argtable)
if MysteryModel:have_mystery_task(self.mjId)then
self.challengeTxt:setText("继续探索")
else
self.challengeTxt:setText("进入秘境")
end
end





function UIMiJingWin:onChallengeBtn()
if self.waitToRefresh then
return
end
MysteryController:enterMysteryFbEx(self.mjId,MysteryModel:have_mystery_task(self.mjId))
self:closeSelf()
end

function UIMiJingWin:onClickClose()
self:closeSelf()
end