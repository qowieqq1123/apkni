







def_class("UIXianJie_cloudUnlockMapWin",UIWindowBase)









function UIXianJie_cloudUnlockMapWin:bindComponents()

self.gridItem_1=UIObject.get(self,0)
self.gridItem_10=UIObject.get(self,1)
self.gridItem_11=UIObject.get(self,2)
self.gridItem_12=UIObject.get(self,3)
self.gridItem_13=UIObject.get(self,4)
self.gridItem_14=UIObject.get(self,5)
self.gridItem_15=UIObject.get(self,6)
self.gridItem_16=UIObject.get(self,7)
self.gridItem_17=UIObject.get(self,8)
self.gridItem_18=UIObject.get(self,9)
self.gridItem_19=UIObject.get(self,10)
self.gridItem_2=UIObject.get(self,11)
self.gridItem_20=UIObject.get(self,12)
self.gridItem_21=UIObject.get(self,13)
self.gridItem_22=UIObject.get(self,14)
self.gridItem_23=UIObject.get(self,15)
self.gridItem_24=UIObject.get(self,16)
self.gridItem_25=UIObject.get(self,17)
self.gridItem_26=UIObject.get(self,18)
self.gridItem_27=UIObject.get(self,19)
self.gridItem_28=UIObject.get(self,20)
self.gridItem_29=UIObject.get(self,21)
self.gridItem_3=UIObject.get(self,22)
self.gridItem_30=UIObject.get(self,23)
self.gridItem_31=UIObject.get(self,24)
self.gridItem_32=UIObject.get(self,25)
self.gridItem_33=UIObject.get(self,26)
self.gridItem_34=UIObject.get(self,27)
self.gridItem_35=UIObject.get(self,28)
self.gridItem_36=UIObject.get(self,29)
self.gridItem_37=UIObject.get(self,30)
self.gridItem_38=UIObject.get(self,31)
self.gridItem_39=UIObject.get(self,32)
self.gridItem_4=UIObject.get(self,33)
self.gridItem_40=UIObject.get(self,34)
self.gridItem_41=UIObject.get(self,35)
self.gridItem_42=UIObject.get(self,36)
self.gridItem_43=UIObject.get(self,37)
self.gridItem_44=UIObject.get(self,38)
self.gridItem_45=UIObject.get(self,39)
self.gridItem_46=UIObject.get(self,40)
self.gridItem_47=UIObject.get(self,41)
self.gridItem_48=UIObject.get(self,42)
self.gridItem_49=UIObject.get(self,43)
self.gridItem_5=UIObject.get(self,44)
self.gridItem_6=UIObject.get(self,45)
self.gridItem_7=UIObject.get(self,46)
self.gridItem_8=UIObject.get(self,47)
self.gridItem_9=UIObject.get(self,48)
self.mapContent=UIObject.get(self,49)
self.mapGrid=UIObject.get(self,50)
self.mapInfoBtn=UIButton.get(self,51)
self.maxReward=UIButton.get(self,52)
self.maxRewardTips=UIButton.get(self,53)
self.rewadProgress=UIObject.get(self,54)
self.rewardContent=UIObject.get(self,55)
self.rewardGrid=UIObject.get(self,56)
self.rewardNumTxt=UIText.get(self,57)
self.rewardProgressBar=UIObject.get(self,58)
self.rewardProgresseffect=UIObject.get(self,59)
self.rewardScrollView=UIObject.get(self,60)
self.root=UIObject.get(self,61)
self.unlockModel=UIObject.get(self,62)

self.mapInfoBtn:setButtonClick(function()self:onMapInfoBtn()end)

self.maxReward:setButtonClick(function()self:onMaxReward()end)

