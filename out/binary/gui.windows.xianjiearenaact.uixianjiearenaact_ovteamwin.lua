







def_class("UIXianJieArenaAct_ovTeamWin",UIWindowBase)









function UIXianJieArenaAct_ovTeamWin:bindComponents()

self.root=UIObject.get(self,0)
self.teamScrollView=UIObject.get(self,1)
self.refreshBtn=UIButton.get(self,2)
self.noTeamTips=UIObject.get(self,3)
self.filterButton=UIButton.get(self,4)
self.filterState=UIObject.get(self,5)
self.filterStateText=UIText.get(self,6)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.filterButton:setButtonClick(function()self:onFilterButton()end)



end


function UIXianJieArenaAct_ovTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.noTeamTips);self.noTeamTips=nil;
_UIObject_release(self.filterButton);self.filterButton=nil;
_UIObject_release(self.filterState);self.filterState=nil;
_UIObject_release(self.filterStateText);self.filterStateText=nil;
end
















local _this
local refreshCd=3
local zyTypeList={
eSelf=1,
eXMAllies=2,
eNotXMAllies=3,
eEnemy=4,
}

local zyTypeIconList={
[zyTypeList.eSelf]="image_xjzhanchangqkui_10",
[zyTypeList.eXMAllies]="image_xjzhanchangqkui_9",
[zyTypeList.eNotXMAllies]="image_xjzhanchangqkui_9",
[zyTypeList.eEnemy]="image_xjzhanchangqkui_8",
}
local teamItemCmpIndex={
typeIcon=0,
name=1,
target=2,
infoBtn=3,
stateStr=4,
gotoBtn=5,
soldierBgIcon=6,
soldierNameIcon=7,
soldierNumText=8,
}

local allArenaIndexList={
[1]=xjClientBuildType.flcbLeiTai6,
[2]=xjClientBuildType.flcbLeiTai2,
[3]=xjClientBuildType.flcbLeiTai8,
[4]=xjClientBuildType.flcbLeiTai3,
[5]=xjClientBuildType.flcbLeiTai5,
[6]=xjClientBuildType.flcbLeiTai1,
[7]=xjClientBuildType.flcbLeiTai7,
[8]=xjClientBuildType.flcbLeiTai4,
}



function UIXianJieArenaAct_ovTeamWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJieArenaAct_ovTeamWin:__delete()
self:clearUpdateTimer()
_this=nil
self:unbindComponents()
end




function UIXianJieArenaAct_ovTeamWin:onShow(argtable,afterOnloaded)
self.page=argtable and argtable.page
self.parentWin=argtable and argtable.parentWin
if argtable and argtable.filterParam then
local filterParam=argtable.filterParam
self:getFilterData(filterParam)
UIManager:invokeUIMethod("UIXianJieArenaAct_ovBgWin","changeExtraArgs",nil)
end


xianJieArenaActController:reqGetXJArenaAllTeamList()

self:refresh()
end


function UIXianJieArenaAct_ovTeamWin:onHide()
self:clearUpdateTimer()
end

function UIXianJieArenaAct_ovTeamWin:refresh()
self:clearUpdateTimer()
self.sortFilterTeamList=self:getSortFilterTeamList()
local teamCount=#self.sortFilterTeamList
self.teamScrollView:setChildScrollViewCreateGrids(teamCount,1)
local girds=self.teamScrollView:getChildScrollViewItemWidgets()
local nowTime=timeHelper.getServerShortTime()
for i=1,girds.Count do
local widget=girds[i-1]
local data=self.sortFilterTeamList[i]
if data then
local actorId=data.data.actorid
local zmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(actorId)
end


local zyType=self:getZhenYingTypeByActorId(actorId)
local zyTypeIconName=zyTypeIconList[zyType]
local abName="ui/windows/xianjiearenaact/xianjiearena_overview_atlas_pak.ab"
widget:SetChildCSImageSprite(teamItemCmpIndex.typeIcon,abName,zyTypeIconName)


