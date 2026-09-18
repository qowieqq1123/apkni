







def_class("UIBuildingSuitBuildingWin",UIWindowBase)









function UIBuildingSuitBuildingWin:bindComponents()

self.background=UIObject.get(self,0)
self.nameTx=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.buildingModel=UIObject.get(self,3)
self.descTx=UIText.get(self,4)
self.effectTx=UIText.get(self,5)
self.partList=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIBuildingSuitBuildingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.buildingModel);self.buildingModel=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.effectTx);self.effectTx=nil;
_UIObject_release(self.partList);self.partList=nil;
end
















local _this=nil
local _partCmp={
button=-1,
icon=0,
name=1,
num=2,
iconBg=3,
}




function UIBuildingSuitBuildingWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIBuildingSuitBuildingWin:__delete()
self:unbindComponents()
_this=nil
end




function UIBuildingSuitBuildingWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self:refreshView()
end


function UIBuildingSuitBuildingWin:onHide()

end




function UIBuildingSuitBuildingWin:onCloseBtn()
self:closeSelf()
end

function UIBuildingSuitBuildingWin:refreshView()
local suit=zongmenBuildingSuitModel:findSuitIdByPartBuildID(self.bdData.build_id)
local suitCfg=cfgHelper.get1(cfg_buildsuitconfig_get,suit)
local mapCfg=cfgHelper.get1(cfg_monijybuildconfig_get,suitCfg.map)
local scale=suitCfg.view_scale2 or isometricMapSystem:getModelScale(mapCfg.model[1])
local pos=suitCfg.model_pos2 or{0,-85}
local effectStr=homeBuffModel:getBuffDescByStateId(suitCfg.guild_buffs[1])
local active=zongmenBuildingSuitModel:getActive(suit)
if active then
effectStr=FMT.cfmt(FONT_COLOR.eGreenColor,effectStr)
end
self.buildingModel:setChildUIModelRemoveTarget()
self.buildingModel:setChildUIModelShowTarget(mapCfg.model[1],scale,{},0)
self.buildingModel:setChildAnchoredPos(pos[1],pos[2])
self.nameTx:setText(mapCfg.name)
self.descTx:setText(mapCfg.desc)
self.effectTx:setText(effectStr)
local needBdCnt=#suitCfg.needbuild
local needRdCnt=suitCfg.needroad and#suitCfg.needroad or 0
self.partList:setChildLayoutGroupCreateItems(needBdCnt+needRdCnt,function(index)
local item=self.partList:getChildLayoutGroupGridItem(index-1)
if index<=needBdCnt then
local partData=suitCfg.needbuild[index]
local partBd=partData[1]
local partCfg=cfgHelper.get1(cfg_monijybuildconfig_get,partBd)
local needNum=partData[2]
local haveNum=zongmenBuildingSuitModel:getPartCount(suit,index)
item:SetChildButtonClick(_partCmp.button,function()
self:onClickPart(suit,index,partBd,true)
end)
item:SetChildIcon(_partCmp.icon,partCfg.icon,true)
item:SetChildText(_partCmp.name,partCfg.name)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",haveNum,needNum))
item:SetChildGraphicGray(_partCmp.iconBg,haveNum<needNum,true,true)
else
local roadId=suitCfg.needroad[index-needBdCnt]
local roadCfg=cfgHelper.get1(cfg_roadstyleconfig_get,roadId)
local active=true
item:SetChildButtonClick(_partCmp.button,function()
self:onClickPart(suit,index,roadId,false)
end)
item:SetChildIcon(_partCmp.icon,roadCfg.icon,true)
item:SetChildText(_partCmp.name,roadCfg.name)
local active=zongmenModel:isActiveRoad(roadId)
item:SetChildText(_partCmp.num,FMT.fmt("{0}/{1}",active and 1 or 0,1))
item:SetChildGraphicGray(_partCmp.iconBg,not active,true,true)
end
end)
end

function UIBuildingSuitBuildingWin:onClickPart(id,index,bdId,isBd)
if isBd then
local haveNum=zongmenBuildingSuitModel:getPartCount(id,index)
if haveNum<=0 then
local itemId=zongmenBuildingSuitModel:findPartItemByBuilding(bdId)
tipsManager.showTips({itemid=itemId})
end
else
if not zongmenModel:isActiveRoad(bdId)then
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,bdId)
local itemId=cfg.activate_cost
tipsManager.showTips({itemid=itemId})
end
end
end