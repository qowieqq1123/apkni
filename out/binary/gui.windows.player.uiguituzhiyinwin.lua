







def_class("UIGuiTuZhiYinWin",UIWindowBase)









function UIGuiTuZhiYinWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.boxModel=UIObject.get(self,1)
self.actInfoMask=UIObject.get(self,2)
self.actInfoPanel=UIObject.get(self,3)
self.actInfoScrollView=UIObject.get(self,4)
self.restartTxt=UIText.get(self,5)
self.restartTips=UIText.get(self,6)
self.restartBtn=UIButton.get(self,7)
self.rwScrollView=UIObject.get(self,8)
self.dialogTxt=UIText.get(self,9)
self.continueTxt=UIText.get(self,10)
self.actInfoBtn=UIButton.get(self,11)
self.continueBtn=UIButton.get(self,12)
self.dzModel=UIObject.get(self,13)

self.restartBtn:setButtonClick(function()self:onRestartBtn()end)

self.actInfoBtn:setButtonClick(function()self:onActInfoBtn()end)

self.continueBtn:setButtonClick(function()self:onContinueBtn()end)



end


function UIGuiTuZhiYinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.boxModel);self.boxModel=nil;
_UIObject_release(self.actInfoMask);self.actInfoMask=nil;
_UIObject_release(self.actInfoPanel);self.actInfoPanel=nil;
_UIObject_release(self.actInfoScrollView);self.actInfoScrollView=nil;
_UIObject_release(self.restartTxt);self.restartTxt=nil;
_UIObject_release(self.restartTips);self.restartTips=nil;
_UIObject_release(self.restartBtn);self.restartBtn=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.dialogTxt);self.dialogTxt=nil;
_UIObject_release(self.continueTxt);self.continueTxt=nil;
_UIObject_release(self.actInfoBtn);self.actInfoBtn=nil;
_UIObject_release(self.continueBtn);self.continueBtn=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
end



















function UIGuiTuZhiYinWin:onLoaded(...)
self:bindComponents()
self.actInfoOpen=false
end


function UIGuiTuZhiYinWin:__delete()
self:unbindComponents()
end




function UIGuiTuZhiYinWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5347,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.boxModel:getID(),5348,1,{},eAnimationID.stand)
end
if argtable then
self.actId=argtable[1]
self.subId=argtable[2]
else
self:closeSelf()
end
self.subType=SUB_ACTIVITY_TYPE.eGuiTuZhiYin
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshModelShow()
self:refreshViewPanel()
self:refreshActInfoPanel()
end


function UIGuiTuZhiYinWin:onHide()
self.actInfoOpen=false
end

function UIGuiTuZhiYinWin:refreshModelShow()
local netData=UIDiscipleModel:getPlotDiscipleByIndex(1)
if netData then
local guid=netData.discipleguid
local model=UIDiscipleModel:getDiscipleInsideModelInfo(guid)
self.dzModel:setChildUIModelShowTarget(model.body,0.9,model.componets,0,false,true)
end
end

function UIGuiTuZhiYinWin:refreshViewPanel()
self.dialogTxt:setText(self.config.dzDialog)
self.continueTxt:setText(self.config.zxContent)
self.restartTxt:setText(self.config.cxContent)

local zhm_const_def=cfg_zhaohuimaconfig().const_def
local newReward=zhm_const_def.back_new_server_reward
self.restartTips:setText(string.format("前往新区%d级可领",newReward and newReward[1]or 20))

local newServerReward=self.config.rewards
local totalRechargeNum=rechargeModel:getTotalRecharge()
local idx=table.getValueUpIdx(newServerReward,totalRechargeNum)
local rwList=newServerReward[idx][2]
self.rwScrollView:setChildLayoutGroupCreateItems(#rwList)
local grids=self.rwScrollView:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local reward=rwList[i]
local itemCfg=itemsConfig.getConfig(reward[1])
widgetHelper.setNormalRewardItem(item,0,{reward[1],reward[2],stage=itemCfg.stage})
end
end

function UIGuiTuZhiYinWin:refreshActInfoPanel()
local actInfoList=self.config.actInfo
self.actInfoScrollView:setChildLayoutGroupCreateItems(#actInfoList)
local actInfoGrids=self.actInfoScrollView:getChildLayoutGroupGridList()
for i=1,#actInfoList do
local actInfoWidget=actInfoGrids[i-1]
local actInfo=actInfoList[i]
actInfoWidget:SetChildText(0,actInfo[1])
end
end

function UIGuiTuZhiYinWin:callActivityFunc(fname,...)
return call_activitiesHandle_func('activitiesHandle_guituzhiyin',fname,self.actId,self.subId,...)
end

function UIGuiTuZhiYinWin:onActInfoBtn()
self.actInfoOpen=not self.actInfoOpen
self.actInfoPanel:setActive(self.actInfoOpen)
self.actInfoMask:setActive(self.actInfoOpen)
if self.actInfoOpen then
self.winlua:ForceLayoutVertical(self.actInfoScrollView:getID())
self.winlua:ForceLayoutVertical(self.actInfoPanel:getID())
end
end

function UIGuiTuZhiYinWin:onContinueBtn()
self:callActivityFunc('reqSelectReturnWay',1)
self:closeSelf()
end

function UIGuiTuZhiYinWin:onRestartBtn()
local nowBindingCode=welfareModel:getBindReturnCode()
local isBinding=nowBindingCode~=nil and not mathHelper.compareInt64(nowBindingCode,int64.new('0'))
if welfareModel:checkXianYouZhaoHuiOpen()and not isBinding then
UIManager:showWindow("UIHuiGuiBangDingDialogWin",{self.actId,self.subId})
else
self:callActivityFunc('reqSelectReturnWay',2)
end
end