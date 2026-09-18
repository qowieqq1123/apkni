







def_class("UIItemRecruitDiscipleInfoThreeWin",UIWindowBase)









function UIItemRecruitDiscipleInfoThreeWin:bindComponents()

self.dragZoomPanel=UIObject.get(self,0)
self.startModelPanel=UIObject.get(self,1)
self.testPanel=UIObject.get(self,2)
self.modelRoot=UIObject.get(self,3)
self.dzStartModel=UIObject.get(self,4)
self.jumpToEndBtn=UIButton.get(self,5)
self.backStartBtn=UIButton.get(self,6)
self.changeClickShowBtn=UIButton.get(self,7)
self.changeBgShowBtn=UIButton.get(self,8)
self.reenterBtn=UIButton.get(self,9)
self.modelMask=UIObject.get(self,10)
self.modelBg=UIObject.get(self,11)
self.dzClickArea=UIObject.get(self,12)
self.dzModel=UIObject.get(self,13)
self.changeBgShowBtnText=UIText.get(self,14)
self.changeClickShowBtnText=UIText.get(self,15)
self.changeRatioBtn=UIButton.get(self,16)
self.priceInputField=UIInputField.get(self,17)
self.Placeholder=UIText.get(self,18)

self.jumpToEndBtn:setButtonClick(function()self:onJumpToEndBtn()end)

self.backStartBtn:setButtonClick(function()self:onBackStartBtn()end)

self.changeClickShowBtn:setButtonClick(function()self:onChangeClickShowBtn()end)

self.changeBgShowBtn:setButtonClick(function()self:onChangeBgShowBtn()end)

self.reenterBtn:setButtonClick(function()self:onReenterBtn()end)

self.changeRatioBtn:setButtonClick(function()self:onChangeRatioBtn()end)



end


function UIItemRecruitDiscipleInfoThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dragZoomPanel);self.dragZoomPanel=nil;
_UIObject_release(self.startModelPanel);self.startModelPanel=nil;
_UIObject_release(self.testPanel);self.testPanel=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.dzStartModel);self.dzStartModel=nil;
_UIObject_release(self.jumpToEndBtn);self.jumpToEndBtn=nil;
_UIObject_release(self.backStartBtn);self.backStartBtn=nil;
_UIObject_release(self.changeClickShowBtn);self.changeClickShowBtn=nil;
_UIObject_release(self.changeBgShowBtn);self.changeBgShowBtn=nil;
_UIObject_release(self.reenterBtn);self.reenterBtn=nil;
_UIObject_release(self.modelMask);self.modelMask=nil;
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.dzClickArea);self.dzClickArea=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.changeBgShowBtnText);self.changeBgShowBtnText=nil;
_UIObject_release(self.changeClickShowBtnText);self.changeClickShowBtnText=nil;
_UIObject_release(self.changeRatioBtn);self.changeRatioBtn=nil;
_UIObject_release(self.priceInputField);self.priceInputField=nil;
_UIObject_release(self.Placeholder);self.Placeholder=nil;
end
















local _this
local _Screen=UnityEngine.Screen




function UIItemRecruitDiscipleInfoThreeWin:onLoaded(...)
_this=self
self:bindComponents()


end


function UIItemRecruitDiscipleInfoThreeWin:__delete()
self:clearShowBgTween()
self:clearMoveTween()
self:clearSpreadMaskTween()
self:onCloseCallBack()
_this=nil
self:unbindComponents()
end




function UIItemRecruitDiscipleInfoThreeWin:onShow(argtable,afterOnloaded)
self.dzGuid=argtable and argtable.dizi_guid or nil
if self.dzGuid then

self.diziData=UIDiscipleModel:getDiscipleData(self.dzGuid)
local initFinish=self:initPage()

if initFinish then
self:enterPage()
end
end
end


function UIItemRecruitDiscipleInfoThreeWin:onHide()

end


