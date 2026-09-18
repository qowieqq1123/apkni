







def_class("UIXJLittleWorldXingChenWin",UIWindowBase)








function UIXJLittleWorldXingChenWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.ciZhuiPanel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.emptyAttr=UIText.get(self,3)
self.emptyCiZhui=UIText.get(self,4)
self.emptyZhenxi=UIText.get(self,5)
self.fenjieButton=UIButton.get(self,6)
self.kongRoot=UIObject.get(self,7)
self.kongWidget_1=UIObject.get(self,8)
self.kongWidget_2=UIObject.get(self,9)
self.kongWidget_3=UIObject.get(self,10)
self.kongWidget_4=UIObject.get(self,11)
self.left=UIObject.get(self,12)
self.right=UIObject.get(self,13)
self.rongheButton=UIButton.get(self,14)
self.zhenxiPanel=UIObject.get(self,15)
self.wanfaButton=UIButton.get(self,16)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fenjieButton:setButtonClick(function()self:onFenjieButton()end)

self.rongheButton:setButtonClick(function()self:onRongheButton()end)

self.wanfaButton:setButtonClick(function()self:onWanfaButton()end)
self.kongWidget={
self.kongWidget_1,
self.kongWidget_2,
self.kongWidget_3,
self.kongWidget_4,
}



end


function UIXJLittleWorldXingChenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.ciZhuiPanel);self.ciZhuiPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptyAttr);self.emptyAttr=nil;
_UIObject_release(self.emptyCiZhui);self.emptyCiZhui=nil;
_UIObject_release(self.emptyZhenxi);self.emptyZhenxi=nil;
_UIObject_release(self.fenjieButton);self.fenjieButton=nil;
_UIObject_release(self.kongRoot);self.kongRoot=nil;
_UIObject_release(self.kongWidget_1);self.kongWidget_1=nil;
_UIObject_release(self.kongWidget_2);self.kongWidget_2=nil;
_UIObject_release(self.kongWidget_3);self.kongWidget_3=nil;
_UIObject_release(self.kongWidget_4);self.kongWidget_4=nil;
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.rongheButton);self.rongheButton=nil;
_UIObject_release(self.zhenxiPanel);self.zhenxiPanel=nil;
_UIObject_release(self.wanfaButton);self.wanfaButton=nil;
self.kongWidget=nil;
end



















function UIXJLittleWorldXingChenWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.onXCEquipChange,function(...)
self:refreshXingChenBtn()
end)
end


function UIXJLittleWorldXingChenWin:__delete()
self:unbindComponents()
end




function UIXJLittleWorldXingChenWin:onShow(argtable,afterOnloaded)
self.left:setChildAnchoredPos(-512,0)
local t=self.left:setChildDOAnchorPosX(0,0.5)

self.right:setChildAnchoredPos(512,0)
local t2=self.right:setChildDOAnchorPosX(0,0.5)

self:refreshLeft()
self:refreshRight()
argtable=argtable or{}
if argtable.playOpen then
UIManager:invokeUIMethod("UIPlanent","setAnimator",5)
UIManager:invokeUIMethod("UIPlanent","showStarHalo",true)
self.isThisShow=true
t:SetDelay(0.3)
t2:SetDelay(0.3)
end
UIManager:invokeUIMethod("UIPlanent","showStarAnim",true)
end

function UIXJLittleWorldXingChenWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIXJLittleWorldXingChenWin:onHide()
if self.isThisShow then


end
end

function UIXJLittleWorldXingChenWin:refreshLeft()
local slotList=xingChenBagModel:getPosData()

if self.kongWidget then
for idx,item in ipairs(self.kongWidget)do
local equip=slotList[idx]
self:refreshPos(idx,equip)
end
end

self:refreshXingChenBtn()
end

function UIXJLittleWorldXingChenWin:refreshPos(idx,equip)
local widget=self.kongWidget[idx]:getChildWidgetBase()
if equip then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)

