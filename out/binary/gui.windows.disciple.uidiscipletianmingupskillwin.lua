







def_class("UIDiscipleTianMingUpSkillWin",UIWindowBase)









function UIDiscipleTianMingUpSkillWin:bindComponents()

self.root=UIObject.get(self,0)
self.tianmingNameTxt=UIText.get(self,1)
self.tianmingDescTxt=UIText.get(self,2)
self.tianmingIcon=UIImage.get(self,3)
self.titleBack=UIObject.get(self,4)
self.predisItem=UIObject.get(self,5)
self.disItem=UIObject.get(self,6)
self.attrGrid=UIObject.get(self,7)
self.tianmingObj=UIObject.get(self,8)
self.successEffect=UIObject.get(self,9)
self.arrowImg=UIObject.get(self,10)
self.discipleModelRoot=UIObject.get(self,11)
self.huoGrid=UIObject.get(self,12)
self.onepanel=UIObject.get(self,13)
self.descSlot=UIObject.get(self,14)
self.effect=UIObject.get(self,15)
self.effect2=UIObject.get(self,16)
self.effect3=UIObject.get(self,17)
self.effect4=UIObject.get(self,18)
self.effect5=UIObject.get(self,19)
self.effect6=UIObject.get(self,20)
self.root2=UIObject.get(self,21)
self.twopanel=UIObject.get(self,22)
self.skillitem=UIObject.get(self,23)
self.skillitemname=UIText.get(self,24)
self.skillitemdesc=UIText.get(self,25)
self.mask=UIObject.get(self,26)
self.imgbg2=UIObject.get(self,27)



end


function UIDiscipleTianMingUpSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tianmingNameTxt);self.tianmingNameTxt=nil;
_UIObject_release(self.tianmingDescTxt);self.tianmingDescTxt=nil;
_UIObject_release(self.tianmingIcon);self.tianmingIcon=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.predisItem);self.predisItem=nil;
_UIObject_release(self.disItem);self.disItem=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.tianmingObj);self.tianmingObj=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.arrowImg);self.arrowImg=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.huoGrid);self.huoGrid=nil;
_UIObject_release(self.onepanel);self.onepanel=nil;
_UIObject_release(self.descSlot);self.descSlot=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.effect6);self.effect6=nil;
_UIObject_release(self.root2);self.root2=nil;
_UIObject_release(self.twopanel);self.twopanel=nil;
_UIObject_release(self.skillitem);self.skillitem=nil;
_UIObject_release(self.skillitemname);self.skillitemname=nil;
_UIObject_release(self.skillitemdesc);self.skillitemdesc=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
end

















local _this


function UIDiscipleTianMingUpSkillWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleTianMingUpSkillWin:__delete()
self:unbindComponents()
local isUnlockDY=UIDiscipleModel:getDiscipleDaoYanUnLockReddot(self.disciple_guid)
if isUnlockDY then
UIManager:invokeUIMethod('UIDiscipleTianMingWin','onUnlockDY',self.disciple_guid)
end
_this=nil
end




function UIDiscipleTianMingUpSkillWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
local tmlv=argtable.tmlv
local oldtmlv=argtable.oldtmlv
self.tmlv=tmlv
self.oldtmlv=oldtmlv


self.successEffect:setChildShowEffect(10010,true)

self.imgbg2:setActive(true)



self.discipleModelRoot:setChildUIModelRemoveTarget()
local args={isNotBg=true}
comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,0.85,nil,0,0,false,false,nil,args)
self.root2:setChildCanvasGroupAlpha(0)


self:tianmingSkill()
self.attrGrid:setChildCanvasGroupAlpha(0)


self:refreshAllFire()


self:dizitianmingtag()
self.onepanel:setChildCanvasGroupAlpha(0)


self.twopanel:setChildCanvasGroupAlpha(0)
self:refreshskillicon()


self:delayDo(0.5,function()

end)


self.root2:setChildCanvasGroupDOFade(1,0.7,nil)
local pos=self.winlua:GetChildLocalPosition(self.mask:getID())
self.winlua:SetChildLocalPosX(self.mask:getID(),pos.x-123)
self.winlua:SetChildDOLocalMoveX(self.mask:getID(),pos.x,0.3)

