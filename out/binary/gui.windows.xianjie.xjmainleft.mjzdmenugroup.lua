







def_class("mjzdmenuGroup",UICloneObject)





mjzdmenuGroup.abName="ui/windows/xianjie/xjmainleft/mjzdmenugroup.ab"

mjzdmenuGroup.assetName="mjzdmenuGroup"


function mjzdmenuGroup:bindComponents()

self.listBg=UIObject.get(self,0)
self.noTeamTips=UIObject.get(self,1)
self.returnBtn=UIButton.get(self,2)
self.returnLayout=UIObject.get(self,3)
self.tabLayout=UIObject.get(self,4)
self.xjBtn=UIButton.get(self,5)
self.zcxqBtn=UIButton.get(self,6)
self.zdBtn=UIButton.get(self,7)
self.zdPanel=UIObject.get(self,8)
self.zdTeamScrollView=UIObject.get(self,9)

self.returnBtn:setButtonClick(function()self:onReturnBtn()end)

self.xjBtn:setButtonClick(function()self:onXjBtn()end)

self.zcxqBtn:setButtonClick(function()self:onZcxqBtn()end)

self.zdBtn:setButtonClick(function()self:onZdBtn()end)

end


function mjzdmenuGroup:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.listBg);self.listBg=nil;
_UIObject_release(self.noTeamTips);self.noTeamTips=nil;
_UIObject_release(self.returnBtn);self.returnBtn=nil;
_UIObject_release(self.returnLayout);self.returnLayout=nil;
_UIObject_release(self.tabLayout);self.tabLayout=nil;
_UIObject_release(self.xjBtn);self.xjBtn=nil;
_UIObject_release(self.zcxqBtn);self.zcxqBtn=nil;
_UIObject_release(self.zdBtn);self.zdBtn=nil;
_UIObject_release(self.zdPanel);self.zdPanel=nil;
_UIObject_release(self.zdTeamScrollView);self.zdTeamScrollView=nil;
end








local _zdItemCmpIndex={
targetText=0,
initiatorText=1,
stateText=2,
bg=3,
}
local _this=nil

function mjzdmenuGroup:onLoaded(...)
self:bindComponents()
self.xjBtnWidget=self.xjBtn:getChildWidgetBase()
self.zdBtnWidget=self.zdBtn:getChildWidgetBase()

self:addNotify(notifyConfig.onXianJieWaiPaiChange,self.onXianJieWaiPaiChange)
self:addNotify(notifyConfig.onXianJieMapDataInit,self.onXianJieMapDataInit)
end


function mjzdmenuGroup:__delete()
_this=nil

self:unbindComponents()
self:clearStateTimer()
end




function mjzdmenuGroup:onShow(argtable,afterOnloaded)
_this=self
self.parent=argtable.parent

self.selectMenuPageIndex=1

self:refreshBtn(true)

self:refreshZdPanel(true)

self:refreshXianJieMainWinSimpleStateChange()
end

function mjzdmenuGroup:refreshBtn(isInit)
if not _this then return end
self.xjBtnWidget:SetChildActive(1,self.selectMenuPageIndex==2)
self.zdBtnWidget:SetChildActive(1,self.selectMenuPageIndex==1)

self.zdPanel:setActive(self.selectMenuPageIndex==1)
self.parent.xjPanel:setActive(self.selectMenuPageIndex==2)
if self.selectMenuPageIndex==1 then
self:refreshZdPanel()
elseif self.selectMenuPageIndex==2 then
self.parent:refreshTeamPanel()
end
end


function mjzdmenuGroup:onHide()
self:clearStateTimer()
end

function mjzdmenuGroup:onXjBtn()
self.selectMenuPageIndex=2
self:refreshBtn()
end

function mjzdmenuGroup:onZdBtn()
self.selectMenuPageIndex=1
self:refreshBtn()


end

function mjzdmenuGroup:getSelectMenuPageIndex()
return self.selectMenuPageIndex
end

function mjzdmenuGroup.onXianJieWaiPaiChange(changeType,param)
if _this==nil then return end
local isInit=false
if changeType==CHANGE_TYPE.eInit then
isInit=true
end
if _this.selectMenuPageIndex==1 then
_this:refreshZdPanel(isInit)
end
end

function mjzdmenuGroup.onXianJieMapDataInit()
if _this==nil then return end
if _this.selectMenuPageIndex==1 and _this.refreshLeftMenuPanel then
_this:refreshLeftMenuPanel(true)
end
end


function mjzdmenuGroup:refreshZdPanel(isInit)
if not _this then return end
if isInit then
xianjieController:reqMassTeamList()
end
self:clearStateTimer()

local teamsList=self:getXMArenaTeamList()
local count=#teamsList
self.zdTeamScrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.zdTeamScrollView:getChildScrollViewItemWidgets()
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local data=teamsList[i]
if data then
local arenaId=mathHelper.int64_to_number(data.guid)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)

local arenaNameStr=cfg and cfg.name or"未知擂台"
widget:SetChildText(_zdItemCmpIndex.targetText,FMT.fmt("目标：{0}",arenaNameStr))


local actorId=data.actorid
local zmData=xianjieModel:getZongMenData(actorId)
local nameStr="未知祖师"
if zmData then
nameStr=zmData.actorname
end
widget:SetChildText(_zdItemCmpIndex.initiatorText,FMT.fmt("队长：{0}",nameStr))


