







def_class("UIDiscipleDaoYanSkillTipsWin",UIWindowBase)









function UIDiscipleDaoYanSkillTipsWin:bindComponents()

self.botton=UIObject.get(self,0)
self.changeroot=UIObject.get(self,1)
self.changeScrollView=UIObject.get(self,2)
self.conditiontxt=UIText.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.line=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.skillDesc=UIText.get(self,7)
self.skillIcon=UIObject.get(self,8)
self.skillName=UIText.get(self,9)
self.stateInfo=UIText.get(self,10)
self.top=UIObject.get(self,11)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIDiscipleDaoYanSkillTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.botton);self.botton=nil;
_UIObject_release(self.changeroot);self.changeroot=nil;
_UIObject_release(self.changeScrollView);self.changeScrollView=nil;
_UIObject_release(self.conditiontxt);self.conditiontxt=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.skillName);self.skillName=nil;
_UIObject_release(self.stateInfo);self.stateInfo=nil;
_UIObject_release(self.top);self.top=nil;
end



















function UIDiscipleDaoYanSkillTipsWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleDaoYanSkillTipsWin:__delete()
self:unbindComponents()
end




function UIDiscipleDaoYanSkillTipsWin:onShow(argtable,afterOnloaded)
self.skillId=argtable.skillId or 0
self.isActive=argtable.isActive or false
self.limit=argtable.limit or 0
self.guid=argtable.guid
self.isNotShowButton=argtable.isNotShowButton
self.isNotShowActive=argtable.isNotShowActive

self.gotoBtn:setActive(not self.isNotShowButton)

local skillCfg=cfg_skillconfig_get(self.skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
self.skillIcon:setChildIcon(skillIconName,false)
local skillNameStr=skillCfg.name
local strTable=string.toTable(skillNameStr)
local newStrTable={}

if pfwindowslController:checkIsGameVersion_yuenan()then
if#strTable>25 then
skillNameStr=FMT.fmt("{0}...",utf8.sub(skillNameStr,1,25))
end
else
if#strTable>5 then
for i=1,4 do
newStrTable[i]=strTable[i]
end
skillNameStr=table.concat(newStrTable,"")
skillNameStr=FMT.fmt("{0}...",skillNameStr)
end
end

self.skillName:setText(skillNameStr)

self.stateInfo:setActive(not self.isNotShowActive)
if not self.isNotShowActive then
if self.isActive then
self.stateInfo:setText(FMT.fmt("<color={0}>已激活</color>","#aae252"))
else
self.stateInfo:setText(FMT.fmt("<color={0}>未激活</color>","#cacaca"))
end
end

local desc=skillModel:getSkillDesc(self.skillId,1)
self.skillDesc:setText(desc)

self.line:setActive(not self.isActive)
self.botton:setActive(not self.isActive)
if not self.isActive then
self.conditiontxt:setText(UIDiscipleModel.getDaoYanLevelDesc(self.limit,2))
end


local changeStateList=skillModel:getSkillGiveStateList(self.skillId,1)
if self.guid then
local boradStateList=UIDiscipleModel:getDiscipleHoardEffectBySkillId(self.guid,self.skillId)
changeStateList=table.concatTable(changeStateList,boradStateList)
end
local isHasFT=changeStateList~=nil and#(changeStateList or{})>0
self.changeroot:setActive(isHasFT)
if not self.customPos then
self.root:setChildAnchoredPos(isHasFT and-200 or 0,-10)
end
if isHasFT then
self.changeroot:setChildLayoutGroupCreateItems(#changeStateList,function(index)
local item=self.changeroot:getChildLayoutGroupGridItem(index-1)
local data=changeStateList[index]
local stateIcon=data.stateType==1 and"icon_zengyi"or"icon_jianyi"
item:SetChildText(1,data.stateName)
item:SetChildIcon(0,iconHelper.getBuffIcon(data.stateIconId),false)
item:SetChildText(3,data.desc)
item:SetChildCSImageSprite(2,globalABLookup.global,stateIcon)
end)
end
end


function UIDiscipleDaoYanSkillTipsWin:onHide()

end




function UIDiscipleDaoYanSkillTipsWin:onGotoBtn()
UIFullDiscipleMainControl:showWindowTianMing({guid=self.guid,dis_guid=self.guid})
self:closeSelf()
end
