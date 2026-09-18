







def_class("UISubAct_xianshichouka_selectUpWin_Role",UIWindowBase)









function UISubAct_xianshichouka_selectUpWin_Role:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.roleGridPanel=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.rewardBtn=UIButton.get(self,4)
self.baoXiangReddot=UIImage.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_xianshichouka_selectUpWin_Role:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleGridPanel);self.roleGridPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
end
















local _this=nil


function UISubAct_xianshichouka_selectUpWin_Role:onLoaded(...)
_this=self
self:bindComponents()

if webGLHelper:isNeedAdaption()then
local pos=self.closeBtn:getChildAnchoredPosition3D()
self.closeBtn:setChildAnchoredPosition3D(Vector3.New(pos.x,230,0))
end
end


function UISubAct_xianshichouka_selectUpWin_Role:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_xianshichouka_selectUpWin_Role:onHide()

end




function UISubAct_xianshichouka_selectUpWin_Role:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
if selectIndex==0 then
selectIndex=nil
end
self.selectIndex=selectIndex

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

function UISubAct_xianshichouka_selectUpWin_Role:refreshRoleGridPanel()
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local defaultdz=sub_actcfg.defaultdz
local disciple=sub_actcfg.disciple
local disciple_period=disciple[self.myData.period_idx][2]

local num=#disciple_period
local grids=self.roleGridPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local itemID=disciple_period[i][1]
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

function UISubAct_xianshichouka_selectUpWin_Role:refreshRoleItemSelect(item,index,flag)
if item==nil then
item=self.roleGridPanel:getChildCommonLayoutGroupWidgetItem(index-1)
end
item:SetChildActive(7,flag)
item:SetChildActive(8,flag)
item:SetChildActive(11,flag)
if flag then


item:SetChildUIModelShowTarget(10,5295,1,{},5,false,false,0,function()

end)
end

end

function UISubAct_xianshichouka_selectUpWin_Role:onRoleItemClick(index)
if self.selectIndex==index then
return
end
if self.selectIndex~=nil then
self:refreshRoleItemSelect(nil,self.selectIndex,false)
end
self.selectIndex=index
self:refreshRoleItemSelect(nil,index,true)

end

function UISubAct_xianshichouka_selectUpWin_Role:onClickClose()
self:checkSelect()
self:closeSelf()
end

function UISubAct_xianshichouka_selectUpWin_Role:checkSelect()
if self.selectIndex==nil then return end
local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
if self.selectIndex==selectIndex then
return
end

local json_str=jsonHelper.encode({1,self.myData.period_idx,self.selectIndex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end


function UISubAct_xianshichouka_selectUpWin_Role:refreshDailyReward()
if not self.info then
return
end

local isGot=self.info:reqXianShiChouKa_checkDailyRewardsIsGot()

if isGot then



self.rewardBtn:setActive(true)
self.baoXiangReddot:setActive(true)
self:doPunchRotation(true)
else

self.rewardBtn:setActive(false)
self.baoXiangReddot:setActive(false)
self:doPunchRotation(false)
end
end



function UISubAct_xianshichouka_selectUpWin_Role:doPunchRotation(reddot)
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


function UISubAct_xianshichouka_selectUpWin_Role:onRewardBtn()
if not self.info then
return
end

local isGot=self.info:reqXianShiChouKa_checkDailyRewardsIsGot()
if not isGot then

return
end

self.info:reqXianShiChouKa_getDailyRewards()
end

function UISubAct_xianshichouka_selectUpWin_Role:onCloseBtn()
self:onClickClose()
end