local chuZhenTime=data.sec or 0
local marchGuid=data.marchguid
local stateStr=''
local timeStr=""
if chuZhenTime==0 then
stateStr="出击中"
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
local teamHandle=marchData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
stateStr="出击中："
if state==xjMarchTeamStateType.eBattle then
stateStr="战斗中："
local isSelfXianYu=false
local arenaData=moGongZhengDuoActModel:getArenaBuildData(arenaId)or{}
if arenaData then
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then
local cross_sid=loginModel:getCrossServerId()
isSelfXianYu=occupyServerId==cross_sid
end
end
if isSelfXianYu then
stateStr="进驻中："
end
end
timeStr=timeHelper.format_time_stamp(lerpTime)
end
end
end
elseif nowTime>=chuZhenTime then
stateStr="准备出击"
else
stateStr="集结中："
timeStr=timeHelper.format_time_stamp(chuZhenTime-nowTime)
end
widget:SetChildText(_zdItemCmpIndex.stateText,FMT.fmt("{0}{1}",stateStr,timeStr))

local teamSceneIdx=data.sceneidx

widget:SetChildButtonClick(_zdItemCmpIndex.bg,function()
if not _this then return end
return self:onClickZdItem(actorId,data.massguid,marchGuid,teamSceneIdx)
end,true)
end
end
self.noTeamTips:setActive(count<=0)
if count>0 then
self:setStateTimer()
end
end

function mjzdmenuGroup:setStateTimer()
self:clearStateTimer()
local func=function()
if not _this then return end
self:refreshZhengDuoPanel_update()
end

self.stateUpdateTimer=self:setTimer(0.25,0,func)
end

function mjzdmenuGroup:clearStateTimer()
if self.stateUpdateTimer then
self:stopTimerByID(self.stateUpdateTimer)
self.stateUpdateTimer=nil
end
end

function mjzdmenuGroup:refreshZhengDuoPanel_update()
local teamsList=self:getXMArenaTeamList()
local grids=self.zdTeamScrollView:getChildScrollViewItemWidgets()
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local widget=grids[i-1]
local data=teamsList[i]
if data then

local chuZhenTime=data.sec or 0
local arenaId=mathHelper.int64_to_number(data.guid)
local stateStr=''
local timeStr=""
if chuZhenTime==0 then
stateStr="出击中"
local marchGuid=data.marchguid
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
local teamHandle=marchData:getTeamHandle()
local state,timeData,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local lerpTime=math.ceil(lerp)
stateStr="出击中："
if state==xjMarchTeamStateType.eBattle then
stateStr="战斗中："
local isSelfXianYu=false
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
if arenaData then
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then
local cross_sid=loginModel:getCrossServerId()
isSelfXianYu=occupyServerId==cross_sid
end
end
if isSelfXianYu then
stateStr="进驻中："
end
end
timeStr=timeHelper.format_time_stamp(lerpTime)
end
end
end
elseif nowTime>=chuZhenTime then
stateStr="准备出击"
else
stateStr="集结中："
timeStr=timeHelper.format_time_stamp3(chuZhenTime-nowTime)
end
widget:SetChildText(_zdItemCmpIndex.stateText,FMT.fmt("{0}{1}",stateStr,timeStr))
end
end
end

function mjzdmenuGroup:getXMArenaTeamList()
if self.xmArenaTeamList then
return self.xmArenaTeamList
end

self.xmArenaTeamList=moGongZhengDuoActModel:getSelfXMArenaJiJieDataList()
return self.xmArenaTeamList
end

function mjzdmenuGroup:onClickZdItem(actorId,guid,marchGuid,sceneidx)
local openFunc=function()
if not self.parent then return end
return self.parent:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=guid,sceneidx=sceneidx})
end

local teamHandle
if marchGuid and marchGuid~=0 then
local marchData=xianjieModel:getMarchTeamData(marchGuid)
if marchData then
teamHandle=marchData:getTeamHandle()
end
else
local teamData=xianjieModel:getSelfJiJieTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
end

local sceneidx,gridX,gridZ
if teamHandle then

local clickEntKey=teamHandle:getTeamEnityKey()
xianjieModel:enterSceneState_clickTeam_before(clickEntKey,openFunc)
if not clickEntKey then

sceneidx,gridX,gridZ=teamHandle:getTargetPos()
end
end

if sceneidx then
xianjieController:jumpGrid(sceneidx,gridX,gridZ,openFunc,true)
else

return openFunc()
end
end

function mjzdmenuGroup:onMassDetailDataChangeRecv(actorId,guid,flag)
if not _this then return end

self.parent:refreshJiJieBtn()


xianjieController:reqMassTeamList()
end

function mjzdmenuGroup:onMassTeamListInitRecv()
if not _this then return end

self.parent:refreshJiJieBtn()

self.xmArenaTeamList=nil
if self.selectMenuPageIndex==1 then
self:refreshZdPanel()
end
end

function mjzdmenuGroup:quickHide()
if self.stateUpdateTimer then
self:stopTimerByID(self.stateUpdateTimer)
self.stateUpdateTimer=nil
end
end

function mjzdmenuGroup:onReturnBtn()
local saijiid=xianjieController:getMoJieSaiJiID()
if saijiid==nil then
mainControl:enterHome()
else
local mojieCfg=cfgHelper.get1(cfg_devildomseasonconfig_get,saijiid)
local sceneIdx=mojieCfg.sceneidx
local sceneType=xianjieModel:sceneIndex2SceneType(sceneIdx)
xianjieController:jumpXianJie(sceneType)
end
end

local simpleKey="xianjieMainWin.meueGropEx.mjzdmenuGroup"
function mjzdmenuGroup:refreshXianJieMainWinSimpleStateChange()
local simpleState=xianjieMainWinSimpleModeConfig:getRecordState(simpleKey)

self.tabLayout:setActive(not simpleState)
self.listBg:setActive(not simpleState)
self.returnLayout:setActive(true)
end

function mjzdmenuGroup:onZcxqBtn()
xianjieController:openMGZDFightInfoWin({showIndex=1,pageList={1,2}})
end



