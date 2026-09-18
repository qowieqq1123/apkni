







def_class("UIFabaoMaterialTipsDescWin",UIWindowBase)









function UIFabaoMaterialTipsDescWin:bindComponents()

self.root=UIObject.get(self,0)
self.lianzhiPanel=UIObject.get(self,1)
self.shenTongRoot=UIObject.get(self,2)
self.mainAttrRoot=UIObject.get(self,3)
self.secondaryAttrRoot=UIObject.get(self,4)
self.lianhuaPanel=UIObject.get(self,5)
self.lianHuaAttrRoot=UIObject.get(self,6)
self.lianHuaDescRoot=UIObject.get(self,7)
self.clickMask=UIButton.get(self,8)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UIFabaoMaterialTipsDescWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.lianzhiPanel);self.lianzhiPanel=nil;
_UIObject_release(self.shenTongRoot);self.shenTongRoot=nil;
_UIObject_release(self.mainAttrRoot);self.mainAttrRoot=nil;
_UIObject_release(self.secondaryAttrRoot);self.secondaryAttrRoot=nil;
_UIObject_release(self.lianhuaPanel);self.lianhuaPanel=nil;
_UIObject_release(self.lianHuaAttrRoot);self.lianHuaAttrRoot=nil;
_UIObject_release(self.lianHuaDescRoot);self.lianHuaDescRoot=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
end















local shenTongRootCmpIndex={
title=0,
cd=1,
level=2,
name=3,
icon=4,
desc=5,
}
local mainAttrRootCmpIndex={
title=0,
descGridLayout=1,
}
local secondaryAttrRootCmpIndex={
title=0,
descGridLayout=1,
}
local lianHuaAttrRootCmpIndex={
title=0,
descGridLayout=1,
}
local lianHuaDescRootCmpIndex={
desc=0,
}

local _movePosX=
{
[TIPS_MOVE_POS.eRight]=276,
[TIPS_MOVE_POS.eLeft]=-276,
[TIPS_MOVE_POS.eCenter]=0,
[TIPS_MOVE_POS.eRightTwo]=330,
}



function UIFabaoMaterialTipsDescWin:onLoaded(...)
self:bindComponents()
end


function UIFabaoMaterialTipsDescWin:__delete()
self:unbindComponents()
end




function UIFabaoMaterialTipsDescWin:onShow(argtable,afterOnloaded)
self.itemid=argtable and argtable.itemid
self.showType=argtable and argtable.showType
self.move=argtable and argtable.move
self.lianzhiPanel:setActive(self.showType==1)
self.lianhuaPanel:setActive(self.showType==2)
if self.showType==1 then

self:refreshLianZhiPanel()
elseif self.showType==2 then

self:refreshLianHuaPanel()
end

if afterOnloaded and self.move then
self.root:setChildDOLocalMoveX(_movePosX[self.move],0.3)
end
end


function UIFabaoMaterialTipsDescWin:onHide()

end

function UIFabaoMaterialTipsDescWin:refreshLianZhiPanel()

local itemConfig=itemsConfig.getConfig(self.itemid)
local color=itemConfig.color
local shentongid,shentongLv

shentongid,shentongLv=fabaoHelper.getShentongidByMainItemId(self.itemid)

local showShenTong=true
if shentongid==nil or fabaoConfig.isBenMingFabao(self.itemid)then
showShenTong=false
end
self.shenTongRoot:setActive(showShenTong)
if showShenTong then
local isMakeByEquip=itemsConfig.isEquip(self.itemid)
local stage=itemConfig.stage or 0
stage=isMakeByEquip and fabaoConfig.getFabaoStageByEquipStage(stage)or stage
local shentongConfig=fabaoConfig.getShentongConfig(shentongid)
local shentongIcon=iconHelper.getSkillIcon(shentongConfig.icon)
local shentongName=shentongConfig.name
local shentonglvStr=FMT.fmt('{0}级',shentongLv)
local desc=skillModel:getSkillDesc(shentongid,shentongLv)

local shentongWidget=self.shenTongRoot:getWidgetBase()
shentongWidget:SetChildText(shenTongRootCmpIndex.title,"作为法宝主材料时，神通技能")
shentongWidget:SetChildCSImageIcon(shenTongRootCmpIndex.icon,shentongIcon)
shentongWidget:SetChildText(shenTongRootCmpIndex.name,shentongName)
shentongWidget:SetChildText(shenTongRootCmpIndex.desc,desc)
shentongWidget:SetChildText(shenTongRootCmpIndex.level,shentonglvStr)
end


local mainAttrsList=self:getLianZhiAttrText(true)
if mainAttrsList and next(mainAttrsList)then
local baseAttrWidget=self.mainAttrRoot:getWidgetBase()
baseAttrWidget:SetChildText(mainAttrRootCmpIndex.title,"作为法宝主材料时，法宝基础属性")
local attrCount=#mainAttrsList
baseAttrWidget:SetChildLayoutGroupCreateItems(mainAttrRootCmpIndex.descGridLayout,attrCount)
local descExGrid=baseAttrWidget:GetChildLayoutGroupGridList(mainAttrRootCmpIndex.descGridLayout)
for i=1,descExGrid.Count do
local descItem=descExGrid[i-1]
local attrTxt=mainAttrsList[i]
descItem:SetChildText(0,attrTxt)
end
self.mainAttrRoot:setActive(true)
else
self.mainAttrRoot:setActive(false)
end