local nextdelay=0.2*_this.attrNum+0.8
self:delayDo(0.35,function()
self:doMyAnim2()
end)

end

function UIDiscipleTianMingUpSkillWin:doMyAnim()
local delay=0
_this.attrGrid:setChildCanvasGroupAlpha(1)
local gridlist=_this.attrGrid:getChildCommonLayoutGroupWidgetList()
_this.winlua:SetChildLayoutGroupEnable(_this.attrGrid:getID(),false)
for i=1,_this.attrNum do
local item=gridlist[i-1]
item:SetChildActive(-1,false)
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosX(-1,pos.x+775)
_this:delayDo(delay,function()
item:SetChildActive(-1,true)
item:SetChildDOLocalMoveX(-1,pos.x,0.3)
end)
delay=delay+0.2
end

end

function UIDiscipleTianMingUpSkillWin:doMyAnim3()
local delay=0

local gridlist=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local item_cur=gridlist[_this.cur_idx-1]

item_cur:SetChildActive(7,false)
item_cur:SetChildText(4,FMT.fmt('<color=#ED7D31>{0}</color>',_this.cur_desc[1]))
item_cur:SetChildText(6,FMT.fmt('<color=#CACACA>{0}</color>',_this.cur_desc[2]))


local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
local item=grids[_this.cur_idx]
item:SetChildShowEffect(2,10460,true)
local floor=_this.cur_floor
local tmID=UIDiscipleModel:getTianMingByIndex(self.disciple_guid,floor+1)
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
item:SetChildCSImageIcon(1,skillIconName)
item:SetChildActive(4,false)
item:SetChildImageExGray(1,false)

delay=delay+0.8


_this:delayDo(delay,function()
self.onepanel:setChildCanvasGroupDOFade(0,0.8,nil)
for i=1,6 do
local item2=gridlist[i-1]
if i<=4 then
if i~=_this.cur_idx then
item2:SetChildCanvasGroupDOFade(-1,0,0.5,nil)
end
end
end
end)
delay=delay+0.3

_this:delayDo(delay,function()

item_cur:SetChildDOLocalMoveY(-1,-130,0.5)



local pos=self.winlua:GetChildLocalPosition(self.twopanel:getID())
self.winlua:SetChildLocalPosX(self.twopanel:getID(),pos.x+775)

self.twopanel:setChildCanvasGroupAlpha(1)
self.winlua:SetChildDOLocalMoveX(self.twopanel:getID(),pos.x,0.5)
end)

end

function UIDiscipleTianMingUpSkillWin:doMyAnim2()
local delay=0



local gridlist=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local item_cur=gridlist[_this.cur_idx-1]

item_cur:SetChildActive(7,false)
item_cur:SetChildText(4,FMT.fmt('<color=#ED7D31>{0}</color>',_this.cur_desc[1]))
item_cur:SetChildText(6,FMT.fmt('<color=#CACACA>{0}</color>',_this.cur_desc[2]))

delay=delay+0.1

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

_this.attrGrid:setChildCanvasGroupAlpha(1)
item_cur:SetChildDOLocalMoveY(-1,-140,0.2)
end)
delay=delay+0.1

_this:delayDo(delay,function()
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
local item=grids[_this.cur_idx]
item:SetChildShowEffect(2,10460,true)
end)
delay=delay+0.9

_this:delayDo(delay,function()

local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
local item=grids[_this.cur_idx]
local floor=_this.cur_floor
local tmID=UIDiscipleModel:getTianMingByIndex(self.disciple_guid,floor+1)
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
item:SetChildCSImageIcon(1,skillIconName)
item:SetChildActive(4,false)
item:SetChildImageExGray(1,false)
item:SetChildActive(5,true)
end)
delay=delay+0.4

_this:delayDo(delay,function()
_this.imgbg2:setActive(false)
end)
end


function UIDiscipleTianMingUpSkillWin:onHide()

end





function UIDiscipleTianMingUpSkillWin:refreshskillicon()
local floor=_this.cur_floor
local tmID=UIDiscipleModel:getTianMingByIndex(self.disciple_guid,floor+1)
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)

