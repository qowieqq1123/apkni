







def_class("UIGongFaSkillUpWin",UIWindowBase)









function UIGongFaSkillUpWin:bindComponents()

self.fourPanel=UIObject.get(self,0)
self.onePanel=UIObject.get(self,1)
self.skillItem=UIObject.get(self,2)
self.successEffect=UIObject.get(self,3)
self.threePanel=UIObject.get(self,4)
self.titleBack=UIObject.get(self,5)
self.twoPanel=UIObject.get(self,6)



end


function UIGongFaSkillUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fourPanel);self.fourPanel=nil;
_UIObject_release(self.onePanel);self.onePanel=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.threePanel);self.threePanel=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.twoPanel);self.twoPanel=nil;
end



















local _this


function UIGongFaSkillUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIGongFaSkillUpWin:__delete()
self.successEffect:setChildShowEffect(10010,false)
self:unbindComponents()
end




function UIGongFaSkillUpWin:onShow(argtable,afterOnloaded)
self.successEffect:setChildShowEffect(10010,true)

local disciple_guid=argtable.diziGuid
local gfID=argtable.gfID
local skillID=argtable.skillID
local discipleGFNetData=UIDiscipleModel:getDiscipleGFData(disciple_guid,gfID)
local gfLv=discipleGFNetData.param_2
local skillLv=UIGongFaModel:getSkillLvInGongFa(gfID,gfLv,skillID)

self.skillItem:setChildCanvasGroupAlpha(0)
self.onePanel:setChildCanvasGroupAlpha(0)
self.twoPanel:setChildCanvasGroupAlpha(0)
self.threePanel:setChildCanvasGroupAlpha(0)
self.fourPanel:setChildCanvasGroupAlpha(0)

local itemWidget=self.skillItem:getChildWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
itemWidget:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
itemWidget:SetChildText(10,is_bd and"被动技能"or"主动技能")
itemWidget:SetChildActive(1,is_bd)
itemWidget:SetChildText(2,skillCfg.name)
itemWidget:SetChildActive(11,true)
itemWidget:SetChildActive(3,false)
itemWidget:SetChildActive(7,false)
itemWidget:SetChildActive(8,false)

local desc_str=skillModel:getSkillDesc(skillID,skillLv)
itemWidget:SetChildText(4,desc_str)

local descExList=skillModel:getSkillDescEx(skillID,skillLv)
local hoardDescEx=skillModel:getSkillHoardDescEx(disciple_guid,gfID,skillID,skillLv)
descExList=table.concatTableX(descExList or{},hoardDescEx)
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0
itemWidget:SetChildActive(9,showDescEx)
if showDescEx then
itemWidget:SetChildLayoutGroupCreateItems(9,descExNum)
local descExGrid=itemWidget:GetChildLayoutGroupGridList(9)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
end
end

local coolDown=skillModel:getSkillCooldownTime(skillID,skillLv)
local isCoolDown=coolDown>0
itemWidget:SetChildActive(5,isCoolDown)
if isCoolDown then
local cooldown_str=FMT.fmt('冷却：{0}回合',coolDown)
itemWidget:SetChildText(6,cooldown_str)
end

local func=function()
self:doMyAnim()
end
self:delayDo(0.01,func)
end

function UIGongFaSkillUpWin:doMyAnim()
local delay=0

self.skillItem:setChildCanvasGroupAlpha(1)

_this:delayDo(delay,function()
local pos=self.winlua:GetChildLocalPosition(self.onePanel:getID())
self.winlua:SetChildLocalPosY(self.onePanel:getID(),pos.y-500)
self.onePanel:setChildCanvasGroupAlpha(1)
self.winlua:SetChildDOLocalMoveY(self.onePanel:getID(),pos.y,0.2)
end)
delay=delay+0.1

_this:delayDo(delay,function()
local pos=self.winlua:GetChildLocalPosition(self.twoPanel:getID())
self.winlua:SetChildLocalPosY(self.twoPanel:getID(),pos.y-500)
self.twoPanel:setChildCanvasGroupAlpha(1)
self.winlua:SetChildDOLocalMoveY(self.twoPanel:getID(),pos.y,0.2)
end)
delay=delay+0.1

local threePos=self.winlua:GetChildLocalPosition(self.threePanel:getID())
_this:delayDo(delay,function()
self.winlua:SetChildLocalPosY(self.threePanel:getID(),threePos.y-500)
self.threePanel:setChildCanvasGroupAlpha(1)
self.winlua:SetChildDOLocalMoveY(self.threePanel:getID(),threePos.y,0.2)
end)
delay=delay+0.1

_this:delayDo(delay,function()
local transform=self.threePanel:getTransform()
local _h=transform.sizeDelta.y
self.winlua:SetChildLocalPosY(self.fourPanel:getID(),threePos.y-_h-505)
self.fourPanel:setChildCanvasGroupAlpha(1)
self.winlua:SetChildDOLocalMoveY(self.fourPanel:getID(),threePos.y-_h-5,0.2)
end)
end


function UIGongFaSkillUpWin:onHide()

end



