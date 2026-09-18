







def_class("UIDiscipleDaoYanUpSkillWin",UIWindowBase)









function UIDiscipleDaoYanUpSkillWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.discipleModelRoot=UIObject.get(self,1)
self.huoGrid=UIObject.get(self,2)
self.imgbg2=UIObject.get(self,3)
self.mask=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.root2=UIObject.get(self,6)
self.skillDesc=UIText.get(self,7)
self.skillitem=UIObject.get(self,8)
self.skillitemdesc=UIText.get(self,9)
self.skillitemname=UIText.get(self,10)
self.skillpanel=UIObject.get(self,11)
self.successEffect=UIObject.get(self,12)
self.titleBack=UIObject.get(self,13)



end


function UIDiscipleDaoYanUpSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.huoGrid);self.huoGrid=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.skillitem);self.skillitem=nil;
_UIObject_release(self.skillitemdesc);self.skillitemdesc=nil;
_UIObject_release(self.skillitemname);self.skillitemname=nil;
_UIObject_release(self.skillpanel);self.skillpanel=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
end


















local _this



function UIDiscipleDaoYanUpSkillWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleDaoYanUpSkillWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleDaoYanUpSkillWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
self.dylv=argtable.dylv
self.olddylv=argtable.olddylv
self.newSkillIdx=argtable.newSkillIdx
local openFunc=argtable.openFunc
self:delayDo(0.1,function()
if openFunc then
openFunc()
end
end)

self.successEffect:setChildShowEffect(10010,true)

self.imgbg2:setActive(true)


self.discipleModelRoot:setChildUIModelRemoveTarget()
local args={isNotBg=true}
comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,0.85,nil,0,0,false,false,nil,args)
self.root2:setChildCanvasGroupAlpha(0)


self:refreshskillicon()


self:refreshAllFire()
self.skillpanel:setChildCanvasGroupAlpha(0)
self.attrPanel:setChildCanvasGroupAlpha(0)


self.root2:setChildCanvasGroupDOFade(1,0.7,nil)
local pos=self.winlua:GetChildLocalPosition(self.mask:getID())
self.winlua:SetChildLocalPosX(self.mask:getID(),pos.x-123)
self.winlua:SetChildDOLocalMoveX(self.mask:getID(),pos.x,0.3)

self:delayDo(0.35,function()
_this:doMyAnim()
end)
end

function UIDiscipleDaoYanUpSkillWin:doMyAnim()
local delay=0.3

_this:delayDo(delay,function()

local pos=_this.winlua:GetChildLocalPosition(_this.skillpanel:getID())
_this.winlua:SetChildLocalPosX(_this.skillpanel:getID(),pos.x+775)
_this.skillpanel:setChildCanvasGroupAlpha(1)
_this.winlua:SetChildDOLocalMoveX(_this.skillpanel:getID(),pos.x,0.2)
end)
delay=delay+0.1


_this:delayDo(delay,function()

local pos=_this.winlua:GetChildLocalPosition(_this.attrPanel:getID())
_this.winlua:SetChildLocalPosY(_this.attrPanel:getID(),pos.y-500)
_this.attrPanel:setChildCanvasGroupAlpha(1)
_this.winlua:SetChildDOLocalMoveY(_this.attrPanel:getID(),pos.y,0.2)
end)
delay=delay+0.1

_this:delayDo(delay,function()
local grids=_this.huoGrid:getChildCommonLayoutGroupWidgetList()
local item=grids[_this.newSkillIdx-1]
item:SetChildShowEffect(2,20681,true)
end)
delay=delay+0.9

_this:delayDo(delay,function()

local grids=_this.huoGrid:getChildCommonLayoutGroupWidgetList()
local item=grids[_this.newSkillIdx-1]
local skill=UIDiscipleModel:getDaoYanSkillByGuid(_this.disciple_guid,_this.newSkillIdx)
local skillCfg=cfg_skillconfig_get(skill[1])
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
item:SetChildCSImageIcon(1,skillIconName)
item:SetChildActive(3,false)
item:SetChildImageExGray(1,false)
item:SetChildActive(4,true)
end)
delay=delay+0.4

_this:delayDo(delay,function()
_this.imgbg2:setActive(false)
end)
end


function UIDiscipleDaoYanUpSkillWin:onHide()

end


function UIDiscipleDaoYanUpSkillWin:refreshskillicon()
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,self.newSkillIdx)
local skillId=skill[1]
local skillCfg=cfg_skillconfig_get(skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
local desc=skillModel:getSkillDesc(skillId,1)

local skillitem=self.skillitem:getWidgetBase()
skillitem:SetChildCSImageIcon(1,skillIconName)
self.winlua:SetChildText(self.skillitemname:getID(),FMT.fmt('<color=#ED7D31>{0}</color>',skillCfg.name))
self.winlua:SetChildText(self.skillitemdesc:getID(),FMT.fmt('<color=#92D050>已激活</color>'))
self.winlua:SetChildText(self.skillDesc:getID(),desc)
end

function UIDiscipleDaoYanUpSkillWin:refreshAllFire()
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshFireItem(item,i)

item:SetChildButtonClick(1,function()
self:onFireItemClick(i)
end)
end
end

function UIDiscipleDaoYanUpSkillWin:refreshFireItem(item,idx)
if item==nil then
item=self.huoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end

local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]
local limit=skill[2]
local isActive=self.olddylv>=limit
local skillCfg=cfg_skillconfig_get(skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
item:SetChildCSImageIcon(1,skillIconName)
item:SetChildActive(3,not isActive)
item:SetChildImageExGray(1,not isActive)
end

function UIDiscipleDaoYanUpSkillWin:onFireItemClick(idx)
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]
local limit=skill[2]
self:showWindow("UIDiscipleDaoYanSkillTipsWin",{skillId=skillId,isActive=self.dylv>=limit,limit=limit,guid=self.disciple_guid,isNotShowButton=true})
end



