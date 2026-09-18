







def_class("UISubAct_xianshichouka_selectUpWin_many",UIWindowBase)









function UISubAct_xianshichouka_selectUpWin_many:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.roleGridPanel=UIObject.get(self,2)
self.jiantou1=UIObject.get(self,3)
self.jiantou2=UIObject.get(self,4)
self.rewardBtn=UIButton.get(self,5)
self.baoXiangReddot=UIImage.get(self,6)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_xianshichouka_selectUpWin_many:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.roleGridPanel);self.roleGridPanel=nil;
_UIObject_release(self.jiantou1);self.jiantou1=nil;
_UIObject_release(self.jiantou2);self.jiantou2=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
end



















local _this=nil


function UISubAct_xianshichouka_selectUpWin_many:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_xianshichouka_selectUpWin_many:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_xianshichouka_selectUpWin_many:onHide()

end




function UISubAct_xianshichouka_selectUpWin_many:onShow(argtable,afterOnloaded)
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


self.jiantou1:setActive(false)
self.jiantou2:setActive(true)
self:UpdataScrollView()
end

function UISubAct_xianshichouka_selectUpWin_many:refreshRoleGridPanel()
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local defaultdz=sub_actcfg.defaultdz
local disciple=sub_actcfg.disciple
local num=#disciple



self.roleGridPanel:setChildLayoutGroupCreateItems(num)
local grids=self.roleGridPanel:getChildLayoutGroupGridList()
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

function UISubAct_xianshichouka_selectUpWin_many:refreshRoleItemSelect(item,index,flag)
if item==nil then
local grids=self.roleGridPanel:getChildLayoutGroupGridList()
item=grids[index-1]

end
item:SetChildActive(7,flag)
item:SetChildActive(8,flag)
item:SetChildActive(11,flag)
if flag then

item:SetChildUIModelShowTarget(10,5295,1,{},5,false,false,0,function()
end)
end

end

function UISubAct_xianshichouka_selectUpWin_many:onRoleItemClick(index)
if self.selectIndex==index then
return
end
if self.selectIndex~=nil then
self:refreshRoleItemSelect(nil,self.selectIndex,false)
end
self.selectIndex=index
self:refreshRoleItemSelect(nil,index,true)

end

function UISubAct_xianshichouka_selectUpWin_many:onClickClose()
self:checkSelect()
self:closeSelf()
end

function UISubAct_xianshichouka_selectUpWin_many:checkSelect()
if self.selectIndex==nil then return end
local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
if self.selectIndex==selectIndex then
return
end

local json_str=jsonHelper.encode({1,self.selectIndex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end



function UISubAct_xianshichouka_selectUpWin_many:refreshDailyReward()
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



function UISubAct_xianshichouka_selectUpWin_many:doPunchRotation(reddot)
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


function UISubAct_xianshichouka_selectUpWin_many:onRewardBtn()
if not self.info then
return
end

local isGot=self.info:reqXianShiChouKa_checkDailyRewardsIsGot()
if isGot then

return
end

self.info:reqXianShiChouKa_getDailyRewards()
end

function UISubAct_xianshichouka_selectUpWin_many:UpdataScrollView()
local pos=self.roleGridPanel:getChildLocalPosition()
self.jiantou1:setActive(pos.x<-25)

local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local disciple=sub_actcfg.disciple
local num=#disciple

self.jiantou2:setActive(pos.x>50-299*(num-3))


self:doPunchRotation1(pos.x<-25,pos.x>50-299*(num-3))

end


function UISubAct_xianshichouka_selectUpWin_many:doPunchRotation1(flag,flag2)
if flag then
if self.jiantou1Tweener==nil then
self.winlua:SetChildLocalPosition(self.jiantou1:getID(),Vector3(-475,0,0))
local tweener=self.winlua:SetChildDOPunchPosition(self.jiantou1:getID(),Vector3(-15,0,0),1,1,1)

tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.jiantou1Tweener=tweener


if self.jiantou2Tweener~=nil and flag2 then
self.jiantou2Tweener:Complete()
self.jiantou2Tweener:Kill()
self.jiantou2Tweener=nil
self.winlua:SetChildLocalPosition(self.jiantou2:getID(),Vector3(485,0,0))

local tweener=self.winlua:SetChildDOPunchPosition(self.jiantou2:getID(),Vector3(15,0,0),1,1,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.jiantou2Tweener=tweener
end
end


else
if self.jiantou1Tweener~=nil then
self.jiantou1Tweener:Complete()
self.jiantou1Tweener:Kill()
self.jiantou1Tweener=nil
self.winlua:SetChildLocalPosition(self.jiantou1:getID(),Vector3(-475,0,0))
end
end


if flag2 then
if self.jiantou2Tweener==nil then
self.winlua:SetChildLocalPosition(self.jiantou2:getID(),Vector3(485,0,0))
local tweener=self.winlua:SetChildDOPunchPosition(self.jiantou2:getID(),Vector3(15,0,0),1,1,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.jiantou2Tweener=tweener


if self.jiantou1Tweener~=nil and flag then
self.jiantou1Tweener:Complete()
self.jiantou1Tweener:Kill()
self.jiantou1Tweener=nil
self.winlua:SetChildLocalPosition(self.jiantou1:getID(),Vector3(-475,0,0))

local tweener=self.winlua:SetChildDOPunchPosition(self.jiantou1:getID(),Vector3(-15,0,0),1,1,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.jiantou1Tweener=tweener
end
end

else
if self.jiantou2Tweener~=nil then
self.jiantou2Tweener:Complete()
self.jiantou2Tweener:Kill()
self.jiantou2Tweener=nil
self.winlua:SetChildLocalPosition(self.jiantou2:getID(),Vector3(485,0,0))
end
end

end

