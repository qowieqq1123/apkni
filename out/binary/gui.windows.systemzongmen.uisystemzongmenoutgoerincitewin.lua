







def_class("UISystemZongMenOutgoerInciteWin",UIWindowBase)









function UISystemZongMenOutgoerInciteWin:bindComponents()

self.background=UIButton.get(self,0)
self.helperPanel=UIButton.get(self,1)
self.targetNameTx=UIText.get(self,2)
self.executorNameTx=UIText.get(self,3)
self.targetLevelTx=UIText.get(self,4)
self.executorLevelTx=UIText.get(self,5)
self.compareImg=UIImage.get(self,6)
self.targetColorIcon=UIImage.get(self,7)
self.helperBtn=UIButton.get(self,8)
self.inciteBtn=UIButton.get(self,9)
self.closeBtn=UIButton.get(self,10)
self.targetModel=UIObject.get(self,11)
self.executorModel=UIButton.get(self,12)
self.charmTx=UIText.get(self,13)
self.percentTx_2=UIText.get(self,14)
self.percentTx_1=UIText.get(self,15)
self.percentTx_3=UIText.get(self,16)
self.loyaltyTx=UIText.get(self,17)
self.helperActive=UIObject.get(self,18)
self.helperTx=UIText.get(self,19)

self.background:setButtonClick(function()self:onBackground()end)

self.helperPanel:setButtonClick(function()self:onHelperPanel()end)

self.helperBtn:setButtonClick(function()self:onHelperBtn()end)

self.inciteBtn:setButtonClick(function()self:onInciteBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.executorModel:setButtonClick(function()self:onExecutorModel()end)
self.percentTx={
self.percentTx_1,
self.percentTx_2,
self.percentTx_3,
}



end


function UISystemZongMenOutgoerInciteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.helperPanel);self.helperPanel=nil;
_UIObject_release(self.targetNameTx);self.targetNameTx=nil;
_UIObject_release(self.executorNameTx);self.executorNameTx=nil;
_UIObject_release(self.targetLevelTx);self.targetLevelTx=nil;
_UIObject_release(self.executorLevelTx);self.executorLevelTx=nil;
_UIObject_release(self.compareImg);self.compareImg=nil;
_UIObject_release(self.targetColorIcon);self.targetColorIcon=nil;
_UIObject_release(self.helperBtn);self.helperBtn=nil;
_UIObject_release(self.inciteBtn);self.inciteBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.targetModel);self.targetModel=nil;
_UIObject_release(self.executorModel);self.executorModel=nil;
_UIObject_release(self.charmTx);self.charmTx=nil;
_UIObject_release(self.percentTx_2);self.percentTx_2=nil;
_UIObject_release(self.percentTx_1);self.percentTx_1=nil;
_UIObject_release(self.percentTx_3);self.percentTx_3=nil;
_UIObject_release(self.loyaltyTx);self.loyaltyTx=nil;
_UIObject_release(self.helperActive);self.helperActive=nil;
_UIObject_release(self.helperTx);self.helperTx=nil;
self.percentTx=nil;
end















local _this=nil
local _abName="ui/windows/systemzongmen/systemzongmen_outgoer_atlas_pak.ab"

local _a_meili=35
local _b_meili=70

local _a_loyality=35
local _b_loyality=70

local _a_percent=35
local _b_percent=70



function UISystemZongMenOutgoerInciteWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenOutgoerInciteWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenOutgoerInciteWin:onShow(argtable,afterOnloaded)
self.targetData=systemZongMenController:getOutgoerSceneInfo_OutgoerData()
self.funcData=systemZongMenModel:getOutgoerFuncData()
self.zmData=systemZongMenModel:getInfoData(self.targetData.serial)
self.zmCfg=cfgHelper.get1(cfg_syssectconfig_get,self.zmData.id)
self.cfCfg=cfgHelper.get1(cfg_syssectcfconfig_get,self.zmCfg.cfid)

self.selecteDiscipleStruct=systemZongMenController:getOutgoerSceneInfo_VisitorData()
self.inciteCallback=argtable.inciteCallback
self.closeCallback=argtable.closeCallback
self:initHelperRule()
self:initTarget()
self:setExecutor()
end


function UISystemZongMenOutgoerInciteWin:onHide()

end





function UISystemZongMenOutgoerInciteWin:onBackground()
self:onCloseBtn()
end



function UISystemZongMenOutgoerInciteWin:onCloseBtn()
if self.closeCallback then
self.closeCallback()
else
self:closeSelf()
end
end


function UISystemZongMenOutgoerInciteWin:onInciteBtn()
local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
if cur>=max then
UIManager.error("弟子人数已满")
return
end