function UIItemRecruitDiscipleInfoThreeWin:initPage()
local spLihuiCfg=UIDiscipleModel:getSpecialDiscipleLihuiCfgByGuid(self.dzGuid)
if not spLihuiCfg then
logErr(FMT.fmt("弟子{0}不存在独立特殊立绘，请检查跳转判断是否正确",self.diziData.id))
return false
end


self.startData={}


self.startSize=spLihuiCfg.enter_size or 1



self.startData.startModelPos=self.startModelPanel:getChildAnchoredPosition()


self.modelSize=spLihuiCfg.model_size or 1


self.modelSizeRatio=spLihuiCfg.model_ratio or 1


local scale=self.startSize/self.modelSize*self.modelSizeRatio
self.modelRoot:setScale(Vector3.New(scale,scale,scale))









local enter_offset=spLihuiCfg.enter_offset
self.startModelMoveEndX=enter_offset and-enter_offset[1]or 0
if enter_offset then
self.dzStartModel:setChildAnchoredPosition(Vector2.New(enter_offset[1],enter_offset[2]))
self.dzModel:setChildAnchoredPosition(Vector2.New(0,enter_offset[2]/scale))
end

local model_offset=spLihuiCfg.model_offset
local originalRootPos=self.modelRoot:getChildAnchoredPosition()
self.originalRootOffset={originalRootPos.x,originalRootPos.y}
if model_offset then

local originalPos=self.modelMask:getChildAnchoredPosition()


self.modelMask:setChildAnchoredPosition(Vector2.New(originalPos.x+model_offset[1],originalPos.y+model_offset[2]))
self.modelRoot:setChildAnchoredPosition(Vector2.New(originalRootPos.x-model_offset[1]*scale,originalRootPos.y-model_offset[2]*scale))
local finalPos=self.modelRoot:getChildLocalPosition()


self.winlua:SetChildSubOriginalPos(self.dragZoomPanel:getID(),finalPos)
end

self.showAnimId=spLihuiCfg.showAnim or eAnimationID.stand
self.clickAnimId=spLihuiCfg.clickAnim or eAnimationID.touch


local clickArea=spLihuiCfg.clickArea
if clickArea then
self.dzClickArea:setChildSizeDelta(clickArea[1],clickArea[2])
end
local click_offset=spLihuiCfg.click_offset
if click_offset then
self.dzClickArea:setChildAnchoredPosition(Vector2.New(click_offset[1],click_offset[2]))
end


self.startData.modelMaskPos=self.modelMask:getChildAnchoredPosition()
self.startData.modelRootPos=self.modelRoot:getChildAnchoredPosition()


return true
end

function UIItemRecruitDiscipleInfoThreeWin:enterPage()

self.startModelPanel:setActive(true)

self.modelBg:setChildCanvasGroupAlpha(0)
self.isShowBg=false

self.dzModel:setActive(false)
self.dzClickArea:setActive(false)


local ddata=self.diziData
local info=ddata.imageInfo

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,{isNotBg=true})


local moveEndCallBack=function()
self:refresh()
end

self:clearMoveTween()
self.showMoveTween=self.dzStartModel:setChildUIModelShowTarget(modelParams.body,self.startSize,modelParams.componets,self.showAnimId,true,false,0,function()

UIManager:invokeUIMethod("UIDiscipleRoleInfoWin","hideDiscipleModel")
UIManager:invokeUIMethod("UIDiscipleRoleInfo2Win","hideDiscipleModel")
local duration=0.5

self.startModelPanel:setChildDOLocalMoveX(self.startModelMoveEndX,duration,moveEndCallBack)

return self:doBgFadeIn()
end)

self:refreshTestPanel()
end

function UIItemRecruitDiscipleInfoThreeWin:refresh()

local ddata=self.diziData

local info=ddata.imageInfo


local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)
self.dzModel:setChildUIModelShowTarget(modelParams.body,self.modelSize,modelParams.componets,self.showAnimId,true,false,0,function()
return self:doModelFadeIn()

end)
end


