







def_class("UIHongChenJieRankingWin",UIWindowBase)









function UIHongChenJieRankingWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.Content=UIObject.get(self,1)
self.leftArr=UIButton.get(self,2)
self.leftReddot=UIObject.get(self,3)
self.rankingList=UIScrollView.get(self,4)
self.rightArr=UIButton.get(self,5)
self.rightReddot=UIObject.get(self,6)
self.Root=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftArr:setButtonClick(function()self:onLeftArr()end)

self.rightArr:setButtonClick(function()self:onRightArr()end)



end


function UIHongChenJieRankingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.leftArr);self.leftArr=nil;
_UIObject_release(self.leftReddot);self.leftReddot=nil;
_UIObject_release(self.rankingList);self.rankingList=nil;
_UIObject_release(self.rightArr);self.rightArr=nil;
_UIObject_release(self.rightReddot);self.rightReddot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local CmpRankingItemIndex={
bg=0,
titlebg=1,
title=2,
statebg=3,
defaultimg=4,
okroot=5,
headimg=6,
playerzmname=7,
playername=8,
rewardlist=9,
tiproot=10,
rtitle=11,
rtip=12,
taglist=13,
selfFinishBtn=14,
finishimg=15,
otherFinishBtn=16,
reachReddot=17,
tip=18,
headbg=19,
reddot=20,
}

local itemWight=347
local leftOffset=3
local itemGap=10
local leftOffsetSpan=300
local scvWidth=1142



function UIHongChenJieRankingWin:onLoaded(...)
self:bindComponents()
self.rankingList:bindScrollWidget(function(...)self:bindRankingItem(...)end)

self.selectIndex=0
self:addNotify(notifyConfig.onHongChenJieRankingFresh,function(...)self:onHongChenJieRankingFresh(...)end)

self.reddotTweenerList={}
end


function UIHongChenJieRankingWin:__delete()
self:unbindComponents()
end




function UIHongChenJieRankingWin:onShow(argtable,afterOnloaded)
self.id=argtable.id

self.data=hongChenJieModel:getGameHandle(self.id)

self:refreshList()
self:freshJiantou()
end


function UIHongChenJieRankingWin:onHide()

end

function UIHongChenJieRankingWin:refreshList()
self.rankingDataList=self.data:getRankingDataList()
local len=#self.rankingDataList
self.rankLen=len

self.rankingList:freshGridsNum(len,1,len,false)

end

function UIHongChenJieRankingWin:bindRankingItem(index,item)
local rankingData=self.rankingDataList[index]
local sid=self.id

local isShowItem=rankingData~=nil
item:SetChildActive(-1,isShowItem)
if isShowItem then
local isSelfFinishRewrd=self.data:checkSelfFinishState(rankingData.cfg.id)
local isOtherFinishReward=self.data:checkOtherFinishState(rankingData.cfg.id)

local isShowSelfFinishBtn=rankingData.reachFlag~=2
local isShowOkRoot=rankingData.data.actor_id~=nil
local isShowTag=not isShowOkRoot and rankingData.cfg.tags~=nil
local isShowOtherFinishBtn=isShowOkRoot and not isOtherFinishReward


item:SetChildActive(CmpRankingItemIndex.okroot,isShowOkRoot)
item:SetChildActive(CmpRankingItemIndex.defaultimg,not isShowOkRoot)
item:SetChildActive(CmpRankingItemIndex.taglist,isShowTag)

item:SetChildActive(CmpRankingItemIndex.finishimg,isSelfFinishRewrd)
item:SetChildActive(CmpRankingItemIndex.otherFinishBtn,isShowOtherFinishBtn)
item:SetChildActive(CmpRankingItemIndex.rtip,isShowOkRoot)
item:SetChildActive(CmpRankingItemIndex.tip,not isShowOkRoot)
item:SetChildActive(CmpRankingItemIndex.selfFinishBtn,isShowSelfFinishBtn)

self:doPunchRotation(item,CmpRankingItemIndex.reddot,index,rankingData.cfg.id,isShowSelfFinishBtn)

item:SetChildButtonEnable(CmpRankingItemIndex.selfFinishBtn,true,rankingData.reachFlag==0)

local titleTxt=rankingData.cfg.title
local rewardcfg=rankingData.cfg.reach_reward_list
local tipTitleTxt='目标提示'
local suffix=hongChenJieConfig.getRankingTipSuffix(rankingData)
local result=rankingData.cfg.result

if suffix~=''then
result=FMT.fmt("{0}\n{1}",result,suffix)
end

if isShowOkRoot then
tipTitleTxt='达成条件'


