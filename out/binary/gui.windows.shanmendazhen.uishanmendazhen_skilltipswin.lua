







def_class("UIShanMenDaZhen_skillTipsWin",UIWindowBase)









function UIShanMenDaZhen_skillTipsWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.skillItem=UIObject.get(self,2)
self.title1=UIObject.get(self,3)
self.skillDesc=UIObject.get(self,4)
self.title2=UIObject.get(self,5)
self.upgradeCondition=UIObject.get(self,6)
self.displayBtn=UIButton.get(self,7)
self.displayTx=UIText.get(self,8)

self.displayBtn:setButtonClick(function()self:onDisplayBtn()end)



end


function UIShanMenDaZhen_skillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.upgradeCondition);self.upgradeCondition=nil;
_UIObject_release(self.displayBtn);self.displayBtn=nil;
_UIObject_release(self.displayTx);self.displayTx=nil;
end



















function UIShanMenDaZhen_skillTipsWin:onLoaded(...)
self:bindComponents()
end


function UIShanMenDaZhen_skillTipsWin:__delete()
self:unbindComponents()
end




function UIShanMenDaZhen_skillTipsWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
self.level=argtable.level
self.needDaZhenLv=argtable.needDaZhenLv
self.isBuffSkill=argtable.isBuffSkill
self.isClientSkill=argtable.isClientSkill
self.bdData=shanMenDaZhenModel:getShanMenBdData()
self.nowDaZhenLv=self.bdData.level-1
local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end

local pivotType=argtable and argtable.pivotType
if pivotType==1 then
self.root:setAnchors(0.5,0.5,0.5,1)
elseif pivotType==2 then
self.root:setAnchors(0.5,0.5,0.5,0)
else
self.root:setAnchors(0.5,0.5,0.5,0.5)
end

local pos=argtable and argtable.pos or{0,0}
if pos then
local pos_x=pos[1]or 0
local pos_y=pos[2]or 0
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local halfItemWidth=400/2
local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end
if pos_x+halfItemWidth>halfWidth then
pos_x=halfWidth-halfItemWidth
end

self.root:setChildAnchoredPos(pos_x,pos_y)
end

local isinit=afterOnloaded
if isinit then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.3,nil)
self.blackImg:setChildCanvasGroupAlpha(0)
end
self:refreshSkillView(isinit)
end


function UIShanMenDaZhen_skillTipsWin:onHide()

end

function UIShanMenDaZhen_skillTipsWin:refreshSkillView(isinit)
self.fadeList={}


local skillWidget=self.skillItem:getChildWidgetBase()
if isinit then
self.skillItem:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.skillItem)
end

local skillIcon
local skillName
local skillDescStr=""
local skillDescExList

if self.isBuffSkill then

local cfg=cfgHelper.get1(cfg_guildstateconfig_get,self.id)
skillIcon=iconHelper.getzmStateIcon(cfg.icon)
skillName=cfg.name
local txt=''
local effects=cfg.effects
for i,v in ipairs(effects)do
local effectid=effects[i]
local desc=homeBuffModel:getBuffDesc(effectid)
desc=string.replaceSpace(desc)
txt=txt~=''and FMT.fmt('{0}\n{1}',txt,desc)or desc
end
skillDescStr=txt
skillDescExList={}




















else

local ruleCfg=cfgHelper.getSSlawRule(self.id)
skillIcon=ruleCfg.image
skillName=ruleCfg.name
local desc=ruleCfg.desc
local attrdesc=ruleCfg.attrdesc
local descparm=ruleCfg.descparm
if descparm and descparm[self.level]and next(descparm[self.level])then
desc=string.format(desc,unpack(descparm[self.level]))
if attrdesc then
attrdesc=string.format(attrdesc,unpack(descparm[self.level]))
end
end
skillDescStr=desc
skillDescExList={attrdesc}
end

local isbd=false

local isActive=self.nowDaZhenLv>=self.needDaZhenLv
skillWidget:SetChildText(4,FMT.fmt("{0}级",self.level))
skillWidget:SetChildText(0,FMT.fmt(FONT_COLOR_FMT[FONT_COLOR.eTitle2Color],skillName))
skillWidget:SetChildIcon(1,skillIcon,false)
skillWidget:SetChildActive(2,isbd)

skillWidget:SetChildActive(3,false)


if isinit then
self.title1:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title1)
end


local skillDescWidget=self.skillDesc:getChildWidgetBase()
if isinit then
self.skillDesc:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.skillDesc)
end

skillDescWidget:SetChildText(0,skillDescStr)

local descExList=skillDescExList
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
skillDescWidget:SetChildLayoutGroupCreateItems(1,descExNum)
local descExGrid=skillDescWidget:GetChildLayoutGroupGridList(1)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end

local showUpgradeCondition=not isActive
self.upgradeCondition:setActive(showUpgradeCondition)
self.title2:setActive(showUpgradeCondition)
if showUpgradeCondition then

if isinit then
self.title2:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.title2)
end
local title2Widget=self.title2:getChildWidgetBase()
local str=''
if not isActive then
str='解锁条件'
end
title2Widget:SetChildText(0,str)


local upgradeConditionWidget=self.upgradeCondition:getChildWidgetBase()
if isinit then
self.upgradeCondition:setChildCanvasGroupAlpha(0)
table.insert(self.fadeList,self.upgradeCondition)
end
local cond_str=FMT.fmt('山门大阵：{0}级',self.needDaZhenLv)
upgradeConditionWidget:SetChildText(0,cond_str)
end

if isinit then
local func=function()
self:doFadeList()
end
self:delayDo(0.01,func)
end























end

function UIShanMenDaZhen_skillTipsWin:doFadeList()
for i,v in ipairs(self.fadeList)do
v:setChildCanvasGroupDOFade(1,0.1,nil)
end
end






function UIShanMenDaZhen_skillTipsWin:onDisplayBtn()
end

