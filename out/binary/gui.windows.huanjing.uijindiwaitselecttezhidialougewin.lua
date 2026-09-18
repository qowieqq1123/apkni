







def_class("UIJinDiWaitSelectTeZhiDialougeWin",UIWindowBase)









function UIJinDiWaitSelectTeZhiDialougeWin:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.content=UIObject.get(self,3)
self.goButton=UIButton.get(self,4)
self.goTxt=UIText.get(self,5)
self.okButton=UIButton.get(self,6)
self.okText=UIText.get(self,7)
self.okTipsText=UIText.get(self,8)
self.tips=UIText.get(self,9)
self.titleText=UIText.get(self,10)
self.tzSlot=UIObject.get(self,11)
self.tztxtpre=UIText.get(self,12)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.goButton:setButtonClick(function()self:onGoButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIJinDiWaitSelectTeZhiDialougeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.goButton);self.goButton=nil;
_UIObject_release(self.goTxt);self.goTxt=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.okTipsText);self.okTipsText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.tzSlot);self.tzSlot=nil;
_UIObject_release(self.tztxtpre);self.tztxtpre=nil;
end
















local _clickBtnCD=1

local _specialSituationType={
normal=0,
fullTeZhi=1,
tezhiHuChi=2,
}




function UIJinDiWaitSelectTeZhiDialougeWin:onLoaded(...)
self:bindComponents()

self.clickBtnStamp=0
self.selectOptionIdx=-1

local _recv_25_14=function(...)
self:recv_25_14(...)
end
self:addProNotify(25,14,_recv_25_14)
end


function UIJinDiWaitSelectTeZhiDialougeWin:__delete()
self:unbindComponents()
end




function UIJinDiWaitSelectTeZhiDialougeWin:onShow(argtable,afterOnloaded)
self.jdid=argtable.jdid
self.waitSelectData=argtable.waitSelectData

self.toDisciple=self.waitSelectData.param_1
self.specialityType=self.waitSelectData.param_2
self.specialityId=self.waitSelectData.param_3



local result,args=self:checkSpecialSituation()

local isNormal=result==_specialSituationType.normal
local isFull=result==_specialSituationType.fullTeZhi
local isHuChi=result==_specialSituationType.tezhiHuChi

self.content:setActive(isNormal)
self.okButton:setActive(isNormal)
self.goButton:setActive(isHuChi or isFull)

self.cfg=UIDiscipleModel:getSpecialityConfig(self.specialityType,self.specialityId)
local discipleName=UIDiscipleModel:getDiscipleName(self.toDisciple)
discipleName=toColorString(FONT_COLOR.eOrangeColor,discipleName)

local curTzName=UIDiscipleModel.getSpecialityNameStr(self.cfg.name)
curTzName=toColorString(FONT_COLOR.eOrangeColor,curTzName)

if isNormal then
self.tztxtpre:setText(FMT.fmt("弟子{0}悟道成功，获得天赋：",discipleName))

self.tzWidget=self.tzSlot:getWidgetBase()
self.tzSlot:setActive(true)
UIDiscipleModel.refreshSpecialityItem(self.tzWidget,self.cfg,function()
self:onDescSlotClick()
end)
elseif isFull then
local tipsFMT="弟子{0}由于其他途径，获得特质已满，无法继续获得特质，需要祛除一个特质后可继续获得【{1}】，亦或者放弃获得【{2}】特质。"

local tips=FMT.fmt(tipsFMT,discipleName,curTzName,curTzName)

self.tips:setText(tips)
elseif isHuChi then
local tipsFMT="弟子{0}由于其他途径，获得的特质【{1}】与特质【{2}】互斥，无法继续获得特质，需要将【{3}】祛除后可获得【{4}】特质，亦或者放弃获得【{5}】特质。"



local hcSpCfg=UIDiscipleModel:getSpecialityConfig(args[1],args[2])
local hcTzName=UIDiscipleModel.getSpecialityNameStr(hcSpCfg.name)
hcTzName=toColorString(FONT_COLOR.eOrangeColor,hcTzName)

local tips=FMT.fmt(tipsFMT,discipleName,curTzName,hcTzName,hcTzName,curTzName,curTzName)

self.tips:setText(tips)
end
end


function UIJinDiWaitSelectTeZhiDialougeWin:onHide()

end

function UIJinDiWaitSelectTeZhiDialougeWin:onDescSlotClick()
UIManager:showWindow('UISpecialityWin',{item=self.tzWidget,node='bottom',guid=self.toDisciple,config=self.cfg})
end

function UIJinDiWaitSelectTeZhiDialougeWin:recv_25_14(id,if_add)
self:closeSelf()
end

function UIJinDiWaitSelectTeZhiDialougeWin:checkClickBtnCD()
local curTime=timeHelper.getServerShortTime()
if self.clickBtnStamp+_clickBtnCD>curTime then
return false
else
self.clickBtnStamp=curTime
return true
end
end

function UIJinDiWaitSelectTeZhiDialougeWin:showWaitClickTips()
if self.selectOptionIdx==0 then
UIManager.info("放弃中")
elseif self.selectOptionIdx==1 then
UIManager.info("接受中")
end
end


function UIJinDiWaitSelectTeZhiDialougeWin:checkSpecialSituation()

if UIDiscipleModel.checkSpecialtyCountMax(self.specialityType,self.toDisciple)then
return _specialSituationType.fullTeZhi
end

local spe,args=UIDiscipleModel.checkDiscipleSpecialityGroupByID(self.toDisciple,self.specialityType,self.specialityId)
if args~=nil then
return _specialSituationType.tezhiHuChi,args
end


return _specialSituationType.normal
end





function UIJinDiWaitSelectTeZhiDialougeWin:onCancelButton()
if self:checkClickBtnCD()then
self.selectOptionIdx=0
UIHuanJingControl:send_25_14(self.jdid,0)
else
self:showWaitClickTips()
end
end



function UIJinDiWaitSelectTeZhiDialougeWin:onCloseBtn()
end



function UIJinDiWaitSelectTeZhiDialougeWin:onOkButton()
if self:checkClickBtnCD()then
self.selectOptionIdx=1
UIHuanJingControl:send_25_14(self.jdid,1)
else
self:showWaitClickTips()
end
end

function UIJinDiWaitSelectTeZhiDialougeWin:onGoButton()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eLvFaTang}})
end


