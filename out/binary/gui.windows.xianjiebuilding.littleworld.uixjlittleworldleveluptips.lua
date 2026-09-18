







def_class("UIXJLittleWorldLevelUpTips",UIWindowBase)









function UIXJLittleWorldLevelUpTips:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.event=UIObject.get(self,1)
self.eventView=UIObject.get(self,2)
self.faLing=UIObject.get(self,3)
self.faLingView=UIObject.get(self,4)
self.moneyPanel=UIObject.get(self,5)
self.nextWorldLv=UIText.get(self,6)
self.panel_1=UIObject.get(self,7)
self.panel_2=UIObject.get(self,8)
self.panel_3=UIObject.get(self,9)
self.titleName=UIText.get(self,10)
self.worldattrPanel=UIObject.get(self,11)
self.worldLv=UIText.get(self,12)
self.xiushiPanel=UIObject.get(self,13)
self.xiushiView=UIObject.get(self,14)
self.panel={
self.panel_1,
self.panel_2,
self.panel_3,
}



end


function UIXJLittleWorldLevelUpTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.event);self.event=nil;
_UIObject_release(self.eventView);self.eventView=nil;
_UIObject_release(self.faLing);self.faLing=nil;
_UIObject_release(self.faLingView);self.faLingView=nil;
_UIObject_release(self.moneyPanel);self.moneyPanel=nil;
_UIObject_release(self.nextWorldLv);self.nextWorldLv=nil;
_UIObject_release(self.panel_1);self.panel_1=nil;
_UIObject_release(self.panel_2);self.panel_2=nil;
_UIObject_release(self.panel_3);self.panel_3=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.worldattrPanel);self.worldattrPanel=nil;
_UIObject_release(self.worldLv);self.worldLv=nil;
_UIObject_release(self.xiushiPanel);self.xiushiPanel=nil;
_UIObject_release(self.xiushiView);self.xiushiView=nil;
self.panel=nil;
end



















function UIXJLittleWorldLevelUpTips:onLoaded(...)
self:bindComponents()
end


function UIXJLittleWorldLevelUpTips:__delete()
self:unbindComponents()
end




function UIXJLittleWorldLevelUpTips:onShow(argtable,afterOnloaded)
local worldlv=argtable.new_lv

self.oldLv=worldlv-1

self.newLv=worldlv

self.worldLv:setText(worldlv-1)
self.nextWorldLv:setText(worldlv)

self.panelState=0
self:onCloseClick()
end


function UIXJLittleWorldLevelUpTips:onHide()

end

function UIXJLittleWorldLevelUpTips:refreshPanelState()
local state=self.panelState
self.panel_1:setActive(state==1)
self.panel_2:setActive(state==2)
self.panel_3:setActive(state==3)
end

