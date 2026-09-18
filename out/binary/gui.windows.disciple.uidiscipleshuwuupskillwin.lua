







def_class("UIDiscipleShuWuUpSkillWin",UIWindowBase)









function UIDiscipleShuWuUpSkillWin:bindComponents()

self.imgbg2=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.root2=UIObject.get(self,2)
self.titleBack=UIObject.get(self,3)
self.titleTxt=UIText.get(self,4)
self.onepanel=UIObject.get(self,5)
self.twopanel=UIObject.get(self,6)
self.successEffect=UIObject.get(self,7)
self.descSlot=UIObject.get(self,8)
self.skillitem=UIObject.get(self,9)
self.skillitemname=UIText.get(self,10)
self.skillitemdesc=UIText.get(self,11)
self.mask=UIObject.get(self,12)
self.discipleModelRoot=UIObject.get(self,13)
self.huoGrid=UIObject.get(self,14)



end


function UIDiscipleShuWuUpSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.imgbg2);self.imgbg2=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.onepanel);self.onepanel=nil;
_UIObject_release(self.twopanel);self.twopanel=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.descSlot);self.descSlot=nil;
_UIObject_release(self.skillitem);self.skillitem=nil;
_UIObject_release(self.skillitemname);self.skillitemname=nil;
_UIObject_release(self.skillitemdesc);self.skillitemdesc=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.huoGrid);self.huoGrid=nil;
end
















local _this




function UIDiscipleShuWuUpSkillWin:onLoaded(...)
self:bindComponents()

_this=self
end


function UIDiscipleShuWuUpSkillWin:__delete()
self:unbindComponents()

_this=nil

UIManager:callWindowFunc('UIDiscipleShuWuSkillTipsWin','checkClose')
end




function UIDiscipleShuWuUpSkillWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dzId
self.netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local index=argtable.index

local level=self.netData.swList[index]
local isActive=level==1
self.titleTxt:setText(isActive and'技能激活'or'技能升级')

self.successEffect:setChildShowEffect(10010,true)
self.imgbg2:setActive(true)
self:delayDo(0.35,function()
self:doMyAnim2()
end)


self.discipleModelRoot:setChildUIModelRemoveTarget()
local args={isNotBg=true}
comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,0.85,nil,0,0,false,false,nil,args)
self.root2:setChildCanvasGroupAlpha(0)


self:refreshAllFire()

self:showShuWuTag()
self.onepanel:setChildCanvasGroupAlpha(0)

self:setShowSkill(index)
self.twopanel:setChildCanvasGroupAlpha(0)


self.root2:setChildCanvasGroupDOFade(1,0.7,nil)
local pos=self.winlua:GetChildLocalPosition(self.mask:getID())
self.winlua:SetChildLocalPosX(self.mask:getID(),pos.x-123)
self.winlua:SetChildDOLocalMoveX(self.mask:getID(),pos.x,0.3)
end


function UIDiscipleShuWuUpSkillWin:refreshAllFire()
local swcfg=UIDiscipleModel:getShuWuDZConfig(self.netData.id)
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local skillId=swcfg.skill[i]
local bShow=skillId~=nil
item:SetChildActive(-1,bShow)
if bShow then
local level=self.netData.swList[i]
local isActive=level>0
local info=cfgHelper.get1(cfg_discipleshuwuskillinfoconfig_get,skillId)
local icon=iconHelper.getSkillIcon(info.icon)
item:SetChildCSImageIcon(1,icon)
item:SetChildImageExGray(1,not isActive)
item:SetChildActive(4,not isActive)

item:SetChildButtonClick(1,function()
UIManager:showWindow('UIDiscipleShuWuSkillTipsWin',{id=skillId,level=level,
dzId=self.disciple_guid,noButton=true})
end)
end
end
end

function UIDiscipleShuWuUpSkillWin:setShowSkill(index)
local swcfg=UIDiscipleModel:getShuWuDZConfig(self.netData.id)
local skillId=swcfg.skill[index]
local level=self.netData.swList[index]
local info=cfgHelper.get1(cfg_discipleshuwuskillinfoconfig_get,skillId)
local icon=iconHelper.getSkillIcon(info.icon)
local skillCfg=cfgHelper.get2(cfg_discipleshuwuskillconfig_get,skillId,level)

local skillitem=self.skillitem:getWidgetBase()
skillitem:SetChildCSImageIcon(1,icon)
self.skillitemname:setText(info.name)
local desc=UIDiscipleModel:getShuWuSkillDesc(skillCfg.bonus[1],self.netData.id)
self.skillitemdesc:setText(desc)
end


function UIDiscipleShuWuUpSkillWin:showShuWuTag()
self.desclist=UIDiscipleModel:getDiscipleSpecialityConfig(self.disciple_guid,true)
local item=self.descSlot:getWidgetBase()
local cfg=self.desclist[1]
item:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(item,1)
end)
end

function UIDiscipleShuWuUpSkillWin:onDescSlotClick(item,index)
local cfg=self.desclist[index]
UIDiscipleModel.onClickClientSpeciality(item,self.netData,cfg,eDirectionType.eLeft)
end


function UIDiscipleShuWuUpSkillWin:onHide()

end

function UIDiscipleShuWuUpSkillWin:doMyAnim2()
local delay=0

_this:delayDo(delay,function()

local pos=self.winlua:GetChildLocalPosition(self.onepanel:getID())
self.winlua:SetChildLocalPosX(self.onepanel:getID(),pos.x+775)
self.onepanel:setChildCanvasGroupAlpha(1)
self.winlua:SetChildDOLocalMoveX(self.onepanel:getID(),pos.x,0.2)
end)
delay=delay+0.1


_this:delayDo(delay,function()


local pos=self.winlua:GetChildLocalPosition(self.twopanel:getID())

self.winlua:SetChildLocalPosY(self.twopanel:getID(),pos.y-500)

self.twopanel:setChildCanvasGroupAlpha(1)
self.winlua:SetChildDOLocalMoveY(self.twopanel:getID(),pos.y,0.2)
end)
delay=delay+0.1

_this:delayDo(delay,function()
_this.imgbg2:setActive(false)
end)
end



