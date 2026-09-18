







def_class("UISubAct_tgslZenYiLCWin",UIWindowBase)









function UISubAct_tgslZenYiLCWin:bindComponents()

self.fazeitem5=UIObject.get(self,0)
self.fazeitem4=UIObject.get(self,1)
self.fazeitem3=UIObject.get(self,2)
self.fazeitem2=UIObject.get(self,3)
self.fazeitem1=UIObject.get(self,4)
self.dizidesc2=UIText.get(self,5)
self.dizidesc1=UIText.get(self,6)
self.btnClose=UIButton.get(self,7)
self.titleText=UIText.get(self,8)
self.dizipanel=UIObject.get(self,9)
self.infoPanel=UIObject.get(self,10)
self.root=UIObject.get(self,11)
self.clickMask=UIButton.get(self,12)
self.blackBG=UIButton.get(self,13)
self.lingenpanel=UIObject.get(self,14)
self.linggenText=UIText.get(self,15)
self.lgimg=UIObject.get(self,16)
self.cuitipanel=UIObject.get(self,17)
self.cuitiText=UIText.get(self,18)
self.ctimg=UIObject.get(self,19)
self.cuitibtn=UIButton.get(self,20)
self.dizibtn=UIButton.get(self,21)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.blackBG:setButtonClick(function()self:onBlackBG()end)

self.cuitibtn:setButtonClick(function()self:onCuitibtn()end)

self.dizibtn:setButtonClick(function()self:onDizibtn()end)



end


function UISubAct_tgslZenYiLCWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fazeitem5);self.fazeitem5=nil;
_UIObject_release(self.fazeitem4);self.fazeitem4=nil;
_UIObject_release(self.fazeitem3);self.fazeitem3=nil;
_UIObject_release(self.fazeitem2);self.fazeitem2=nil;
_UIObject_release(self.fazeitem1);self.fazeitem1=nil;
_UIObject_release(self.dizidesc2);self.dizidesc2=nil;
_UIObject_release(self.dizidesc1);self.dizidesc1=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dizipanel);self.dizipanel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.lingenpanel);self.lingenpanel=nil;
_UIObject_release(self.linggenText);self.linggenText=nil;
_UIObject_release(self.lgimg);self.lgimg=nil;
_UIObject_release(self.cuitipanel);self.cuitipanel=nil;
_UIObject_release(self.cuitiText);self.cuitiText=nil;
_UIObject_release(self.ctimg);self.ctimg=nil;
_UIObject_release(self.cuitibtn);self.cuitibtn=nil;
_UIObject_release(self.dizibtn);self.dizibtn=nil;
end

















local _this
local abname=""
local tefighttype=8


function UISubAct_tgslZenYiLCWin:onLoaded(...)
self:bindComponents()
_this=self
self.fazeitem={self.fazeitem1,self.fazeitem2,self.fazeitem3,self.fazeitem4,self.fazeitem5,}
end


function UISubAct_tgslZenYiLCWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_tgslZenYiLCWin:onShow(argtable,afterOnloaded)
self.actId=argtable[1]
self.subType=argtable[2]
self.subId=argtable[3]
self.bossid=argtable[4]or 1

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.bossData=self.config.boss[self.bossid]
local lhidx=self.bossData[4]
local cfg_dizifaze=cfg_tsdzfzconfig_get(tefighttype)[lhidx]


if cfg_dizifaze.lg then

self.titleText:setText("灵根增益")
self.lingenpanel:setActive(true)
self.cuitipanel:setActive(false)



local dizifazedescArry=self.config.dizifazedesc



local dizixenyidesc=dizifazedescArry[lhidx]
for k,v in ipairs(self.fazeitem)do
local item=v:getWidgetBase()
local desc=dizixenyidesc[k]
if desc then
item:SetChildActive(0,true)
item:SetChildText(2,desc[1])
item:SetChildText(3,desc[2])
item:SetChildText(5,desc[3])

else
item:SetChildActive(0,false)
end
end
elseif cfg_dizifaze.ct then

self.titleText:setText("淬体增益")
self.lingenpanel:setActive(false)
self.cuitipanel:setActive(true)




local dizifazedescArry=self.config.dizifazedesc


local dizixenyidesc=dizifazedescArry[lhidx]
for k,v in ipairs(self.fazeitem)do
local item=v:getWidgetBase()
local desc=dizixenyidesc[k]
if desc then
item:SetChildActive(0,true)
item:SetChildText(2,desc[1])
item:SetChildText(3,desc[2])
item:SetChildText(5,desc[3])

else
item:SetChildActive(0,false)
end
end
end
end


function UISubAct_tgslZenYiLCWin:onHide()

end





function UISubAct_tgslZenYiLCWin:onFazebtn()
end

function UISubAct_tgslZenYiLCWin:onDizibtn()
end

function UISubAct_tgslZenYiLCWin:onSkillItem()
end

function UISubAct_tgslZenYiLCWin:onBtnClose()
self:closeSelf()
end
function UISubAct_tgslZenYiLCWin:onBlackBG()
self:closeSelf()
end
function UISubAct_tgslZenYiLCWin:onClickMask()
end


function UISubAct_tgslZenYiLCWin:onCuitibtn()
local d={}
d.title='淬体等级说明'
d.mode=3
d.name='fysl_rule_cuiti_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UISubAct_tgslZenYiLCWin:onDizibtn()
local subType=_this.subType
local subId=_this.subId


local closeCallback=function()
local sub_actList=activitiesModel:getActSubList_subType_subid_doing(subType,subId)
if#sub_actList>0 then
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=subType,subid=subId,extraParams={isopenlc=true}}},function()
jumpManager:clearJump()
end)
else
UIManager.error("活动已结束")
return UIFullDiscipleMainControl:closeUI()
end
end
UIFullDiscipleSelectControl:showDiscipleSelectWindow()
if closeCallback then
fullScreenUI.setNextActiveUICallback(closeCallback)
end
return true
end