self.maxRewardTips:setButtonClick(function()self:onMaxRewardTips()end)
self.gridItem={
self.gridItem_1,
self.gridItem_2,
self.gridItem_3,
self.gridItem_4,
self.gridItem_5,
self.gridItem_6,
self.gridItem_7,
self.gridItem_8,
self.gridItem_9,
self.gridItem_10,
self.gridItem_11,
self.gridItem_12,
self.gridItem_13,
self.gridItem_14,
self.gridItem_15,
self.gridItem_16,
self.gridItem_17,
self.gridItem_18,
self.gridItem_19,
self.gridItem_20,
self.gridItem_21,
self.gridItem_22,
self.gridItem_23,
self.gridItem_24,
self.gridItem_25,
self.gridItem_26,
self.gridItem_27,
self.gridItem_28,
self.gridItem_29,
self.gridItem_30,
self.gridItem_31,
self.gridItem_32,
self.gridItem_33,
self.gridItem_34,
self.gridItem_35,
self.gridItem_36,
self.gridItem_37,
self.gridItem_38,
self.gridItem_39,
self.gridItem_40,
self.gridItem_41,
self.gridItem_42,
self.gridItem_43,
self.gridItem_44,
self.gridItem_45,
self.gridItem_46,
self.gridItem_47,
self.gridItem_48,
self.gridItem_49,
}



end


function UIXianJie_cloudUnlockMapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gridItem_1);self.gridItem_1=nil;
_UIObject_release(self.gridItem_10);self.gridItem_10=nil;
_UIObject_release(self.gridItem_11);self.gridItem_11=nil;
_UIObject_release(self.gridItem_12);self.gridItem_12=nil;
_UIObject_release(self.gridItem_13);self.gridItem_13=nil;
_UIObject_release(self.gridItem_14);self.gridItem_14=nil;
_UIObject_release(self.gridItem_15);self.gridItem_15=nil;
_UIObject_release(self.gridItem_16);self.gridItem_16=nil;
_UIObject_release(self.gridItem_17);self.gridItem_17=nil;
_UIObject_release(self.gridItem_18);self.gridItem_18=nil;
_UIObject_release(self.gridItem_19);self.gridItem_19=nil;
_UIObject_release(self.gridItem_2);self.gridItem_2=nil;
_UIObject_release(self.gridItem_20);self.gridItem_20=nil;
_UIObject_release(self.gridItem_21);self.gridItem_21=nil;
_UIObject_release(self.gridItem_22);self.gridItem_22=nil;
_UIObject_release(self.gridItem_23);self.gridItem_23=nil;
_UIObject_release(self.gridItem_24);self.gridItem_24=nil;
_UIObject_release(self.gridItem_25);self.gridItem_25=nil;
_UIObject_release(self.gridItem_26);self.gridItem_26=nil;
_UIObject_release(self.gridItem_27);self.gridItem_27=nil;
_UIObject_release(self.gridItem_28);self.gridItem_28=nil;
_UIObject_release(self.gridItem_29);self.gridItem_29=nil;
_UIObject_release(self.gridItem_3);self.gridItem_3=nil;
_UIObject_release(self.gridItem_30);self.gridItem_30=nil;
_UIObject_release(self.gridItem_31);self.gridItem_31=nil;
_UIObject_release(self.gridItem_32);self.gridItem_32=nil;
_UIObject_release(self.gridItem_33);self.gridItem_33=nil;
_UIObject_release(self.gridItem_34);self.gridItem_34=nil;
_UIObject_release(self.gridItem_35);self.gridItem_35=nil;
_UIObject_release(self.gridItem_36);self.gridItem_36=nil;
_UIObject_release(self.gridItem_37);self.gridItem_37=nil;
_UIObject_release(self.gridItem_38);self.gridItem_38=nil;
_UIObject_release(self.gridItem_39);self.gridItem_39=nil;
_UIObject_release(self.gridItem_4);self.gridItem_4=nil;
_UIObject_release(self.gridItem_40);self.gridItem_40=nil;
_UIObject_release(self.gridItem_41);self.gridItem_41=nil;
_UIObject_release(self.gridItem_42);self.gridItem_42=nil;
_UIObject_release(self.gridItem_43);self.gridItem_43=nil;
_UIObject_release(self.gridItem_44);self.gridItem_44=nil;
_UIObject_release(self.gridItem_45);self.gridItem_45=nil;
_UIObject_release(self.gridItem_46);self.gridItem_46=nil;
_UIObject_release(self.gridItem_47);self.gridItem_47=nil;
_UIObject_release(self.gridItem_48);self.gridItem_48=nil;
_UIObject_release(self.gridItem_49);self.gridItem_49=nil;
_UIObject_release(self.gridItem_5);self.gridItem_5=nil;
_UIObject_release(self.gridItem_6);self.gridItem_6=nil;
_UIObject_release(self.gridItem_7);self.gridItem_7=nil;
_UIObject_release(self.gridItem_8);self.gridItem_8=nil;
_UIObject_release(self.gridItem_9);self.gridItem_9=nil;
_UIObject_release(self.mapContent);self.mapContent=nil;
_UIObject_release(self.mapGrid);self.mapGrid=nil;
_UIObject_release(self.mapInfoBtn);self.mapInfoBtn=nil;
_UIObject_release(self.maxReward);self.maxReward=nil;
_UIObject_release(self.maxRewardTips);self.maxRewardTips=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardProgresseffect);self.rewardProgresseffect=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockModel);self.unlockModel=nil;
self.gridItem=nil;
end
















