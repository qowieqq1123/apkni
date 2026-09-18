







def_class("UISubAct_xianshichouka_selectUpWin",UIWindowBase)









function UISubAct_xianshichouka_selectUpWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.roleGridPanel=UIObject.get(self,2)
self.rewardBtn=UIButton.get(self,3)
self.baoXiangReddot=UIImage.get(self,4)
self.roleGridPaneltwo=UIObject.get(self,5)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_xianshichouka_selectUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleGridPanel);self.roleGridPanel=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.roleGridPaneltwo);self.roleGridPaneltwo=nil;
end
















local _this=nil
local diziCount=
{
two=2,
three=3,
}


function UISubAct_xianshichouka_selectUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_xianshichouka_selectUpWin:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_xianshichouka_selectUpWin:onHide()

end




function UISubAct_xianshichouka_selectUpWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
if selectIndex==0 then
selectIndex=nil
end
self.selectIndex=selectIndex
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.ShowDiZiCount=self.sub_actcfg.showDiZiCount or diziCount.three

if self.ShowDiZiCount==diziCount.three then
self.roleGridPanel:setActive(true)
self.roleGridPaneltwo:setActive(false)
self.curroleGridPanel=self.roleGridPanel
else
self.roleGridPanel:setActive(false)
self.roleGridPaneltwo:setActive(true)
self.curroleGridPanel=self.roleGridPaneltwo
end

self:refreshRoleGridPanel()

self.root:setChildCanvasGroupAlpha(0)
self.model:setChildUIModelShowTarget(4004,1,{},2069,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self:refreshDailyReward()
end

function UISubAct_xianshichouka_selectUpWin:refreshRoleGridPanel()
local sub_actcfg=self.sub_actcfg
local defaultdz=sub_actcfg.defaultdz
local disciple=sub_actcfg.disciple

local num=#disciple
local grids=self.curroleGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local itemID=disciple[i][1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
modelParams.scale=0.025
modelParams.offset={0,1}
comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eNone,1,false)

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
item:SetChildUIModelShowTarget(5,modelParams.body,0.75,modelParams.componets,eAnimationID.stand)

item:SetChildText(6,dzData.disciplename)

local abname,icon=UIDiscipleModel:getJobOrientationBigIcon(info.job,dzData.id)
item:SetChildCSImageSprite(3,abname,icon)

item:SetChildActive(4,i==defaultdz)

item:SetChildButtonClick(2,function()
if _this==nil then return end
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end)

item:SetChildButtonClick(9,function()
if _this==nil then return end
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end)

self:refreshRoleItemSelect(item,i,self.selectIndex==i)

item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onRoleItemClick(i)
end)

item:SetChildButtonClick(11,function()
if _this==nil then return end
local d={}
d.title='规则说明'
d.mode=3
d.name='xianyuanxunfang_rule_%d'
d.closeCB=function()
end
UIManager:showWindow('UIRuleWin',d)
end)
end
end

function UISubAct_xianshichouka_selectUpWin:refreshRoleItemSelect(item,index,flag)
if item==nil then
item=self.curroleGridPanel:getChildCommonLayoutGroupWidgetItem(index-1)
end
item:SetChildActive(7,flag)
item:SetChildActive(8,flag)
item:SetChildActive(11,flag)
if flag then


item:SetChildUIModelShowTarget(10,5295,1,{},5,false,false,0,function()

end)
end

end

function UISubAct_xianshichouka_selectUpWin:onRoleItemClick(index)
if self.selectIndex==index then
return
end
if self.selectIndex~=nil then
self:refreshRoleItemSelect(nil,self.selectIndex,false)
end
self.selectIndex=index
self:refreshRoleItemSelect(nil,index,true)

end

function UISubAct_xianshichouka_selectUpWin:onClickClose()
self:checkSelect()
self:closeSelf()
end

function UISubAct_xianshichouka_selectUpWin:checkSelect()
if self.selectIndex==nil then return end
local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
if self.selectIndex==selectIndex then
return
end

local json_str=jsonHelper.encode({1,self.selectIndex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end


function UISubAct_xianshichouka_selectUpWin:refreshDailyReward()
if not self.info then
return
end

local isGot=self.info:reqXianShiChouKa_checkDailyRewardsIsGot()

if isGot then



self.rewardBtn:setActive(false)
self.baoXiangReddot:setActive(false)
self:doPunchRotation(false)
else

self.rewardBtn:setActive(true)
self.baoXiangReddot:setActive(true)
self:doPunchRotation(true)
end
end



function UISubAct_xianshichouka_selectUpWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setRotation(0,0,0)
end
end
end


function UISubAct_xianshichouka_selectUpWin:onRewardBtn()
if not self.info then
return
end

local isGot=self.info:reqXianShiChouKa_checkDailyRewardsIsGot()
if isGot then

return
end

self.info:reqXianShiChouKa_getDailyRewards()
end