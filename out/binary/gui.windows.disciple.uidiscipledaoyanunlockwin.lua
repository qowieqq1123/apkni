







def_class("UIDiscipleDaoYanUnlockWin",UIWindowBase)









function UIDiscipleDaoYanUnlockWin:bindComponents()

self.desc=UIText.get(self,0)
self.effDY=UIObject.get(self,1)
self.effDYDi=UIObject.get(self,2)
self.gotoBtn=UIButton.get(self,3)
self.huoGrid=UIObject.get(self,4)
self.mbg=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.successEffect=UIObject.get(self,7)
self.titleBack=UIObject.get(self,8)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIDiscipleDaoYanUnlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.effDY);self.effDY=nil;
_UIObject_release(self.effDYDi);self.effDYDi=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.huoGrid);self.huoGrid=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
end
















local _this




function UIDiscipleDaoYanUnlockWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleDaoYanUnlockWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleDaoYanUnlockWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.discipleGuid
self.isShowGotoBtn=argtable.isShowGotoBtn
self.gotoBtn:setActive(self.isShowGotoBtn~=nil)
UIDiscipleModel:saveShowUnlockDaoYanTips(self.disciple_guid)

reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleDaoYan,self.disciple_guid)

local disName=UIDiscipleModel:getDiscipleName(self.disciple_guid)
self.desc:setText(FMT.fmt(cfgHelper.get1(cfg_lang_get,"disciple_daoyan_unlock_desc"),disName))

self.successEffect:setChildShowEffect(10010,true)

if afterOnloaded then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6190,0.85,nil,eAnimationID.enter3,false,false,0)

self:refreshAllFire(false)
self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.5)
tween:SetDelay(0.25)

self:delayDo(0.5,function()
if not _this then return end
local effId,effId2=UIDiscipleModel:getDiscipleDaoYanDZJYEffectId(3)
self.winlua:SetChildShowEffect(self.effDY:getID(),effId,true)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),effId2,true)

self:refreshAllFire(true)
end)
else
self:refreshAllFire(true)
end
end


function UIDiscipleDaoYanUnlockWin:onHide()

end

function UIDiscipleDaoYanUnlockWin:refreshAllFire(isShowEff)
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshFireItem(item,i,isShowEff)

item:SetChildButtonClick(0,function()
self:onFireItemClick(i)
end)
end
end

function UIDiscipleDaoYanUnlockWin:refreshFireItem(item,idx,isShowEff)
if item==nil then
item=self.huoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end

local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]

local skillCfg=cfg_skillconfig_get(skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
local effId=UIDiscipleModel:getDiscipleDaoYanSkillBgEffectId(idx)
item:SetChildCSImageIcon(0,skillIconName)
item:SetChildShowEffect(2,effId,isShowEff)
end

function UIDiscipleDaoYanUnlockWin:onFireItemClick(idx)
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]

UIManager:showWindow("UIDiscipleDaoYanSkillTipsWin",{skillId=skillId,isNotShowActive=true,guid=self.disciple_guid,isNotShowButton=true})
end



function UIDiscipleDaoYanUnlockWin:onGotoBtn()
UIFullCommonControl:jumpDiscipleMain(self.disciple_guid,FULL_TAB_TYPE.eDiscipleTianMing)
self:closeSelf()
end