local maxnum,havenum=UIPrisonModel:getSiXuSpeciality()
if maxnum and maxnum>0 then
if havenum>=maxnum then
self:onCloseBtn()
UIManager.error(FMT.fmt('拥有思绪的弟子达到上限（{0}/{1}）',havenum,maxnum))
return
end
end
if self.inciteCallback then
self.inciteCallback(self.selecteDiscipleStruct.discipleguid)
else
self:onCloseBtn()
end
end


function UISystemZongMenOutgoerInciteWin:onExecutorModel()
local discipleguid=self.selecteDiscipleStruct and self.selecteDiscipleStruct.discipleguid or nil
local args={
discipleguids={discipleguid},
openType=dzSelectWinOpenType.eSystemZMOutgoer,
funcType=edzFuncSpecialityType.eSpeciality_SystemZongMenOutgoer_Incite,
callback=function(guid)
self.selecteDiscipleStruct=UIDiscipleModel:getDiscipleData(guid)
self:setExecutor()
end
}
discipleSelectController:openDiscipleSelect(args)
end


function UISystemZongMenOutgoerInciteWin:setExecutor()
comHelper.setChildInSideModel(self.executorModel,self.selecteDiscipleStruct.discipleguid,0.75,eAnimationID.stand,0,0,true,false)
self.executorNameTx:setText(UIDiscipleModel:getDiscipleName(self.selecteDiscipleStruct.discipleguid))

local sjjLv=self.selecteDiscipleStruct.jingjielv
local tjjLv=self.targetData.jingjie
self.executorLevelTx:setText(UIDiscipleModel:getJJName3(sjjLv))

local meili=self.selecteDiscipleStruct.attrList[DISCIPLE_BASE_ATTR_TYPE.eMeiLi]







self.charmTx:setText(tostring(meili))

local paramA=self.cfCfg.param[1]
local paramB=self.cfCfg.param[2]
local paramC=self.cfCfg.param[3]
local paramD=self.cfCfg.param[4]
local plus=self.selecteDiscipleStruct and dzSpecialitySpecialEffectController:getSystemZMInciteRateRate(self.selecteDiscipleStruct)or 0
local percent=(sjjLv-tjjLv)*paramA+meili*paramB+self.funcData.loyalty*paramC+self.targetColor*paramD+plus
percent=Mathf.Clamp(math.floor(percent),0,100)

local percentStr=FMT.fmt("{0}%",percent)
if _a_percent>percent then
self.percentTx_1:setText(percentStr)
self.percentTx_2:setText("")
self.percentTx_3:setText("")
elseif _b_percent<percent then
self.percentTx_1:setText("")
self.percentTx_2:setText(percentStr)
self.percentTx_3:setText("")
else
self.percentTx_1:setText("")
self.percentTx_2:setText("")
self.percentTx_3:setText(percentStr)
end

local sF=UIDiscipleModel:getJJFloor(sjjLv)
local tF=UIDiscipleModel:getJJFloor(tjjLv)
local compareName=''
if sF>tF then
compareName="image_zpcfui_8"
elseif sF==tF then
compareName="image_zpcfui_7"
else
compareName="image_zpcfui_6"
end
self.compareImg:setSprite(_abName,compareName)
end

function UISystemZongMenOutgoerInciteWin:initTarget()
local imageInfo=UIDiscipleModel.calculationDiscipleImage(self.targetData.discipledata,self.targetData.discipleimage)
self.targetColor=imageInfo.color
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildInSideModelEx(self.targetModel,modelParams,0.75,eAnimationID.stand,0,0,true,false)

self.targetNameTx:setText(self.targetData.disciplename)
self.targetLevelTx:setText(UIDiscipleModel:getJJName3(self.targetData.jingjie))

local loyalty=self.funcData.loyalty
local loyaltyColor=FONT_COLOR.eTipsTitleColor
if loyalty<_a_loyality then
loyaltyColor=FONT_COLOR.eGreenColor
elseif loyalty>_b_loyality then
loyaltyColor=FONT_COLOR.eRedColor
end
self.loyaltyTx:setText(FMT.cfmt(loyaltyColor,tostring(loyalty)))

local color_icon=FMT.fmt('image_pinjishibie_{0}',self.targetColor)
self.targetColorIcon:setSprite(globalABLookup.global,color_icon)
end

function UISystemZongMenOutgoerInciteWin:initHelperRule()
self.helperTx:setText(cfgHelper.getlang("systemZongMenInciteRuleList"))
self.winlua:ForceLayoutRect(self.helperPanel:getID())
end

function UISystemZongMenOutgoerInciteWin:onHelperBtn()
self.panelShow=not self.panelShow
self.helperPanel:setScale(self.panelShow and Vector3.one or Vector3.zero)
self.helperActive:setActive(self.panelShow)
end

function UISystemZongMenOutgoerInciteWin:onHelperPanel()
self:onHelperBtn()
end