







def_class("UIXianTuManManWin",UIWindowBase)









function UIXianTuManManWin:bindComponents()

self.model=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.aiModel=UIObject.get(self,2)
self.effect=UIObject.get(self,3)
self.progressRewardScrollView=UILoopListView.new(self,4)
self.stageRewardRoot=UIObject.get(self,5)
self.rewardItem=UIBaseItem.get(self,6)
self.rewardreddot=UIObject.get(self,7)
self.stagerecvFlag=UIObject.get(self,8)
self.stageproTxt=UIText.get(self,9)
self.backBtn=UIButton.get(self,10)
self.backBtnReddot=UIObject.get(self,11)
self.nextBtn=UIButton.get(self,12)
self.nextBtnreddot=UIObject.get(self,13)
self.leijiTxt=UIText.get(self,14)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.progressRewardScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)



end


function UIXianTuManManWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.aiModel);self.aiModel=nil;
_UIObject_release(self.effect);self.effect=nil;
self.progressRewardScrollView:deleteSelf();self.progressRewardScrollView=nil;
_UIObject_release(self.stageRewardRoot);self.stageRewardRoot=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.rewardreddot);self.rewardreddot=nil;
_UIObject_release(self.stagerecvFlag);self.stagerecvFlag=nil;
_UIObject_release(self.stageproTxt);self.stageproTxt=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.backBtnReddot);self.backBtnReddot=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.nextBtnreddot);self.nextBtnreddot=nil;
_UIObject_release(self.leijiTxt);self.leijiTxt=nil;
end


















local _slotName='progressRewardItem'
local abName='ui/windows/activities/sub_qiandao/gongceqiandao_atlas_pak.ab'
local assetName={'image_gongceqiandaoui_1','image_gongceqiandaoui_3'}
local rewardItemIndex={
day=0,
smallitemList={1,2},
bg=3,
}
local smallItemIndex={
effect=12,
}
local RecvFlag=
{
eNotRecv=0,
eRecv=1,
eRecved=2,
}

function UIXianTuManManWin:onLoaded(...)
self:bindComponents()
self.rewardItem:setBaseItemClickEvent(function()
self:onRewardItemClick()
end)
self.config=XianTuManManModel:getConfig()
self:initListCfgLookup()
self.minStage=1
self.maxStage=#self.listCfgLookup
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})

self.model:setChildUIModelShowTarget(5208,1,{},eAnimationID.stand,false,nil,0)
self.model:setChildUIModelShowTargetOffset(0,0)

end


function UIXianTuManManWin:__delete()
self:unbindComponents()
end




function UIXianTuManManWin:onShow(argtable,afterOnloaded)

self.loginDay=XianTuManManModel:getData_loginDay()

self:refreshLoginTxt()
self:refresh()
end


function UIXianTuManManWin:onHide()

end

function UIXianTuManManWin:refresh()
self.curStage=self:CalulateStage()
self:refreshStageReward()
self:refreshBtn()
self:refreshItemList()
end

function UIXianTuManManWin:refreshStageReward()
local itemCfg,proDay=self:getStageReward()
if itemCfg then
self.stageRewardRoot:setActive(true)
local itemid=itemCfg[1]
local itemNum=itemCfg[2]
local itemcount
local conf
local item_data={itemid=itemid,itemcount=itemNum}
local showCountBG
if itemNum>1 then
itemcount=tostring(itemNum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showname=false,showStage=true}

local propData=itemsComponentHelper.getCommonFillData(item_data,conf)
propData[PropIndex(DataPropKey.eWidgetActive,8)]=false
propData[PropIndex(DataPropKey.eWidgetActive,9)]=propData[PropIndex(DataPropKey.eWidgetText,6)]~=""
self.rewardItem:setChildPropData(propData)

local reddot=false
local recFlag=false
self.rewardreddot:setActive(reddot)
self.stagerecvFlag:setActive(recFlag)
self.stageproTxt:setText(string.format("%d天后领取",proDay))
else
self.stageRewardRoot:setActive(false)
end
end

function UIXianTuManManWin:refreshBtn()
self.backBtn:setActive(self.curStage~=self.minStage)
local backBtnReddot=self:getBtnReddot(-1)
self.backBtnReddot:setActive(backBtnReddot)
self.nextBtn:setActive(self.curStage~=self.maxStage)
local nextBtnReddot=self:getBtnReddot(1)
self.nextBtnreddot:setActive(nextBtnReddot)
end

function UIXianTuManManWin:refreshItemList()
local list=self.listCfgLookup[self.curStage]
local len=#list
if len>0 then
self.targetIndex=self:CalulateIndex()
self.progressRewardScrollView:initData(_slotName,list)
self.progressRewardScrollView:jumpItem(self.targetIndex)
end
end

function UIXianTuManManWin:refreshLoginTxt()

self.leijiTxt:setText(string.format("累计登录：%d天",self.loginDay))
end


function UIXianTuManManWin:onFreshAction(i,widget,data)

