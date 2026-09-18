







def_class("UIDiscipleDaoYanLockTipsWin",UIWindowBase)









function UIDiscipleDaoYanLockTipsWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.effDY=UIObject.get(self,1)
self.effDYDi=UIObject.get(self,2)
self.huoGrid=UIObject.get(self,3)
self.limitItem_1=UIObject.get(self,4)
self.limitItem_2=UIObject.get(self,5)
self.mbg=UIObject.get(self,6)
self.mDz=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.limitItem={
self.limitItem_1,
self.limitItem_2,
}



end


function UIDiscipleDaoYanLockTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effDY);self.effDY=nil;
_UIObject_release(self.effDYDi);self.effDYDi=nil;
_UIObject_release(self.huoGrid);self.huoGrid=nil;
_UIObject_release(self.limitItem_1);self.limitItem_1=nil;
_UIObject_release(self.limitItem_2);self.limitItem_2=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mDz);self.mDz=nil;
_UIObject_release(self.root);self.root=nil;
self.limitItem=nil;
end
















local _this




function UIDiscipleDaoYanLockTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleDaoYanLockTipsWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleDaoYanLockTipsWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.discipleGuid

self:refreshPanel()

if afterOnloaded then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6191,1,nil,eAnimationID.enter,false,false,0)

self.root:setChildCanvasGroupAlpha(0)
local tween=self.root:setChildCanvasGroupDOFade(1,0.5)
tween:SetDelay(0.25)

self:delayDo(0.5,function()
if not _this then return end
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mDz:getID(),false,true,false)
self.mDz:setChildUIModelShowTarget(6190,0.9,nil,eAnimationID.enter3,false,false,0)

local effId,effId2=UIDiscipleModel:getDiscipleDaoYanDZJYEffectId(3)
self.winlua:SetChildShowEffect(self.effDY:getID(),effId,true)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),effId2,true)

self:refreshAllFire()
end)
else
self:refreshAllFire()
end
end


function UIDiscipleDaoYanLockTipsWin:onHide()

end

function UIDiscipleDaoYanLockTipsWin:refreshPanel()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local limitList={}

local tm_limit=cfgHelper.getdef(cfg_discipledaoyanconfig,"open_tianming_limit")
if tm_limit then
local tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
local isUnlock1=tmlv>=tm_limit
local desc1=FMT.fmt('弟子天命达到{0}',UIDiscipleModel.getTianMingLevelDesc(tm_limit))
limitList[1]={desc=desc1,isUnlock=isUnlock1}
end

local jj_limit=cfgHelper.getdef(cfg_discipledaoyanconfig,"open_jingjie_limit")
if jj_limit then
local jjlv=UIDiscipleModel:getDiscipleJJLevelEx(netData)
local junpFunc2=function()
UIFullCommonControl:jumpDiscipleMain(self.disciple_guid,FULL_TAB_TYPE.eDiscipleInfo,nil,{isOpenSubJJWin=true})
end
local isUnlock2=jjlv>=jj_limit
local desc2=FMT.fmt('弟子境界达到{0}',UIDiscipleModel:getJJNameEx(jj_limit))
limitList[2]={desc=desc2,isUnlock=isUnlock2,junpFunc=junpFunc2}
end

for i=1,2 do
local widget=self.limitItem[i]:getChildWidgetBase()
local data=limitList[i]
self.limitItem[i]:setActive(data~=nil)
if data~=nil then
local color=data.isUnlock and"#f1ce78"or"#f36666"
widget:SetChildText(0,FMT.fmt("<color={0}>{1}</color>",color,data.desc))
widget:SetChildActive(1,data.isUnlock)
widget:SetChildActive(2,not data.isUnlock)
widget:SetChildButtonClick(2,function()
if data.junpFunc then
data.junpFunc()
end
_this:closeSelf()
end)
end
end
end

function UIDiscipleDaoYanLockTipsWin:refreshAllFire()
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshFireItem(item,i)

item:SetChildButtonClick(0,function()
self:onFireItemClick(i)
end)
end
end

function UIDiscipleDaoYanLockTipsWin:refreshFireItem(item,idx)
if item==nil then
item=self.huoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end

local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]

local skillCfg=cfg_skillconfig_get(skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
local effId=UIDiscipleModel:getDiscipleDaoYanSkillBgEffectId(idx)
item:SetChildCSImageIcon(0,skillIconName)
item:SetChildShowEffect(2,effId,true)
end

function UIDiscipleDaoYanLockTipsWin:onFireItemClick(idx)
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]

UIManager:showWindow("UIDiscipleDaoYanSkillTipsWin",{skillId=skillId,isActive=true,guid=self.disciple_guid,isNotShowButton=true})
end




function UIDiscipleDaoYanLockTipsWin:onCloseBtn()
self:closeSelf()
end

