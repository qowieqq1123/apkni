







def_class("UIBuffBuildingWin",UIWindowBase)









function UIBuffBuildingWin:bindComponents()

self.levelUpBtnText=UIText.get(self,0)
self.tips=UIText.get(self,1)
self.st2=UIObject.get(self,2)
self.destext=UIText.get(self,3)
self.buildScrollview=UIObject.get(self,4)
self.effexttext=UIText.get(self,5)
self.level=UIText.get(self,6)
self.levelUpBtn=UIButton.get(self,7)
self.title1=UIText.get(self,8)
self.title=UIText.get(self,9)
self.icon=UIObject.get(self,10)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)



end


function UIBuffBuildingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.st2);self.st2=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.effexttext);self.effexttext=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.icon);self.icon=nil;
end
















local _this




function UIBuffBuildingWin:onLoaded(...)
self:bindComponents()

_this=self

self.buildScrollview:setChildScrollViewInit(1,true,nil,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIBuffBuildingWin:__delete()
self:unbindComponents()

_this=nil

notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIBuffBuildingWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.levelUpComplete then
_this:refresh()
end
end




function UIBuffBuildingWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)

UIManager:callWindowFunc('UIBottomMaskWin','setTitle',self.config.name)

self:refresh()
end

function UIBuffBuildingWin:refresh()
local id=self.bdData.build_id
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,self.bdData.level)
self.destext:setText(levelCfg.build_desc)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)

local scale=isometricMapSystem:getModelScale(cfg.model[1],true)

local scales2Pram=isometricMapSystem:getModelScales2Pram(cfg.model[1],2)
scale=scale*scales2Pram[1]
local offset={scales2Pram[2],scales2Pram[3]}
self.icon:setChildUIModelShowTarget(cfg.model[1],scale,nil,eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(offset[1],offset[2])
local benefit=cfg.benefit_type
if benefit then
self.st2:setActive(true)
self.buildScrollview:setActive(true)
self.buildScrollview:setChildScrollViewCreateGrids(#benefit,0)
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,benefit[i+1])
local node=grids[i]

node:SetChildIcon(0,bdcfg.icon,false)
node:SetChildText(1,bdcfg.name)
end
else
self.st2:setActive(false)
self.buildScrollview:setActive(false)
end
local buff=levelCfg.effects

local buffStr='效果：'
if buff then
for k,v in pairs(buff[1].param)do
local bcfg=cfgHelper.get1(cfg_monijybuildconfig_get,k)
buffStr=FMT.fmt('{0}{1}产量+{2}% ',buffStr,bcfg.name,v)
end
else

buffStr=FMT.fmt('{0}{1}',buffStr,levelCfg.effects_desc)
end
local area=cfg.buff_area
if area then
self.tips:setActive(true)
self.effexttext:setText(string.format('范围：%s*%s\n%s',area[3],area[4],buffStr))
else
self.tips:setActive(false)
self.effexttext:setText(string.format('范围：全宗门\n%s',buffStr))
end
self.level:setText(FMT.fmt('{0}级{1}',self.bdData.level,cfg.name))
self.levelUpBtn:setActive(cfg.max_lvl>1)
self.title1:setActive(cfg.max_lvl==1)
end











function UIBuffBuildingWin:onHide()

end




function UIBuffBuildingWin:onLevelUpBtn()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIBuffBuildingWin:onClickClose()
self:closeSelf()
end