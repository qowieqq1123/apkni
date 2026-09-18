







def_class("tipsChildBuildSuit",UICloneObject)





tipsChildBuildSuit.abName="ui/windows/tips/child/tipschildbuildsuit.ab"

tipsChildBuildSuit.assetName="tipsChildBuildSuit"


function tipsChildBuildSuit:bindComponents()

self.effect=UIText.get(self,0)
self.list=UIObject.get(self,1)

end


function tipsChildBuildSuit:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.list);self.list=nil;
end






local _itemCmp={
active=0,
name=1,
}




function tipsChildBuildSuit:onLoaded(...)
self:bindComponents()
end


function tipsChildBuildSuit:__delete()
self:unbindComponents()
end




function tipsChildBuildSuit:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local itemid=data.itemid
local bdId=zongmenBuildingSuitModel:findPartBuildingByItem(itemid)
local roadId=zongmenBuildingSuitModel:findPartRoadByItem(itemid)
local suitCfg=nil
local cfg=cfg_buildsuitconfig()
for i,v in pairs(cfg)do
if suitCfg==nil then
for j,w in ipairs(v.needbuild)do
if w[1]==bdId then
suitCfg=v
break
end
end
if not suitCfg and v.needroad then
for j,w in ipairs(v.needroad)do
if w==roadId then
suitCfg=v
break
end
end
end
else
break
end
end

if suitCfg then
local effectStr=homeBuffModel:getBuffDescByStateId(suitCfg.guild_buffs[1])
local active=zongmenBuildingSuitModel:getActive(suitCfg.id)
if active then
effectStr=FMT.cfmt(FONT_COLOR.eGreenColor,effectStr)
end
self.effect:setText(effectStr)
local bdCnt=#suitCfg.needbuild
local roadCnt=suitCfg.needroad and#suitCfg.needroad or 0
self.list:setChildLayoutGroupCreateItems(bdCnt+roadCnt,function(index)
local isBd=index<=#suitCfg.needbuild
local item=self.list:getChildLayoutGroupGridItem(index-1)
if isBd then
local info=suitCfg.needbuild[index]
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,info[1])
local num=zongmenBuildingSuitModel:getPartCount(suitCfg.id,index)
local enough=num>=info[2]
local name=enough and FMT.cfmt(FONT_COLOR.eGreenColor,"{0} X{1}",bdCfg.name,info[2])or FMT.fmt("{0} X{1}",bdCfg.name,info[2])
item:SetChildActive(_itemCmp.active,enough)
item:SetChildText(_itemCmp.name,name)
else
local roadId=suitCfg.needroad[index-bdCnt]
local roadCfg=cfgHelper.get1(cfg_roadstyleconfig_get,roadId)
local enough=zongmenModel:isActiveRoad(roadId)
local name=enough and FMT.cfmt(FONT_COLOR.eGreenColor,"{0} X1",roadCfg.name)or FMT.fmt("{0} X1",roadCfg.name)
item:SetChildActive(_itemCmp.active,enough)
item:SetChildText(_itemCmp.name,name)
end
end)
end
self.widget:ForceLayoutRect(-1)
end


function tipsChildBuildSuit:onHide()

end