local secondaryAttrsList=self:getLianZhiAttrText(false)
if secondaryAttrsList and next(secondaryAttrsList)then
local lianZhiAttrWidget=self.secondaryAttrRoot:getWidgetBase()
lianZhiAttrWidget:SetChildText(secondaryAttrRootCmpIndex.title,"作为法宝辅助材料时，法宝基础属性")
local attrCount=#secondaryAttrsList
lianZhiAttrWidget:SetChildLayoutGroupCreateItems(secondaryAttrRootCmpIndex.descGridLayout,attrCount)
local descExGrid=lianZhiAttrWidget:GetChildLayoutGroupGridList(secondaryAttrRootCmpIndex.descGridLayout)
for i=1,descExGrid.Count do
local descItem=descExGrid[i-1]
local attrTxt=secondaryAttrsList[i]
descItem:SetChildText(0,attrTxt)
end
self.secondaryAttrRoot:setActive(true)
else
self.secondaryAttrRoot:setActive(false)
end
end

function UIFabaoMaterialTipsDescWin:getLianZhiAttrText(isMainMaterials)
local itemConfig=itemsConfig.getConfig(self.itemid)
local stage=itemConfig.stage
local baseRangeAttrs=fabaoHelper.getBaseAttrsRange(self.itemid,stage)
local elementRangeAttrs
if isMainMaterials then
elementRangeAttrs=fabaoHelper.getAllElementAttrsRange({self.itemid})
else
local attrid,elementRange=fabaoHelper.getElementRangeByConfig(self.itemid)
elementRangeAttrs={{attrid,elementRange}}
baseRangeAttrs={}
end

local attrTextList={}
for i,v in ipairs(baseRangeAttrs)do
local attrType=v[1]
local valTable=v[2]
local min=valTable[1]
local max=valTable[2]
local name,minstr=equipsHelper.getAttr(attrType,min)
local name,maxstr=equipsHelper.getAttr(attrType,max)
local attrStr=FMT.fmt('{0}：{1}~{2}',name,minstr,maxstr)
table.insert(attrTextList,attrStr)
end

for i,v in ipairs(elementRangeAttrs)do
local attrType=v[1]
local valTable=v[2]
local min=valTable[1]
local max=valTable[2]
local name,minstr=equipsHelper.getAttr(attrType,min)
local name,maxstr=equipsHelper.getAttr(attrType,max)
local attrStr
attrStr=FMT.fmt('{0}：{1}~{2}',name,minstr,maxstr)
table.insert(attrTextList,attrStr)
end

return attrTextList
end

function UIFabaoMaterialTipsDescWin:refreshLianHuaPanel()

local itemConfig=itemsConfig.getConfig(self.itemid)
local lianhua=itemConfig.lianhua
if lianhua and next(lianhua)then
local lianHuaAttrWidget=self.lianHuaAttrRoot:getWidgetBase()
lianHuaAttrWidget:SetChildText(lianHuaAttrRootCmpIndex.title,"法宝炼化属性")

local attrCount=#lianhua
lianHuaAttrWidget:SetChildLayoutGroupCreateItems(lianHuaAttrRootCmpIndex.descGridLayout,attrCount)
local descExGrid=lianHuaAttrWidget:GetChildLayoutGroupGridList(lianHuaAttrRootCmpIndex.descGridLayout)
for i=1,descExGrid.Count do
local descItem=descExGrid[i-1]
local attrCfg=lianhua[i]
local attrId=attrCfg[1]
local range=attrCfg[2]
local step=attrCfg[3]
local eroFormat=type(range[1])=='number'
local attrname,minstr=equipsHelper.getAttr(attrId,eroFormat and range[1]*step or range[1][1]*step)
local attrname,maxstr=equipsHelper.getAttr(attrId,eroFormat and range[2]*step or range[#range][2]*step)
local attrTxt=FMT.cfmt(FONT_COLOR.eTipWhiteColor,'{0}：{1}~{2}',attrname,minstr,maxstr)
descItem:SetChildText(0,attrTxt)
end
self.lianHuaAttrRoot:setActive(true)
else
self.lianHuaAttrRoot:setActive(false)
end



local lianHuaDescWidget=self.lianHuaDescRoot:getWidgetBase()

local descCfg=cfgHelper.getlang('fabaoMaterialTips_lianHua_desc')
local descStrList=string.split(descCfg,"\n")
for i,str in ipairs(descStrList)do
descStrList[i]=string.replaceSpace(str)
end
local descStr=table.concat(descStrList,'\n')
lianHuaDescWidget:SetChildText(lianHuaDescRootCmpIndex.desc,descStr)
end




function UIFabaoMaterialTipsDescWin:onClickMask()
self:closeSelf()
end