function UIItemRecruitDiscipleInfoThreeWin:doBgFadeIn()
self:clearMoveTween()
self:clearShowBgTween()
self.showBgTween=self.modelBg:setChildCanvasGroupDOFade(1,0.5,function()
self.isShowBg=true
self:refreshTestPanel()
self:clearShowBgTween()
end)
end


function UIItemRecruitDiscipleInfoThreeWin:doModelFadeIn()









self.modelMask:setChildCanvasGroupAlpha(0)

self.dzModel:setActive(true)
self.dzClickArea:setActive(false)




self.dzStartModel:setChildModelAnimationState(self.showAnimId,1)
self.dzModel:setChildModelAnimationState(self.showAnimId,1)
















self:clearSpreadMaskTween()
self.spreadMaskTween=self.modelMask:setChildCanvasGroupDOFade(1,0.3,function()
self.winlua:SetChildDragZoomEnable(self.dragZoomPanel:getID(),true)
self.dzClickArea:setActive(true)


self.startModelPanel:setActive(false)

self.dzStartModel:setChildModelAnimationState(self.showAnimId,0)
self:clearSpreadMaskTween()
end)

end


function UIItemRecruitDiscipleInfoThreeWin:clearShowBgTween()
if self.showBgTween~=nil then
self.showBgTween:Kill()
self.showBgTween=nil
end
end



function UIItemRecruitDiscipleInfoThreeWin:clearMoveTween()
if self.showMoveTween~=nil then
self.showMoveTween:Kill()
self.showMoveTween=nil
end
end



function UIItemRecruitDiscipleInfoThreeWin:clearSpreadMaskTween()
if self.spreadMaskTween~=nil then
self.spreadMaskTween:Kill()
self.spreadMaskTween=nil
end
end


function UIItemRecruitDiscipleInfoThreeWin:reset()
self:clearShowBgTween()
self:clearMoveTween()
self:clearSpreadMaskTween()

local spLihuiCfg=UIDiscipleModel:getSpecialDiscipleLihuiCfgByGuid(self.dzGuid)
self.startModelPanel:setChildAnchoredPosition(self.startData.startModelPos)
self.startModelPanel:setActive(true)

self.modelBg:setChildCanvasGroupAlpha(0)
self.isShowBg=false

self.dzModel:setActive(false)

self.modelMask:setChildAnchoredPosition(self.startData.modelMaskPos)
local scale=self.startSize/self.modelSize*self.modelSizeRatio
self.modelRoot:setScale(Vector3.New(scale,scale,scale))

local model_offset=spLihuiCfg.model_offset
if model_offset then


self.modelRoot:setChildAnchoredPosition(Vector2.New(self.originalRootOffset[1]-model_offset[1]*scale,self.originalRootOffset[2]-model_offset[2]*scale))
else
self.modelRoot:setChildAnchoredPosition(self.startData.modelRootPos)
end
self.startData.modelRootPos=self.modelRoot:getChildAnchoredPosition()
local enter_offset=spLihuiCfg.enter_offset
if enter_offset then
self.dzModel:setChildAnchoredPosition(Vector2.New(0,enter_offset[2]/scale))
end






self.winlua:SetChildDragZoomEnable(self.dragZoomPanel:getID(),false)
self:refreshTestPanel()
end



function UIItemRecruitDiscipleInfoThreeWin:jumpToEnd()
self:clearShowBgTween()
self:clearMoveTween()
self:clearSpreadMaskTween()

self.startModelPanel:setChildAnchoredPosition(Vector2(0,self.startData.modelRootPos.y))
self.startModelPanel:setActive(false)

self.modelBg:setChildCanvasGroupAlpha(1)
self.isShowBg=true

self.dzModel:setActive(true)
self.dzClickArea:setActive(true)
self.modelRoot:setChildAnchoredPosition(self.startData.modelRootPos)
self.modelMask:setChildAnchoredPosition(self.startData.modelMaskPos)
local scale=self.startSize/self.modelSize*self.modelSizeRatio
self.modelRoot:setScale(Vector3.New(scale,scale,scale))