function UIXJLittleWorldLevelUpTips:showPanel1()
self:refreshPanelState()
local attrLookup=attrListHelper.tramsformToLookup(LittleWorldModel.getWorldBaseAttr(self.oldLv)or{})
local newAttrLookup=attrListHelper.tramsformToLookup(LittleWorldModel.getWorldBaseAttr(self.newLv)or{})
local attrList=attrListHelper.transformToList(attrLookup,{{eAttributeType.eATK},{eAttributeType.eDEF},{eAttributeType.eHP}})
self.attrPanel:setChildLayoutGroupCreateItems(#attrList,nil)
local childGrids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local attr=attrList[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
childItem:SetChildText(0,FMT.fmt("<color=#7d3b17>{0}：</color>{1}",name,str))
local newAttr=newAttrLookup[attr[1]]
if newAttr then
childItem:SetChildActive(3,true)
childItem:SetChildText(2,newAttr)
else
childItem:SetChildActive(3,false)
end
end

local rewardList=self:getRewardList(self.newLv)

local oldRewardLookup=attrListHelper.tramsformToLookup(self:getRewardList(self.oldLv))
self.moneyPanel:setChildLayoutGroupCreateItems(#rewardList,nil)
local childGrids=self.moneyPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local rw=rewardList[i]

childItem:SetChildIcon(1,iconHelper.getIconName(rw[1]),false)
childItem:SetChildText(2,mathHelper.formatNumber((oldRewardLookup[rw[1]]or 0)))
childItem:SetChildText(3,mathHelper.formatNumber(rw[2]))
end
end

function UIXJLittleWorldLevelUpTips:getRewardList(level)
local rewardList={}
local moneyDrop=LittleWorldModel.get_money_drop_id1(level)
if moneyDrop then
local rcfg=cfgHelper.get1(cfg_awardconfig_get,moneyDrop)
local rewards=rcfg.showItems

rewardList=attrListHelper.concatList(rewardList,rewards)
end
local itemDrop=LittleWorldModel.get_item_drop_id1(level)
if itemDrop then
local rcfg=cfgHelper.get1(cfg_awardconfig_get,itemDrop)
local rewards=rcfg.showItems
rewardList=attrListHelper.concatList(rewardList,rewards)
end
return rewardList
end

local detailAttr=
{

[1]={
name="人口上限",
getMax=function(lv)
return LittleWorldModel.getPopulationMax(lv)
end,
},

[2]={
name="香火值上限",
getMax=function(lv)
return LittleWorldModel.getXiaoHuoValMax(lv)
end,
},
}


function UIXJLittleWorldLevelUpTips:showPanel2()
self:refreshPanelState()
self.worldattrPanel:setChildLayoutGroupCreateItems(#detailAttr,nil)
local childGrids=self.worldattrPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local attrInfo=detailAttr[i]
local oldMax=attrInfo.getMax(self.oldLv)
childItem:SetChildText(0,mathHelper.formatNumber4(oldMax))
childItem:SetChildText(4,FMT.fmt("<color=#7d3b17>{0}：</color>",attrInfo.name))
local newMax=attrInfo.getMax(self.newLv)
childItem:SetChildActive(3,newMax>oldMax)
if newMax>oldMax then
childItem:SetChildText(2,mathHelper.formatNumber4(newMax))
end
end


local config=cfgHelper.get(cfg_smallworldlvconfig_get,self.oldLv,"population_max")
local newConfig=cfgHelper.get(cfg_smallworldlvconfig_get,self.newLv,"population_max")
self.xiushiView:setChildLayoutGroupCreateItems(#config)
local grids=self.xiushiView:getChildLayoutGroupGridList()
local nameList=cfgHelper.get(cfg_smallworldconfig_get,1,"xiushi_name")
for i=1,grids.Count do
local grid=grids[i-1]
if nameList[i]then
grid:SetChildActive(-1,true)
grid:SetChildText(0,FMT.fmt("{0}：",nameList[i]))
grid:SetChildText(1,mathHelper.formatNumber4(config[i]))
grid:SetChildText(2,mathHelper.formatNumber4(newConfig[i]))
else
grid:SetChildActive(-1,false)
end
end

end

function UIXJLittleWorldLevelUpTips:showPanel3()
self:refreshPanelState()
local newConfig=cfgHelper.get(cfg_smallworldlvconfig_get,self.newLv,"openNew")

if newConfig then
local config=newConfig[1]
local newType=config[1]
if newType==1 then
self.faLing:setActive(true)

self.faLingView:setChildLayoutGroupCreateItems(#newConfig)
local grids=self.faLingView:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
config=newConfig[i]
local flConfig=cfgHelper.get(cfg_smallworldorderconfig_get,config[2])
grid:SetChildText(0,flConfig.name)
grid:SetChildIcon(1,FMT.fmt("icon_lw_faling_{0}",flConfig.icon),true)
grid:SetChildText(2,flConfig.desc)
end


elseif newType==2 then
self.event:setActive(true)
self.eventView:setChildLayoutGroupCreateItems(#newConfig)
local grids=self.eventView:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
config=newConfig[i]
grid:SetChildText(0,config[2][1])
grid:SetChildIcon(1,config[2][2],true)
grid:SetChildText(2,config[2][3])
end
end
else
self:onCloseClick()
end
end



function UIXJLittleWorldLevelUpTips:onCloseClick()
self.panelState=self.panelState+1

local func=self["showPanel"..self.panelState]
if func then
func(self)
else
self:closeSelf()
end
end



