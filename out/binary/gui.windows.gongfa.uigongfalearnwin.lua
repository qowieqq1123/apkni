







def_class("UIGongFaLearnWin",UIWindowBase)









function UIGongFaLearnWin:bindComponents()

self.gfItem=UIObject.get(self,0)
self.skillGrid=UIObject.get(self,1)
self.descText=UIText.get(self,2)
self.okButtonIcon=UIObject.get(self,3)



end


function UIGongFaLearnWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.skillGrid);self.skillGrid=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.okButtonIcon);self.okButtonIcon=nil;
end

















function UIGongFaLearnWin:onLoaded(...)
self:bindComponents()
end


function UIGongFaLearnWin:__delete()
self:unbindComponents()
end


function UIGongFaLearnWin:onHide()

end




function UIGongFaLearnWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.gfID=argtable.gfID

self:refreshView()
end

function UIGongFaLearnWin:refreshView()

local gfItemWidget=self.gfItem:getChildWidgetBase()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
gfItemWidget:SetChildCSImageSprite(0,globalABLookup.cangjingge,colorIcon)
gfItemWidget:SetChildIcon(1,iconHelper.getGongFaIcon(cfg.icon),false)
gfItemWidget:SetChildText(2,cfg.name)


local skils=cfg.skill
local skillGrid=self.skillGrid:getChildCommonLayoutGroupWidgetList()
for i=1,2 do
local skillID=skils[i]
local hasSkill=skillID~=nil
local item=skillGrid[i-1]
item:SetChildActive(4,hasSkill)
if hasSkill then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)
item:SetChildText(2,skillCfg.name)
item:SetChildButtonClick(3,function()
self:onSkillItemClick(skillID,1)
end)
end
end


local money_str=''
local needmoney=UIGongFaModel:getGFConsume(self.disciple_guid,self.gfID)
local money_str=''
local canlearn=UIGongFaModel:enoughMoneyLearnGF(self.disciple_guid,self.gfID)
if canlearn then
money_str=string.format('<color=#549327>%d</color>',needmoney)
else
money_str=string.format('<color=#c82c2c>%d</color>',needmoney)
end
local desc_str=FMT.fmt('修炼所需传道点数：{0}',money_str)
self.descText:setText(desc_str)


self.okButtonIcon:setGray(not canlearn)
end


function UIGongFaLearnWin:onOkButton()
if not UIGongFaModel:enoughMoneyLearnGF(self.disciple_guid,self.gfID,true)then
return
end

local cur=UIDiscipleModel:getDiscipleAllGFNum(self.disciple_guid)
local max=UIGongFaModel:getLearnGFMaxNum()
if cur>=max then
UIManager.error(FMT.fmt('弟子最多只能修炼{0}本功法哦',max))
return
end

UIGongFaController:reqDiscipleLearn(self.disciple_guid,self.gfID)
self:closeSelf()
end

function UIGongFaLearnWin:onSkillItemClick(skillID,skillLv)

end