local item=equip
local porp=itemsComponentHelper.getCommonFillData(item,{showCountBG=false,showcount=false,showname=false,showRare=true})
widget:SetChildPropData(4,porp)
widget:SetBaseItemClickEvent(4,function(...)

UIFullLittleWorldControl:showXingChenBagWindow({selectGroup=idx})
end)
widget:SetChildText(0,xingChenHelper.getXingChenName(item))
else
widget:SetChildActive(1,true)
widget:SetChildActive(2,false)
end
widget:SetChildText(5,FMT.fmt("{0}级",xingChenBagModel:getOrbitLevel(idx)))
widget:SetChildButtonClick(3,function()
UIFullLittleWorldControl:showXingChenBagWindow({selectGroup=idx})
end)
end

function UIXJLittleWorldXingChenWin:refreshXingChenBtn()
for idx,item in ipairs(self.kongWidget)do
local widget=self.kongWidget[idx]:getChildWidgetBase()
LittleWorldController:doPunchRotation(self,widget,6,idx,xingChenHelper.isSlotCanEquip(idx))
end
end

function UIXJLittleWorldXingChenWin:refreshRight()
self:refreshAttrs()
self:refreshAffixPanel()
self:refreshZhenXiPanel()

end

function UIXJLittleWorldXingChenWin:refreshAttrs()

local fixAttrs=xingChenHelper.getAllFixedAttr()
local fixLength=#fixAttrs
local growAttrList=xingChenHelper.getAllGrowAttrInWindow()
self.attrPanel:setChildLayoutGroupCreateItems(fixLength+#growAttrList)

local grids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=fixAttrs[i]
if attr then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
else
local gAttr=growAttrList[i-fixLength]
if gAttr then
local name,str=xingChenCiZhuiEffectController.getAttr(gAttr[1],gAttr[2])
grid:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
end
end
end
self.emptyAttr:setActive(#fixAttrs==0)

end

function UIXJLittleWorldXingChenWin:refreshAffixPanel()
local affixList=xingChenHelper.getAllAffix()
table.sort(affixList,function(a,b)
return cfgHelper.get(cfg_starsaffixconfig_get,a,"color")>cfgHelper.get(cfg_starsaffixconfig_get,b,"color")
end)
self.ciZhuiPanel:setChildLayoutGroupCreateItems(#affixList)

local grids=self.ciZhuiPanel:getChildLayoutGroupGridList(self.ciZhuiPanel)

if#affixList>0 then
for i=1,grids.Count do
local grid=grids[i-1]
local affix=affixList[i]

local config=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
end
end
self.emptyCiZhui:setActive(#affixList==0)
end

function UIXJLittleWorldXingChenWin:refreshZhenXiPanel()
local list=xingChenHelper.getAllZhenXi()
if next(list)then
self.zhenxiPanel:setActive(true)

local strList={}
for i,v in ipairs(list)do
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,v,"effects_adddesc")
for _,v2 in ipairs(zxConfig)do
table.insert(strList,v2)
end
end
self.zhenxiPanel:setChildLayoutGroupCreateItems(#strList)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,strList[i])
end

else
self.zhenxiPanel:setChildLayoutGroupCreateItems(0)
self.zhenxiPanel:setActive(false)

end
self.emptyZhenxi:setActive(false)
end




function UIXJLittleWorldXingChenWin:onCloseBtn()
UIManager:invokeUIMethod("UIPlanent","setAnimator",6)
UIManager:invokeUIMethod("UIPlanent","showStarHalo",false)

UIFullLittleWorldControl:showMainWindow()
end



function UIXJLittleWorldXingChenWin:onFenjieButton()
UIFullLittleWorldControl:showXingChenFenJieWindow()
end



function UIXJLittleWorldXingChenWin:onRongheButton()
UIFullLittleWorldControl:showXingChenRongHeWindow()
end

function UIXJLittleWorldXingChenWin:onWanfaButton()
local descFMT='xiaoshijie_%d'
self:showWindow('UIRuleScrollViewWin',{showBlack=true,mode=3,name=descFMT,title="规则介绍"})
end