local gridCmp={
lock=0,
select=1,
btn=2,
line=3,
statePanel=4,
cloudState=5,
dzSearchPanel=6,
dzSearchHead=7,
effect=8,
qwEffect=9,
reddot=10,
}


local tanchaIconIdxMap={
[1]=10,
[2]=11,
[3]=12,
[4]=9,
[8]=13,
[9]=8,
[15]=14,
[16]=7,
[22]=15,
[23]=6,
[29]=16,
[30]=4,
[34]=5,
[35]=1,
[36]=2,
[37]=3,
}

local tanchaEffectIdMap={
[1]=20622,
[2]=20621,
[3]=20622,
[4]=20620,
[8]=20620,
[9]=20622,
[15]=20622,
[16]=20621,
[22]=20621,
[23]=20622,
[29]=20622,
[30]=20620,
[34]=20620,
[35]=20622,
[36]=20621,
[37]=20622,
}

local _this




function UIXianJie_cloudUnlockMapWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onXianJieWaiPaiChange,function(...)self:refreshInfo()end)
end


function UIXianJie_cloudUnlockMapWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJie_cloudUnlockMapWin:onShow(argtable,afterOnloaded)
self.hasWaiPaiTeamNum=xianjieModel:checkWaiPaiTeamNum(false)

self:initPanel()
self:initRewardPanel(false,true)

self.mapGrid:setChildCanvasGroupAlpha(0)
self.rewardScrollView:setChildCanvasGroupAlpha(0)
self.mapGrid:setChildCanvasGroupDOFade(1,0.5,nil)
self.rewardScrollView:setChildCanvasGroupDOFade(1,0.5,nil)
end

function UIXianJie_cloudUnlockMapWin:initPanel()
local useless=cfgHelper.get2(cfg_fairylandcloudbaseconfig_get,1,'useless')
for i,cloudid in ipairs(useless)do
self.gridItem[cloudid]:setActive(false)
end
local iconIdx=0
self.tanchaCloudidByIdx={}
local list=cfg_fairylandcloudconfig()
for cloudid,cfg in ipairs(list)do
local maxid=0
for i,cloudid_ in ipairs(cfg.ids)do
maxid=math.max(maxid,cloudid_)
local minid=math.min(maxid,cloudid_)
if minid~=0 and minid~=maxid then
self.gridItem[minid]:setActive(false)
end
end
local item=self.winlua:GetChildWidgetBase(self.gridItem[maxid]:getID())

item:SetChildWeakGuideComponentId(-1,FMT.fmt('UIXianJie_cloudUnlockMapWin.item{0}',cloudid))

item:SetChildNewBieComponentId(2,'UIXianJie_cloudUnlockMapWin.item'..cloudid)