local actorName=zmData.actorname
widget:SetChildText(teamItemCmpIndex.name,FMT.fmt("<color=#7d3b17>{0}</color>的集结队伍",actorName))


local arenaId=mathHelper.int64_to_number(data.data.guid)
local arenaCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local nameStr=arenaCfg and arenaCfg.name or"未知擂台"
widget:SetChildText(teamItemCmpIndex.target,FMT.fmt("目标：{0}",nameStr))


local allSoldierCount=0
local soldierList=data.data.moneyList
local maxSoldierLevel
if soldierList and next(soldierList)then
for i,v in ipairs(soldierList)do
local moneyType=v.param_1
local count=v.param_2
if count>0 then
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if not maxSoldierLevel or soldierLevel>maxSoldierLevel then
maxSoldierLevel=soldierLevel
end
allSoldierCount=allSoldierCount+count
end
end
end

widget:SetChildText(teamItemCmpIndex.soldierNumText,mathHelper.formatNumber4(allSoldierCount,1))
if maxSoldierLevel then
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,maxSoldierLevel)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(teamItemCmpIndex.soldierBgIcon,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(teamItemCmpIndex.soldierNameIcon,iconAb,levelIconName)
end


local isChuZheng=data.data.sec==0
local stateStr=""
if isChuZheng then

stateStr="已结束"
local marchGuid=data.data.marchguid
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
local teamHandle=marchData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
stateStr=FMT.fmt("<color=#549327>{0}</color>后到达",timeHelper.format_time_stamp3(lerpTime))
end
end
end
else

if nowTime>=data.data.sec then
stateStr="集结完成"
else
local lerp=data.data.sec-nowTime
stateStr=FMT.fmt("<color=#549327>{0}</color>后完成集结",timeHelper.format_time_stamp3(lerp))
end
end
widget:SetChildText(teamItemCmpIndex.stateStr,stateStr)


local isShowInfoBtn=zyType==zyTypeList.eSelf or zyType==zyTypeList.eXMAllies
widget:SetChildActive(teamItemCmpIndex.infoBtn,isShowInfoBtn)
if isShowInfoBtn then
widget:SetChildButtonClick(teamItemCmpIndex.infoBtn,function()
if not _this then return end
self:onInfoBtnClick(i)
end,true)
end


widget:SetChildButtonClick(teamItemCmpIndex.gotoBtn,function()
if not _this then return end
self:onGotoBtnClick(i)
end,true)
end
end

self.noTeamTips:setActive(teamCount<=0)
if teamCount>0 then

self:setUpdateTimer()
end

local isFilter=false
if self.filterFlag and next(self.filterFlag)and next(self.filterFlag[1])and next(self.filterFlag[2])then
for i,v in pairs(self.filterFlag[1])do
if v then
isFilter=true
break
end
end
if not isFilter then
for i,v in pairs(self.filterFlag[2])do
if v then
isFilter=true
break
end
end
end
end
local str=isFilter and"筛选中"or"暂未筛选"
self.filterStateText:setText(str)
end

function UIXianJieArenaAct_ovTeamWin:refresh_update()
local girds=self.teamScrollView:getChildScrollViewItemWidgets()
local nowTime=timeHelper.getServerShortTime()
for i=1,girds.Count do
local widget=girds[i-1]
local data=self.sortFilterTeamList[i]
if data then

local isChuZheng=data.data.sec==0
local stateStr=""
if isChuZheng then

stateStr="已结束"
local marchGuid=data.data.marchguid
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
local teamHandle=marchData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
stateStr=FMT.fmt("<color=#549327>{0}</color>后到达",timeHelper.format_time_stamp3(lerpTime))
end
end
end
else

if nowTime>=data.data.sec then
stateStr="集结完成"
else
local lerp=data.data.sec-nowTime
stateStr=FMT.fmt("<color=#549327>{0}</color>后完成集结",timeHelper.format_time_stamp3(lerp))
end
end
widget:SetChildText(teamItemCmpIndex.stateStr,stateStr)
end
end
end

function UIXianJieArenaAct_ovTeamWin:getSortTeamList()
local sortList={}

local allList=xianJieArenaActModel:getAllArenaMassDataList()or{}
for i,v in ipairs(allList)do
local weight1
local weight2
local isChuZheng=v.sec==0
if isChuZheng then

weight1=100

local actorId=v.actorid
local zmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(actorId)
end
local gridX_c_1=zmData.gridX_c
local gridZ_c_1=zmData.gridZ_c
local sceneidx_1=zmData.sceneidx

local arenaId=mathHelper.int64_to_number(v.guid)
local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
local sceneidx_2=arenaData.sceneidx
local gridX_c_2=arenaData.gridX_c
local gridZ_c_2=arenaData.gridZ_c
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieChuZheng,1)
local wayTime=xianjieModel:getPoint2PointNeedTime(sceneidx_1,gridX_c_1,gridZ_c_1,sceneidx_2,gridX_c_2,gridZ_c_2,speed)
weight2=wayTime
else