local skillitem=self.skillitem:getWidgetBase()
skillitem:SetChildCSImageIcon(1,skillIconName)
self.winlua:SetChildText(self.skillitemname:getID(),FMT.fmt('<color=#ED7D31>{0}</color>',tmCfg.name))
self.winlua:SetChildText(self.skillitemdesc:getID(),FMT.fmt('<color=#92D050>已激活</color>'))
end

function UIDiscipleTianMingUpSkillWin:tianmingSkill()
local attrNum=0
local gridlist=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local c=gridlist.Count
for i=1,6 do
local item=gridlist[i-1]

local floor=i
if i<=4 then
local cur_floor_new=UIDiscipleModel.getTianMingLevelFloor(self.tmlv)
if cur_floor_new==floor then
item:SetChildActive(-1,true)
attrNum=attrNum+1
local tmIndex=floor+1
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local tmID=UIDiscipleModel:getTianMingByIndex(self.disciple_guid,tmIndex)
local tmcfg=nil
if tmID then
tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
end
local cur_floor=UIDiscipleModel.getTianMingLevelFloor(self.oldtmlv)
local isActive=floor<=cur_floor


local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)

item:SetChildCSImageSprite(5,abName,iconName)
item:SetChildCSImageSprite(7,abName,iconName)
item:SetChildActive(7,not isActive)

local name_str
if tmIndex==6 then
name_str=UIDiscipleModel.getTianMingName('赐福')
else
local name=tmcfg.name
name_str=UIDiscipleModel.getTianMingName(name)
end

local desc_str=UIDiscipleModel.getTianMingDesc(tmcfg,jobid)
if isActive then
item:SetChildText(4,name_str)
item:SetChildText(6,desc_str)
else
item:SetChildText(4,FMT.fmt('<color=#827f78>{0}</color>',name_str))
item:SetChildText(6,FMT.fmt('<color=#827f78>{0}</color>',desc_str))
end
item:SetChildLocalPosY(-1,-500)


_this.cur_floor=cur_floor_new
_this.cur_idx=i
_this.cur_desc={name_str,desc_str}
else
item:SetChildActive(-1,false)
end
else
item:SetChildActive(-1,false)
end
end
self.attrNum=attrNum
end



function UIDiscipleTianMingUpSkillWin:dizitianmingtag()

self.desclist=UIDiscipleModel:getDiscipleSpecialityConfig(self.disciple_guid,true)
local item=self.descSlot:getWidgetBase()
local cfg=self.desclist[1]
item:SetChildActive(-1,true)
UIDiscipleModel.refreshSpecialityItem(item,cfg,function()
self:onDescSlotClick(1)
end)
end

function UIDiscipleTianMingUpSkillWin:onDescSlotClick(idx)
local cfg=self.desclist[idx]
local item=self.descSlot:getWidgetBase()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
if UIDiscipleModel.onClickClientSpeciality(item,netData,cfg,eDirectionType.eLeft)then
return
end
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.disciple_guid,config=cfg})
end


function UIDiscipleTianMingUpSkillWin:refreshAllFire()
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshFireItem(item,i)

item:SetChildButtonClick(1,function()
self:onFireItemClick(i)
end)
end
end
function UIDiscipleTianMingUpSkillWin:refreshFireItem(item,idx,anim)
if item==nil then
item=self.huoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local floor=idx-1
local cur_floor=UIDiscipleModel.getTianMingLevelFloor(self.oldtmlv)
local isActive=floor<=cur_floor
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)

local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,netData.tmList[idx]or 0)
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
item:SetChildCSImageIcon(1,skillIconName)
item:SetChildActive(4,not isActive)
item:SetChildImageExGray(1,not isActive)
end
function UIDiscipleTianMingUpSkillWin:onFireItemClick(idx)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local tmIndex=idx
local tmID=UIDiscipleModel:getTianMingByIndexEx(netData,tmIndex)
self:showWindow("UIDiscipleTianMingSkillTipsWin",{tmId=tmID,tmLv=netData.tmlv,tmIndex=idx,guid=self.disciple_guid,isNotShowButton=true})
end
