







def_class("UILZHHSkillWin",UIWindowBase)









function UILZHHSkillWin:bindComponents()

self.name=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.desc=UIText.get(self,2)
self.applyBtn=UIButton.get(self,3)
self.applyBtnText=UIText.get(self,4)
self.useCount=UIText.get(self,5)
self.useTextRoot=UIObject.get(self,6)
self.useCost=UIText.get(self,7)
self.useCostIcon=UIImage.get(self,8)
self.giveUpBtn=UIButton.get(self,9)
self.mask=UIButton.get(self,10)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.giveUpBtn:setButtonClick(function()self:onGiveUpBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UILZHHSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.applyBtnText);self.applyBtnText=nil;
_UIObject_release(self.useCount);self.useCount=nil;
_UIObject_release(self.useTextRoot);self.useTextRoot=nil;
_UIObject_release(self.useCost);self.useCost=nil;
_UIObject_release(self.useCostIcon);self.useCostIcon=nil;
_UIObject_release(self.giveUpBtn);self.giveUpBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
end















local _skillIconAbName="ui/windows/lzpz/lingzhenpengzhuang_atlas_pak.ab"
local _this



function UILZHHSkillWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UILZHHSkillWin:__delete()
self:unbindComponents()

UIManager:callWindowFunc('UILingZhenPZGameWin','resetCDTimer')
end




function UILZHHSkillWin:onShow(argtable,afterOnloaded)
self.id=argtable.id
self.actid=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
local count=argtable.count

self.count=count
local cfg=cfgHelper.get1(cfg_lzpzskillinfoconfig_get,self.id)
self.name:setText(cfg.name)
self.desc:setText(cfg.desc)
local skillIconName=cfg.iconName
if skillIconName then
self.icon:setSprite(_skillIconAbName,skillIconName)
end

local fdata=cfgHelper.get2(cfg_lingzhenhuihuaconfig_get,self.subid,'func')
local max=cfg.maxUseCount or-1
self.cost=fdata[self.id][2]
local remainingCount=0
if max>0 then
remainingCount=max-count
else
remainingCount=-1
end
self.remainingCount=remainingCount










if remainingCount==-1 or remainingCount>0 then
local data=self.cost[1]
if data then
self.useTextRoot:setActive(true)
self.useCost:setActive(true)
self.useCount:setActive(false)
local costCount=data[2]
local costItemId=data[1]
self.useCost:setText(costCount)
self.useCostIcon:setImageIcon(iconHelper.getIconName(costItemId),false)
else
self.useTextRoot:setActive(false)
end

local buttonName=cfg.useButtonName or"使用"
if remainingCount>0 then
self.applyBtnText:setText(FMT.fmt("{0}({1}/{2})",buttonName,remainingCount,max))
else
self.applyBtnText:setText(FMT.fmt("{0}",buttonName))
end
else
self.useTextRoot:setActive(true)
self.useCount:setActive(true)
self.useCost:setActive(false)
self.useCount:setText(FMT.fmt('({0}/{1})',remainingCount,max))
self.applyBtnText:setText('无法使用')
end

self.giveUpBtn:setActive(self.id==4)
end


function UILZHHSkillWin:onHide()

end





function UILZHHSkillWin:onApplyBtn()














if self.remainingCount==-1 or self.remainingCount>0 then
local data=self.cost[1]
if data then

moneySystem:useMoney(data[1],data[2],function()

activitiesHandle_lingzhendiaoke:reqUseSkill(_this.actid,_this.subType,_this.subid,self.id)
self:closeSelf()
end,WARNING_TYPE.eWarning)
else

UIManager:callWindowFunc('UILingZhenHHGameExWin','handleSkill',self.id)
self:closeSelf()
end


else
UIManager.error('无法使用')
end
end

function UILZHHSkillWin:onCloseClick()
local id=self.id
if id==4 then
local okCB=function()
UIManager:callWindowFunc('UILingZhenHHGameExWin','showFailureWin')
self:closeSelf()
end
local dialog=UIDialogManager.getConfirmDialog(nil,'提示','是否放弃复活进行结算？','确定','取消',okCB)
dialog:show()
else
self:closeSelf()
end
end

function UILZHHSkillWin:onGiveUpBtn()
self:onCloseClick()
end

function UILZHHSkillWin:onMask()
self:onCloseClick()
end