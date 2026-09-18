







def_class("UIMingYuanZhuSha_RestartWin",UIWindowBase)









function UIMingYuanZhuSha_RestartWin:bindComponents()

self.back=UIButton.get(self,0)
self.cancelBtn=UIButton.get(self,1)
self.centerLayout=UIObject.get(self,2)
self.confireBtn=UIButton.get(self,3)
self.emptyLostBw=UIObject.get(self,4)
self.loseBwScrollView=UIObject.get(self,5)
self.optionSpine=UIObject.get(self,6)
self.resetAllBtn=UIButton.get(self,7)
self.resetGroupBtn=UIButton.get(self,8)
self.Root=UIObject.get(self,9)
self.stage_1=UIObject.get(self,10)
self.stage_2=UIObject.get(self,11)
self.stage_Option=UIObject.get(self,12)
self.tips=UIText.get(self,13)
self.uiRoot=UIObject.get(self,14)

self.back:setButtonClick(function()self:onBack()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.confireBtn:setButtonClick(function()self:onConfireBtn()end)

self.resetAllBtn:setButtonClick(function()self:onResetAllBtn()end)

self.resetGroupBtn:setButtonClick(function()self:onResetGroupBtn()end)
self.stage={
self.stage_1,
self.stage_2,
}
self.stage={
["Option"]=self.stage_Option,
}



end


function UIMingYuanZhuSha_RestartWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.confireBtn);self.confireBtn=nil;
_UIObject_release(self.emptyLostBw);self.emptyLostBw=nil;
_UIObject_release(self.loseBwScrollView);self.loseBwScrollView=nil;
_UIObject_release(self.optionSpine);self.optionSpine=nil;
_UIObject_release(self.resetAllBtn);self.resetAllBtn=nil;
_UIObject_release(self.resetGroupBtn);self.resetGroupBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.stage_1);self.stage_1=nil;
_UIObject_release(self.stage_2);self.stage_2=nil;
_UIObject_release(self.stage_Option);self.stage_Option=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.stage=nil;
self.stage=nil;
end
















local _this

local _bwItemCmpIndex={
quality=0,
select=1,
nameBg=2,
name=3,
descBg=4,
desc=5,
bwImg=6,
effect=7,
}

local _resetType={
eNone=0,
eResetAll=1,
eResetGroup=2,
}




function UIMingYuanZhuSha_RestartWin:onLoaded(...)
self:bindComponents()

_this=self

end


function UIMingYuanZhuSha_RestartWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_RestartWin:onShow(argtable,afterOnloaded)

self.stageIndex=1
self.resetType=_resetType.eNone

self:refreshAll()
end


function UIMingYuanZhuSha_RestartWin:onHide()

end

function UIMingYuanZhuSha_RestartWin:refreshAll()
self.back:setActive(self.stageIndex==1)
self.stage_1:setActive(self.stageIndex==1)
self.stage_2:setActive(self.stageIndex==2)

if self.stageIndex==1 then
self:refreshStage1()
end

if self.stageIndex==2 then
self:refreshStage2()
end
end

function UIMingYuanZhuSha_RestartWin:refreshStage1()
self.stage_Option:setChildCanvasGroupAlpha(0)
self.optionSpine:setChildUIModelShowTarget(5679,1,nil,eAnimationID.enter,false,false,0.2,function()
_this.stage_Option:setChildCanvasGroupDOFade(1,0.2)
end)
end

function UIMingYuanZhuSha_RestartWin:refreshStage2()

local resetTipsKey=self.resetType==_resetType.eResetAll and"myzs_restart_all"or'myzs_restart_group'
local tips=cfgHelper.get1(cfg_lang_get,resetTipsKey)or"重置提示"
self.tips:setText(tips)


local bwList=self.resetType==_resetType.eResetAll and myzsModel:getTotalBwList()or myzsModel:getCurrentGroupBWList()
local bwLen=#bwList
local isHasBW=bwLen>0

self.loseBwScrollView:setActive(isHasBW)
self.emptyLostBw:setActive(not isHasBW)

if not isHasBW then return end

self.loseBwScrollView:setChildScrollRectEnable(bwLen>3)
self.loseBwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.loseBwScrollView:setChildScrollViewCreateGrids(bwLen,bwLen)
local grids=self.loseBwScrollView:getChildScrollViewItemWidgets()

for index=1,grids.Count do
local item=grids[index-1]
local data=bwList[index]

self:freshLoseBwItem(index,item,data)
end
end

function UIMingYuanZhuSha_RestartWin:freshLoseBwItem(index,item,bwData)
local bwId=bwData.param_1
local level=bwData.param_2

local bwCfg=cfgHelper.get1(cfg_mingyuanzhushabaowuconfig_get,bwId)

local widget=item:GetChildWidgetBase(0)





local isSelect=_this.selectIndex==index
widget:SetChildActive(_bwItemCmpIndex.select,isSelect)

widget:SetChildText(_bwItemCmpIndex.name,bwCfg.name)

local desc=skillModel:getSkillDesc(bwCfg.skill[1],bwCfg.skill[2])
widget:SetChildText(_bwItemCmpIndex.desc,desc)

widget:SetChildIcon(_bwItemCmpIndex.bwImg,bwCfg.imageName,true)

end





function UIMingYuanZhuSha_RestartWin:onBack()
self:closeSelf()
end



function UIMingYuanZhuSha_RestartWin:onCancelBtn()
self.resetType=_resetType.eNone
self.stageIndex=1

self:refreshAll()
end



function UIMingYuanZhuSha_RestartWin:onConfireBtn()
if self.stageIndex==1 or self.resetType==_resetType.eNone then return end

local gameIdx=myzsModel:getGameIdx()
if self.resetType==_resetType.eResetAll then
if gameIdx<=1 then
return
end
elseif self.resetType==_resetType.eResetGroup then
local layer=myzsModel:getCurrentLayer()
local levelConf=myzsModel:getLayerFirstLevelConf(layer)
if gameIdx<=levelConf.idx then
UIManager.info("当前重数无进度")
return
end
end

myzsController.reqRestartGame(self.resetType)
self:onBack()
end



function UIMingYuanZhuSha_RestartWin:onResetAllBtn()
self.resetType=_resetType.eResetAll
self.stageIndex=2

self:refreshAll()
end



function UIMingYuanZhuSha_RestartWin:onResetGroupBtn()
local gameIdx=myzsModel:getGameIdx()
local layer=myzsModel:getCurrentLayer()
local levelConf=myzsModel:getLayerFirstLevelConf(layer)
if gameIdx<=levelConf.idx then
UIManager.info("当前重数无进度")
return
end

self.resetType=_resetType.eResetGroup
self.stageIndex=2

self:refreshAll()
end