iconIdx=iconIdx+1
local tanchaIconIdx=tanchaIconIdxMap[iconIdx]or 17
local maxGrid=self.winlua:GetChildWidgetBase(self.gridItem[maxid]:getID())
maxGrid:SetChildCSImageSprite(gridCmp.lock,globalABLookup.xjcloudunlockmapgrid,FMT.fmt("image_xianwutanchabgqt_{0}",iconIdx))
maxGrid:SetChildCSImageSprite(gridCmp.line,globalABLookup.xjcloudunlockmaptancha,FMT.fmt("image_xianwutanchaxtui_{0}",tanchaIconIdx))
maxGrid:SetChildCSImageSprite(gridCmp.select,globalABLookup.xjcloudunlockmaptancha,FMT.fmt("image_xianwutanchaxzui_{0}",tanchaIconIdx))
self.tanchaCloudidByIdx[cloudid]=iconIdx
self:setCloudItem(cloudid)
end
end

function UIXianJie_cloudUnlockMapWin:refreshInfo()
self.hasWaiPaiTeamNum=xianjieModel:checkWaiPaiTeamNum(false)
local list=cfg_fairylandcloudconfig()
for cloudid,cfg in ipairs(list)do
self:setCloudItem(cloudid)
for i,cloudid_ in ipairs(cfg.border)do
self:setCloudItem(cloudid_)
end
end
end

function UIXianJie_cloudUnlockMapWin:refreshItem(cloudid)
local cfg=cfgHelper.get1(cfg_fairylandcloudconfig_get,cloudid)
self:setCloudItem(cloudid)
for i,cloudid_ in ipairs(cfg.border)do
self:setCloudItem(cloudid_)
end
self:initRewardPanel(true)
end

function UIXianJie_cloudUnlockMapWin:setCloudItem(cloudid)
local cfg=cfgHelper.get1(cfg_fairylandcloudconfig_get,cloudid)
local maxid=0
for i,cloudid_ in ipairs(cfg.ids)do
maxid=math.max(maxid,cloudid_)
end
self.gridItem[maxid]:setActive(true)

local state
local maxGrid=self.winlua:GetChildWidgetBase(self.gridItem[maxid]:getID())
local canSearch=xianjieModel:checkCloudCanSearch(cloudid)
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData then
if cloudData:isUnlock()then
state=0
elseif cloudData:canUnlock()then
state=1
maxGrid:SetChildCSImageSprite(gridCmp.cloudState,globalABLookup.xjtaskicons,"image_rwzt_gth2")
elseif cloudData:hasMsg()then
state=1
local canUnlock=cloudData:canUnlock()
local qyData=cloudData:getQiYuData()
local icon=canUnlock or not qyData and'image_rwzt_gth2'or'image_rwzt_wh2'
maxGrid:SetChildCSImageSprite(gridCmp.cloudState,globalABLookup.xjtaskicons,icon)
elseif cloudData:getDZData()then
local unlockTime=cloudData:getUnlockTime()
local curTime=gameUtilityModel.getServerShortTime2()
local lerp=unlockTime-curTime
if lerp>0 then
state=2
local netData=cloudData:getDZData()
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(gridCmp.dzSearchHead,maxGrid,modelParams,eHeadCenterType.eHead,nil,false)

self:setTimer(lerp,1,function()
self:setCloudItem(cloudid)
end)
else
state=1
maxGrid:SetChildCSImageSprite(gridCmp.cloudState,globalABLookup.xjtaskicons,"image_rwzt_gth2")
end
end
end
maxGrid:SetChildActive(gridCmp.line,state~=0)
maxGrid:SetChildActive(gridCmp.lock,state~=0)
maxGrid:SetChildActive(gridCmp.reddot,state==1)
maxGrid:SetChildActive(gridCmp.statePanel,state==1)
maxGrid:SetChildActive(gridCmp.dzSearchPanel,state==2)


local hasDisciple=xianjieModel:getIsHasDisciple(cloudid)
if state~=0 and canSearch and self.hasWaiPaiTeamNum and hasDisciple then
local idx=self.tanchaCloudidByIdx[cloudid]
local qwEffctID=20619
if idx and tanchaEffectIdMap[idx]then
qwEffctID=tanchaEffectIdMap[idx]
end
maxGrid:SetChildShowEffect(gridCmp.qwEffect,qwEffctID,true)
else
maxGrid:SetChildShowEffect(gridCmp.qwEffect,0,false)
end


local effect=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'effect')
local showEffect=effect~=nil
if showEffect then