weight1=0
weight2=v.sec
end
sortList[#sortList+1]={
weight1=weight1,
weight2=weight2,
data=v,
}
end

table.sort(sortList,function(a,b)
if a.weight1==b.weight1 then
return a.weight2<b.weight2
else
return a.weight1>b.weight1
end
end)

return sortList
end

function UIXianJieArenaAct_ovTeamWin:getSortFilterTeamList()
local sortTeamList=self:getSortTeamList()
local filterName,filterFlag=self:getFilterData()
local list={}
local isAllFalseFlagList={}
for i,flagList in pairs(self.filterFlag)do
local isAllFalse=true
for i2,v in pairs(flagList)do
if v then
isAllFalse=false
break
end
end
isAllFalseFlagList[i]=isAllFalse
end
for i,v in ipairs(sortTeamList)do
local actorId=v.data.actorid
local arenaId=mathHelper.int64_to_number(v.data.guid)
local zyType=self:getZhenYingTypeByActorId(actorId)
local isInsert=true

if not isAllFalseFlagList[1]and self.filterFlag[1]and next(self.filterFlag[1])then
local idx=self.arenaIdLookup[arenaId]
if not self.filterFlag[1][idx]then
isInsert=false
end
end


if not isAllFalseFlagList[2]and self.filterFlag[2]and next(self.filterFlag[2])then
local idx
if zyType==zyTypeList.eSelf or zyType==zyTypeList.eXMAllies then
idx=1
elseif zyType==zyTypeList.eNotXMAllies then
idx=2
elseif zyType==zyTypeList.eEnemy then
idx=3
end
if not self.filterFlag[2][idx]then
isInsert=false
end
end

if isInsert then
list[#list+1]=v
end
end
return list
end

function UIXianJieArenaAct_ovTeamWin:getZhenYingTypeByActorId(actorId)
local zmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(actorId)
end
local enemyType=xianjieModel:checkEnemyType2(actorId,zmData.ownersceneidx)
local zyType
if enemyType==xjEnemyType.eSelf then
zyType=zyTypeList.eSelf
elseif enemyType==xjEnemyType.eAllies then
zyType=zyTypeList.eXMAllies
elseif enemyType==xjEnemyType.eEnemy then
zyType=zyTypeList.eEnemy
elseif enemyType==xjEnemyType.eStranger then

local isSelfXianYu=zmData.ownersceneidx==xianjieModel:getXianYuSceneIndex()
if isSelfXianYu then
zyType=zyTypeList.eNotXMAllies
else
zyType=zyTypeList.eEnemy
end
end
return zyType
end

function UIXianJieArenaAct_ovTeamWin:setUpdateTimer()
self:clearUpdateTimer()
if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
if not _this then
return
end
return self:refresh_update()
end)
end
end

function UIXianJieArenaAct_ovTeamWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIXianJieArenaAct_ovTeamWin:getFilterData(param)
if self.filterName==nil then
local arenaList={}
self.arenaIdLookup={}
for i,arenaId in ipairs(allArenaIndexList)do
local arenaCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local arenaName=arenaCfg and arenaCfg.name or"未知擂台"
table.insert(arenaList,{name=arenaName,id=arenaId})
self.arenaIdLookup[arenaId]=i
end
self.filterName={}
self.filterName[1]={"擂台",arenaList}
self.filterName[2]={"阵营",{
{name="同仙盟祖师",id=1},
{name="同仙域祖师",id=2},
{name="敌对祖师",id=3},
}}
end