local iconInfo=rankingData.data.iconInfo
playerController:setRawImageHeadIcon(item,CmpRankingItemIndex.headimg,{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

local zmName=rankingData.data.guild_name

local playerzmname=loginModel:getServerName(rankingData.data.server_id)
item:SetChildText(CmpRankingItemIndex.playerzmname,playerzmname)

local name=rankingData.data.name
item:SetChildText(CmpRankingItemIndex.playername,name)
end

item:SetChildText(CmpRankingItemIndex.title,titleTxt)
item:SetChildText(CmpRankingItemIndex.rtitle,tipTitleTxt)
item:SetChildText(CmpRankingItemIndex.rtip,result)
item:SetChildText(CmpRankingItemIndex.tip,rankingData.cfg.tip or result)


item:SetChildLayoutGroupCreateItems(CmpRankingItemIndex.rewardlist,#rewardcfg,function(rindex)
local ritem=item:GetChildLayoutGroupGridItem(CmpRankingItemIndex.rewardlist,rindex-1)
local rdata=rewardcfg[rindex]
local isShowRItem=rdata~=nil
ritem:SetChildActive(-1,isShowRItem)
if isShowRItem then
local itemId=rdata[1]
local itemNum=rdata[2]
local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
ritem:SetChildPropData(-1,prop)
ritem:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemId)
end)
end
end)

if isShowTag then
local tags=rankingData.cfg.tags
item:SetChildLayoutGroupCreateItems(CmpRankingItemIndex.taglist,#tags,function(tindex)
local titem=item:GetChildLayoutGroupGridItem(CmpRankingItemIndex.taglist,tindex-1)
local name=tags[tindex]
titem:SetChildText(0,name)
end)
end

item:SetChildButtonClick(CmpRankingItemIndex.selfFinishBtn,function()
if rankingData.reachFlag==1 then
hongChenJieController:reqReciveRankingReward(sid,2,rankingData.id)
else
UIManager.info('达成条件可领取奖励')
end
end,true)

if isShowOtherFinishBtn then
item:SetChildButtonClick(CmpRankingItemIndex.otherFinishBtn,function()
hongChenJieController:reqReciveRankingReward(sid,1,rankingData.id)
end,true)
end

if isShowOkRoot then
item:SetChildButtonClick(CmpRankingItemIndex.headbg,function()
local attach=nil
local actorID=rankingData.data.actor_id
if hongChenJieModel:isCrossServer(self.id)then attach={serverid=rankingData.data.server_id}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)
end
end
end

function UIHongChenJieRankingWin:freshJiantou()
local pos=self.Content:getChildAnchoredPosition()
local totalWidth=leftOffset+self.rankLen*itemWight+(self.rankLen-1)*itemGap
local lstate=pos.x<-leftOffsetSpan
local rstate=pos.x>scvWidth-totalWidth

self.leftArr:setActive(lstate)
self.rightArr:setActive(rstate)
self.selectIndex=self:getCurItemIndex(pos)

local leftReddotState=self:getLeftArrReddot(self.selectIndex-1)
local rightReddotState=self:getRightArrReddot(self.selectIndex+3)

self.leftReddot:setActive(leftReddotState)
self.rightReddot:setActive(rightReddotState)
end

function UIHongChenJieRankingWin:getCurItemIndex(pos)
local posx=pos.x+leftOffset
local index=posx/(itemWight+itemGap)
local residue=posx%(itemWight+itemGap)

index=Mathf.Round(index)
index=Mathf.Abs(index)
residue=Mathf.Abs(residue)
return index+1,residue
end

function UIHongChenJieRankingWin:onHongChenJieRankingFresh(id)
if self.id==id then
self:refreshList()
end
end

function UIHongChenJieRankingWin:getLeftArrReddot(eindex)
if eindex<0 then return false end

for index=1,eindex do
local data=self.rankingDataList[index]
if data.isCanReward then
return true
end
end

return false
end

function UIHongChenJieRankingWin:getRightArrReddot(sindex)
if sindex>self.rankLen then return false end

for index=sindex,self.rankLen do
local data=self.rankingDataList[index]
if data.isCanReward then
return true
end
end

return false
end


function UIHongChenJieRankingWin:onChangeRect()
self:freshJiantou()
end

function UIHongChenJieRankingWin:onLeftArr()
local pos=self.Content:getChildAnchoredPosition()
local index,residue=self:getCurItemIndex(pos)

self.selectIndex=Mathf.Max(index-1,0)
self.rankingList:jumpToLockY(self.selectIndex)
end

function UIHongChenJieRankingWin:onRightArr()
local pos=self.Content:getChildAnchoredPosition()
local index,residue=self:getCurItemIndex(pos)

self.selectIndex=Mathf.Min(index+1,self.rankLen)
self.rankingList:jumpToLockY(self.selectIndex)
end

function UIHongChenJieRankingWin:onCloseBtn()
UIFullHongChenJieControl:closeWindow('UIHongChenJieRankingWin')
end


function UIHongChenJieRankingWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end

function UIHongChenJieRankingWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end
