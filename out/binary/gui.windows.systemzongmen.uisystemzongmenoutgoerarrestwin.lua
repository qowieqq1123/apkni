







def_class("UISystemZongMenOutgoerArrestWin",UIWindowBase)









function UISystemZongMenOutgoerArrestWin:bindComponents()

self.background=UIButton.get(self,0)
self.helperPanel=UIButton.get(self,1)
self.executorList=UIObject.get(self,2)
self.targetModel=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.arrestBtn=UIButton.get(self,5)
self.targetNameTx=UIText.get(self,6)
self.targetLevelTx=UIText.get(self,7)
self.targetColorIcon=UIImage.get(self,8)
self.helperBtn=UIButton.get(self,9)
self.percentTx_1=UIText.get(self,10)
self.percentTx_2=UIText.get(self,11)
self.percentTx_3=UIText.get(self,12)
self.helperActive=UIObject.get(self,13)
self.helperTx=UIText.get(self,14)

self.background:setButtonClick(function()self:onBackground()end)

self.helperPanel:setButtonClick(function()self:onHelperPanel()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.arrestBtn:setButtonClick(function()self:onArrestBtn()end)

self.helperBtn:setButtonClick(function()self:onHelperBtn()end)
self.percentTx={
self.percentTx_1,
self.percentTx_2,
self.percentTx_3,
}



end


function UISystemZongMenOutgoerArrestWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.helperPanel);self.helperPanel=nil;
_UIObject_release(self.executorList);self.executorList=nil;
_UIObject_release(self.targetModel);self.targetModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.arrestBtn);self.arrestBtn=nil;
_UIObject_release(self.targetNameTx);self.targetNameTx=nil;
_UIObject_release(self.targetLevelTx);self.targetLevelTx=nil;
_UIObject_release(self.targetColorIcon);self.targetColorIcon=nil;
_UIObject_release(self.helperBtn);self.helperBtn=nil;
_UIObject_release(self.percentTx_1);self.percentTx_1=nil;
_UIObject_release(self.percentTx_2);self.percentTx_2=nil;
_UIObject_release(self.percentTx_3);self.percentTx_3=nil;
_UIObject_release(self.helperActive);self.helperActive=nil;
_UIObject_release(self.helperTx);self.helperTx=nil;
self.percentTx=nil;
end















local _this=nil
local _executorCmp={
root=-1,
headSlot=0,
headBg=1,
head=2,
levelTx=3,
nameTx=4,
compareImg=5,
emptyTx=6,
}
local _abName="ui/windows/systemzongmen/systemzongmen_outgoer_atlas_pak.ab"

local _a_percent=35
local _b_percent=70

local _slotNum=3



function UISystemZongMenOutgoerArrestWin:onLoaded(...)
self:bindComponents()
_this=self

self:initHelperRule()
end


function UISystemZongMenOutgoerArrestWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenOutgoerArrestWin:onShow(argtable,afterOnloaded)
self.targetData=systemZongMenController:getOutgoerSceneInfo_OutgoerData()

self.funcData=systemZongMenModel:getOutgoerFuncData()
self.zmData=systemZongMenModel:getInfoData(self.targetData.serial)
self.zmCfg=cfgHelper.get1(cfg_syssectconfig_get,self.zmData.id)
self.zbCfg=cfgHelper.get1(cfg_syssectzbconfig_get,self.zmCfg.zbid)

self.selecteDiscipleStructs={systemZongMenController:getOutgoerSceneInfo_VisitorData(),}
self.arrestCallback=argtable.arrestCallback
self.closeCallback=argtable.closeCallback
self:initExecutorList()
self:initTarget()
self:refreshPrecent()
end


function UISystemZongMenOutgoerArrestWin:onHide()

end





function UISystemZongMenOutgoerArrestWin:onBackground()
self:onCloseBtn()
end



function UISystemZongMenOutgoerArrestWin:onCloseBtn()
if self.closeCallback then
self.closeCallback()
else
self:closeSelf()
end
end



function UISystemZongMenOutgoerArrestWin:onArrestBtn()
if self.arrestCallback then
local guids={}
for i,v in pairs(self.selecteDiscipleStructs)do
table.insert(guids,v.discipleguid)
end
if#guids>0 then
self.arrestCallback(guids)
end
else
self:onCloseBtn()
end
end