widget:SetChildText(rewardItemIndex.day,data.day)
widget:SetChildCSImageSprite(rewardItemIndex.bg,abName,assetName[data.bgColor])
local reward=data.reward
for i,v in ipairs(rewardItemIndex.smallitemList)do
local itemCfg=reward[i]
if itemCfg then
local state=self:checkRecvFlag(data)
widget:SetChildActive(v,true)
local conf={
itemid=itemCfg[1],
itemcount=itemCfg[2]<=1 and''or itemCfg[2],
showname=false,
showCountBG=itemCfg[2]>1,
gray=state==RecvFlag.eRecved and 2 or 0,
showStage=true,
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,11)]=state==RecvFlag.eRecved

if state==RecvFlag.eRecv then
local samllItem=widget:GetChildWidgetBase(v)
samllItem:SetChildAnimationStringID(12,"xianshu_light",true)

end
prop[PropIndex(DataPropKey.eWidgetActive,12)]=state==RecvFlag.eRecv
widget:SetChildPropData(v,prop)
widget:SetBaseItemClickEvent(v,function(...)
self:onClickSmallItem(data,...)
end)

else
widget:SetChildActive(v,false)
end

end
end

function UIXianTuManManWin:onStartAction()

end




function UIXianTuManManWin:getBtnReddot(step)
local stage=self.curStage+step

local isNext=step>0
local flag=self:checkStageListRecvFlag(stage,isNext)
return flag
end


function UIXianTuManManWin:getStageReward()
for i,v in ipairs(self.config)do
if v.bigFlag==1 and v.need_days>self.loginDay then
return v.rewards[1],v.need_days-self.loginDay,v.stage,v.need_days
end
end
return nil
end


function UIXianTuManManWin:getStageList()

local stageList=self.listCfgLookup[self.curStage]








return stageList
end

function UIXianTuManManWin:initListCfgLookup()
local lookup={}
local stage
for i,v in ipairs(self.config)do
stage=v.stage
if not lookup[stage]then
lookup[stage]={}
end
local temp={}
temp.id=v.id
temp.day=v.need_days
temp.reward=v.rewards
temp.bgColor=v.bigFlag==1 and 2 or 1
lookup[stage][#lookup[stage]+1]=temp
end
self.listCfgLookup=lookup
end


function UIXianTuManManWin:CalulateStage()
local state
for i,v in ipairs(self.listCfgLookup)do
for ii,vv in ipairs(v)do
state=self:checkRecvFlag(vv)
if state==RecvFlag.eRecv then
return i
end
end
end





for i,v in ipairs(self.listCfgLookup)do
for ii,vv in ipairs(v)do
state=self:checkRecvFlag(vv)
if state==RecvFlag.eNotRecv then
return i
end
end
end
return 1
end

function UIXianTuManManWin:CalulateIndex()
local stagelist=self.listCfgLookup[self.curStage]
local state
for i,v in ipairs(stagelist)do
state=self:checkRecvFlag(v)
if state==RecvFlag.eRecv then
return i
end
end

for i,v in ipairs(stagelist)do
state=self:checkRecvFlag(v)
if state==RecvFlag.eNotRecv then
return i-1>0 and i-1 or 1
end
end









return 1
end

function UIXianTuManManWin:checkRecvFlag(lookUpTemp)
local id=lookUpTemp.id
local rewardsIdx=XianTuManManModel:getData_rewardsIdx()
if id<=rewardsIdx then
return RecvFlag.eRecved
end
local day=lookUpTemp.day
if day<=self.loginDay then
return RecvFlag.eRecv
end
return RecvFlag.eNotRecv
end

function UIXianTuManManWin:checkStageRecvFlag(stage)
local stagelist=self.listCfgLookup[stage]
if not stagelist then
return false
end
local state
for i,v in ipairs(stagelist)do
state=self:checkRecvFlag(v)
if state==RecvFlag.eRecv then
return true
end
end
return false
end


function UIXianTuManManWin:checkStageListRecvFlag(stage,isNext)
local step=isNext and 1 or-1
local target=isNext and self.maxStage or self.minStage
for i=stage,target,step do
if self:checkStageRecvFlag(i)then
return true
end
end
return false
end






function UIXianTuManManWin:onCloseBtn()
local opened=fullScreenUI.isActiveFullEx(FULL_TYPE.eXianTuManMan)
if opened then
UIFullXianTuManManController:closeUI()
else
self:closeSelf()
end
end

function UIXianTuManManWin:onBackBtn()
if self.curStage<=self.minStage then
return
end
self.curStage=self.curStage-1
self:refreshBtn()
self:refreshItemList()
end

function UIXianTuManManWin:onNextBtn()
if self.curStage>=self.maxStage then
return
end
self.curStage=self.curStage+1
self:refreshBtn()
self:refreshItemList()
end


function UIXianTuManManWin:onRewardItemClick()
local itemCfg=self:getStageReward()
if itemCfg then
itemsComponentHelper.onItemClick(itemCfg[1])
end
end

function UIXianTuManManWin:onClickSmallItem(data,itemId,index,guid,attach)
if itemId==-1 then
return
end
local state=self:checkRecvFlag(data)
if state==RecvFlag.eRecv then
XianTuManManController.req_30_12()
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end