self.winlua:SetChildDragZoomEnable(self.dragZoomPanel:getID(),true)
self:refreshTestPanel()
end



function UIItemRecruitDiscipleInfoThreeWin:onClickMask()
UIManager.info("点击mask")
end


function UIItemRecruitDiscipleInfoThreeWin:onCloseCallBack()

UIManager:invokeUIMethod("UIDiscipleRoleInfoWin","showDiscipleModel")
UIManager:invokeUIMethod("UIDiscipleRoleInfo2Win","showDiscipleModel")
end

function UIItemRecruitDiscipleInfoThreeWin:onClickDzModel()
self.dzModel:setChildModelAnimationState(self.clickAnimId,1)
end



function UIItemRecruitDiscipleInfoThreeWin:refreshTestPanel()

self.priceInputField:setInputFieldValue(self.modelSizeRatio)


local changeBgStr=self.isShowBg and"隐藏背景"or"显示背景"
self.changeBgShowBtnText:setText(changeBgStr)


local changeClickStr=self.isShowClickArea and"隐藏点击区域"or"显示点击区域"
self.changeClickShowBtnText:setText(changeClickStr)
end


function UIItemRecruitDiscipleInfoThreeWin.testFun_showTestPanel()
_this.testPanel:setActive(true)
_this:refreshTestPanel()
end


function UIItemRecruitDiscipleInfoThreeWin.testFun_hideTestPanel()
_this.testPanel:setActive(false)
end


function UIItemRecruitDiscipleInfoThreeWin:onReenterBtn()
self:reset()
self:enterPage()
end


function UIItemRecruitDiscipleInfoThreeWin:onChangeClickShowBtn()
if self.isShowClickArea==nil then
self.isShowClickArea=false
end

if self.isShowClickArea then

self.dzClickArea:setChildCanvasGroupAlpha(0)
else

self.dzClickArea:setChildCanvasGroupAlpha(0.5)
end
self.isShowClickArea=not self.isShowClickArea
self:refreshTestPanel()
end


function UIItemRecruitDiscipleInfoThreeWin:onChangeBgShowBtn()
if self.isShowBg then

self.modelBg:setChildCanvasGroupAlpha(0)

UIManager:invokeUIMethod("UIDiscipleRoleInfoWin","showDiscipleModel")
UIManager:invokeUIMethod("UIDiscipleRoleInfo2Win","showDiscipleModel")
else

self.modelBg:setChildCanvasGroupAlpha(1)

UIManager:invokeUIMethod("UIDiscipleRoleInfoWin","hideDiscipleModel")
UIManager:invokeUIMethod("UIDiscipleRoleInfo2Win","hideDiscipleModel")
end
self.isShowBg=not self.isShowBg
self:refreshTestPanel()
end


function UIItemRecruitDiscipleInfoThreeWin:onBackStartBtn()
self:reset()
end


function UIItemRecruitDiscipleInfoThreeWin:onJumpToEndBtn()
self:jumpToEnd()
end


function UIItemRecruitDiscipleInfoThreeWin:onChangeRatioBtn()
local str=self.priceInputField:getInputFieldValue()
local ratio
if str~=''then
ratio=tonumber(str)
else
ratio=nil
end

if ratio then
self.modelSizeRatio=ratio
else
self.priceInputField:setInputFieldValue(self.modelSizeRatio)
end
end

function UIItemRecruitDiscipleInfoThreeWin.testFun_resetDiziModel()
local ddata=_this.diziData
local info=ddata.imageInfo
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)
_this.dzModel:setChildUIModelShowTarget(modelParams.body,_this.modelSize,modelParams.componets,_this.showAnimId,false,false,0)
end


function UIItemRecruitDiscipleInfoThreeWin.testFun_changeModelRatio(ratio)
_this.modelSizeRatio=ratio
end