end

local onClickFun=function()
local cloudData=xianjieModel:getCloudData(cloudid)
local canSearch=xianjieModel:checkCloudCanSearch(cloudid)
if not cloudData and not canSearch then
UIManager.error("请先探查宗门周围仙雾")
self:closeMapInfoWin()
return
end
if cloudData and cloudData:isUnlock()then
self:closeMapInfoWin()
return
end
if self.selectCloudid then
self:setSelect(self.selectCloudid,false)
end
self.selectCloudid=cloudid
self:setSelect(cloudid,true)
self:handleClickCloud(cloudid)
end
maxGrid:SetChildButtonClick(gridCmp.btn,onClickFun,true)
end

function UIXianJie_cloudUnlockMapWin:setSelect(cloudid,isSelect)
local cfg=cfgHelper.get1(cfg_fairylandcloudconfig_get,cloudid)
local maxid=0
for i,cloudid_ in ipairs(cfg.ids)do
maxid=math.max(maxid,cloudid_)
end
local maxGrid=self.winlua:GetChildWidgetBase(self.gridItem[maxid]:getID())
maxGrid:SetChildActive(gridCmp.select,isSelect)
maxGrid:SetChildActive(gridCmp.qwEffect,not isSelect)
end

function UIXianJie_cloudUnlockMapWin:handleClickCloud(cloudid)
local cloudData=xianjieModel:getCloudData(cloudid)
if cloudData and cloudData:isUnlock()then
return
end
self:openSeardCloudInfoWin(cloudid)
end

function UIXianJie_cloudUnlockMapWin:openSeardCloudInfoWin(cloudid)
UIManager:showWindow('UIXianJie_cloudUnlockMapInfoWin',{cloudid=cloudid})
self.mapInfoBtn:setActive(true)
end


function UIXianJie_cloudUnlockMapWin:onHide()

end


function UIXianJie_cloudUnlockMapWin:initRewardPanel(anim,isInit)
local target_conf=cfgHelper.get2(cfg_fairylandexplorebaseconfig_get,1,"target_conf")
local unlock_queue=cfgHelper.get2(cfg_fairylandexplorebaseconfig_get,1,"unlock_queue")
local maxCount=unlock_queue[1]
local total=xianjieModel:getCloudUnlockCount()
local recvIdx=xianjieModel:getCloudRewardRecvIdx()
local speed=400
local stepHeight=100
local itemH=26
local contentOffset={500,500}
self.rewardProgressBar:setChildAnchoredPosition(Vector2(-50,-contentOffset[1]))
self.rewardGrid:setChildAnchoredPosition(Vector2(0,0))

local max=#target_conf
local curIndex=0
for i,d in ipairs(target_conf)do
if total>=(d[1]or 0)then
curIndex=i
end
end

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
local d=target_conf[i]or{}
local num=d[1]or 0
local reward=d[2]
local fix=total>=num
local rewardFlag=recvIdx>=i
local isGray=fix and rewardFlag


local posY=i*stepHeight-itemH
item:SetChildAnchoredPosition(-1,Vector2(0,posY))

if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(i)
end)
end

item:SetChildText(1,num)

item:SetChildActive(2,fix and rewardFlag)

item:SetChildActive(4,fix and not rewardFlag)
if fix and not rewardFlag then
item:SetChildAnimationStringID(4,"cloudunlock_reward_biankuang",true)
end

item:SetChildActive(9,fix and not rewardFlag)

item:SetChildActive(5,not fix)

item:SetChildActive(6,fix)

item:SetChildImageExGray(3,isGray)

item:SetChildImageExGray(7,isGray)

item:SetChildImageExGray(8,isGray)
end
local showHeight=self.rewardScrollView:getChildRectHeight()

local content_height=math.max(showHeight,(max+1)*stepHeight-itemH*2)+contentOffset[1]+contentOffset[2]
local max_height=math.max(showHeight,(max+1)*stepHeight-itemH*2)
self.rewardContent:setChildSizeDelta(100,max_height)


self.rewardProgressBar:setChildSizeDelta(84,content_height)