local defaultSelectArenaLookup={}
if param and param.arenaIdList then
for i,arenaId in ipairs(param.arenaIdList)do
defaultSelectArenaLookup[arenaId]=true
end
end

if self.filterFlag==nil then
self.filterFlag={}
self.filterFlag[1]={}
for i,v in pairs(self.filterName[1][2])do
local arenaId=v.id
local isSelect=defaultSelectArenaLookup[arenaId]or false
self.filterFlag[1][i]=isSelect
end
self.filterFlag[2]={}
for i,v in pairs(self.filterName[2][2])do
self.filterFlag[2][i]=false
end
end

return self.filterName,self.filterFlag
end


function UIXianJieArenaAct_ovTeamWin.selectConditionBack(data)
if _this==nil then
return
end

_this.filterFlag=data.filterFlag
_this:refresh()
end


function UIXianJieArenaAct_ovTeamWin:onRefreshBtn()
local nowTime=timeHelper.getServerShortTime()
if self.refreshTime and nowTime-self.refreshTime<refreshCd then
UIManager.error("刷新过于频繁，请稍后再试")
return
end


xianJieArenaActController:reqGetXJArenaAllTeamList()
self.refreshTime=nowTime
end

function UIXianJieArenaAct_ovTeamWin:onInfoBtnClick(index)

local isOpenAct=xianJieArenaActModel:checkIsXJArenaActDoing()
if not isOpenAct then
UIManager.error("活动已结束")
return
end

local data=self.sortFilterTeamList[index]
if not data then
UIManager.error("集结已结束，请刷新列表")
return
end

local massActorId=data.data.actorid
local massGuid=data.data.massGuid
local msgData=xianjieModel:getJiJieTeamDetail(massActorId,massGuid)
local cbFunc=function()
if not _this then return end
_this:showWindow("UIXianJie_JiJie_teamInfoWin",{
isTeamInfo=true,
massActorId=massActorId,
massGuid=massGuid,
})
end

if msgData then
return cbFunc()
else
local args={}
args.callback=cbFunc
xianjieController:reqMassDetail(massActorId,massGuid,args)
end
end

function UIXianJieArenaAct_ovTeamWin:onGotoBtnClick(index)

local isOpenAct=xianJieArenaActModel:checkIsXJArenaActDoing()
if not isOpenAct then
UIManager.error("活动已结束")
return
end

local data=self.sortFilterTeamList[index]
if not data then
UIManager.error("集结已结束，请刷新列表")
return
end

local isChuZheng=data.data.sec==0
if isChuZheng then
local marchGuid=data.data.marchguid
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
local teamHandle=marchData:getTeamHandle()
local sceneidx,gridX,gridZ

local clickEntKey=teamHandle:getTeamEnityKey()
xianjieModel:enterSceneState_clickTeam_before(clickEntKey)
if not clickEntKey then

sceneidx,gridX,gridZ=teamHandle:getTargetPos()
end
if sceneidx then
xianjieController:jumpGrid(sceneidx,gridX,gridZ,nil,true)
end
else
UIManager.error("集结已结束，请刷新列表")
return
end
end
else
local arenaId=mathHelper.int64_to_number(data.data.guid)
local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaData then
UIManager.error("找不到目标擂台")
return
end
local sceneidx=arenaData.sceneidx
local gridX_c=arenaData.gridX_c
local gridZ_c=arenaData.gridZ_c
xianjieController:jumpGrid(sceneidx,gridX_c,gridZ_c,nil,nil)
end


UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end

function UIXianJieArenaAct_ovTeamWin:onFilterButton(index)
local filterName,filterFlag=self:getFilterData()
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')

args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selectConditionBack}
args.extraParams=extraParams
self:showWindow('UICommonPageTwoWin',args)
end