function UISystemZongMenOutgoerArrestWin:initExecutorList()
self.executorList:setChildLayoutGroupCreateItems(_slotNum,function(index)
local item=self.executorList:getChildLayoutGroupGridItem(index-1)
item:SetChildButtonClick(_executorCmp.root,function()
self:onClickExecutor(index)
end)
self:refreshExecutorItem(item,self.selecteDiscipleStructs[index])
end)
end

function UISystemZongMenOutgoerArrestWin:refreshExecutorItem(item,discipleStruct)
local have=discipleStruct~=nil
item:SetChildActive(_executorCmp.head,have)
item:SetChildActive(_executorCmp.emptyTx,not have)
if have then
local discipleguid=discipleStruct.discipleguid
local sjjLv=discipleStruct.jingjielv
local tjjLv=self.targetData.jingjie
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
item:SetChildCSImageSprite(_executorCmp.compareImg,_abName,compareName)
item:SetChildText(_executorCmp.levelTx,UIDiscipleModel:getJJName3(sjjLv))
item:SetChildText(_executorCmp.nameTx,discipleStruct.disciplename)
comHelper.setChildModelHeadIconBG(item,_executorCmp.headBg,discipleguid)
comHelper.setChildModelRawImage(item,discipleguid,_executorCmp.head,eAnimationID.stand,eHeadCenterType.eHead)
else
item:SetChildCSImageIcon(_executorCmp.compareImg,"",true)
item:SetChildText(_executorCmp.levelTx,"")
item:SetChildText(_executorCmp.nameTx,"")
item:SetChildCSImageIcon(_executorCmp.headBg,"",true)
end
end

function UISystemZongMenOutgoerArrestWin:initTarget()
local imageInfo=UIDiscipleModel.calculationDiscipleImage(self.targetData.discipledata,self.targetData.discipleimage)
self.targetColor=imageInfo.color
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildInSideModelEx(self.targetModel,modelParams,0.75,eAnimationID.stand,0,0,true,false)
self.targetNameTx:setText(self.targetData.disciplename)
self.targetLevelTx:setText(UIDiscipleModel:getJJName3(self.targetData.jingjie))

local color_icon=FMT.fmt('image_pinjishibie_{0}',self.targetColor)
self.targetColorIcon:setSprite(globalABLookup.global,color_icon)
end

function UISystemZongMenOutgoerArrestWin:refreshPrecent()
local paramA=self.zbCfg.param[1]
local paramB=self.zbCfg.param[2]
local paramC=self.zbCfg.param[3]
local jjDelta=0
local plus=0
local tJJFloor=UIDiscipleModel:getJJFloor(self.targetData.jingjie)
for i,v in pairs(self.selecteDiscipleStructs)do
local vJJFloor=UIDiscipleModel:getJJFloor(v.jingjielv)
jjDelta=jjDelta+(v.jingjielv-self.targetData.jingjie)*paramA+(vJJFloor-tJJFloor)*paramC
plus=plus+dzSpecialitySpecialEffectController:getSystemZMOutgoerRate(v)
end
local percent=jjDelta-self.targetColor*paramB+plus
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
end

function UISystemZongMenOutgoerArrestWin:onClickExecutor(index)
local guids={}
for i,v in pairs(self.selecteDiscipleStructs)do
table.insert(guids,v.discipleguid)
end
local args={
discipleguids=guids,
openType=dzSelectWinOpenType.eSystemZMOutgoer_MultiSelect,
funcType=edzFuncSpecialityType.eSpeciality_SystemZongMenOutgoer_Arrest,
maxSelectCount=_slotNum,
callback=function(guids)
local itemList=self.executorList:getChildLayoutGroupGridList()
for i=1,itemList.Count do
local item=self.executorList:getChildLayoutGroupGridItem(i-1)
local guid=guids[i]
if guid then
local data=UIDiscipleModel:getDiscipleData(guid)
self.selecteDiscipleStructs[i]=data
self:refreshExecutorItem(item,data)
else
self.selecteDiscipleStructs[i]=nil
self:refreshExecutorItem(item,nil)
end
end
self:refreshPrecent()
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UISystemZongMenOutgoerArrestWin:initHelperRule()
self.helperTx:setText(cfgHelper.getlang("systemZongMenArrestRuleList"))
self.winlua:ForceLayoutRect(self.helperPanel:getID())
end

function UISystemZongMenOutgoerArrestWin:onHelperBtn()
self.panelShow=not self.panelShow
self.helperPanel:setScale(self.panelShow and Vector3.one or Vector3.zero)
self.helperActive:setActive(self.panelShow)
end

function UISystemZongMenOutgoerArrestWin:onHelperPanel()
self:onHelperBtn()
end