local cur_height
if curIndex<=0 then
cur_height=contentOffset[1]+total/target_conf[curIndex+1][1]*(stepHeight-itemH-23)
elseif total>=maxCount then
cur_height=content_height
else
local nextCount=curIndex>=max and maxCount or target_conf[curIndex+1][1]
local rate=(total-target_conf[curIndex][1])/(nextCount-target_conf[curIndex][1])
if rate==0 then
cur_height=contentOffset[1]+curIndex*stepHeight-itemH
elseif curIndex>=max then
cur_height=contentOffset[1]+curIndex*stepHeight-itemH+23+(max_height-curIndex*stepHeight-23)*rate
else
cur_height=contentOffset[1]+curIndex*stepHeight-itemH+23+(stepHeight-46)*rate
end
end
if anim then
local lerp=math.abs(cur_height-26)
self.rewadProgress:setChildDOSizeDelta(Vector2(20,cur_height),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(20,cur_height)
end

self.rewardNumTxt:setText(total)

if isInit then
local moveY=curIndex>1 and(curIndex-1)*stepHeight+20 or 0
local max_height_=max_height-showHeight
if moveY>max_height_ then
moveY=max_height_
end
self.rewardContent:setLocalPosY(-showHeight-moveY)
end

local isRecvQueue=xianjieModel:getCloudIsRecvQueue()
local canRecv=total>=maxCount and not isRecvQueue
local slot=self.winlua:GetChildWidgetBase(self.maxReward:getID())
slot:SetChildActive(0,total<maxCount)
slot:SetChildActive(1,total>=maxCount)
slot:SetChildActive(3,isRecvQueue)
slot:SetChildActive(5,canRecv)
slot:SetChildText(2,maxCount)

if canRecv then
slot:SetChildShowEffect(4,20618,true)

if self.reddotTweener==nil then
slot:SetChildRotation(5,0,0,0)
local tweener=slot:SetChildDOPunchRotation(5,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
slot:SetChildShowEffect(4,0,false)

if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
slot:SetChildRotation(5,0,0,0)
end
end
end

function UIXianJie_cloudUnlockMapWin:onClickItem(index)
local total=xianjieModel:getCloudUnlockCount()
local recvIdx=xianjieModel:getCloudRewardRecvIdx()

local target_conf=cfgHelper.get2(cfg_fairylandexplorebaseconfig_get,1,"target_conf")
local d=target_conf[index]
local num=d[1]
local reward=d[2]
local fix=total>=num
local rewardFlag=recvIdx>=index

local itemid=reward[1]
if fix and not rewardFlag then
local max=index
for i=index,#target_conf do
local curNum=target_conf[i][1]
local curFix=total>=curNum
local curRewardFlag=recvIdx>=i
if curFix and not curRewardFlag then
max=i
else
break
end
end
xianjieController:reqGetCloudUnlockReward(max)
else
tipsManager.showTips({itemid=itemid,itemguid=nil})
end
end




function UIXianJie_cloudUnlockMapWin:onMaxReward()
local unlock_queue=cfgHelper.get2(cfg_fairylandexplorebaseconfig_get,1,"unlock_queue")
local maxCount=unlock_queue[1]
local total=xianjieModel:getCloudUnlockCount()
local isRecvQueue=xianjieModel:getCloudIsRecvQueue()
if total>=maxCount and not isRecvQueue then
xianjieController:reqGetCloudUnlockQueue()
else
self.maxRewardTips:setActive(true)
end
end

function UIXianJie_cloudUnlockMapWin:onMaxRewardTips()
self.maxRewardTips:setActive(false)
end

function UIXianJie_cloudUnlockMapWin:onCloseClick()
UIFullCloudUnlockMapControl:closeUI(true,true)
end

function UIXianJie_cloudUnlockMapWin:onMapInfoBtn()
self:closeMapInfoWin()
end

function UIXianJie_cloudUnlockMapWin:closeMapInfoWin()
UIManager:closeWindow('UIXianJie_cloudUnlockMapInfoWin')
self.mapInfoBtn:setActive(false)
if self.selectCloudid then
self:setSelect(self.selectCloudid,false)
self.selectCloudid=nil
end
end
