







def_class("UIXianJie_JiJie_teamListWarWin",UIWindowBase)









function UIXianJie_JiJie_teamListWarWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.itemScrollView=UIObject.get(self,1)
self.noSign=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.itemPanel=UIObject.get(self,5)
self.infoPaixu=UIButton.get(self,6)
self.fightPaixu=UIButton.get(self,7)
self.ybdsetBtn=UIButton.get(self,8)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.infoPaixu:setButtonClick(function()self:onInfoPaixu()end)

self.fightPaixu:setButtonClick(function()self:onFightPaixu()end)

self.ybdsetBtn:setButtonClick(function()self:onYbdsetBtn()end)



end


function UIXianJie_JiJie_teamListWarWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.infoPaixu);self.infoPaixu=nil;
_UIObject_release(self.fightPaixu);self.fightPaixu=nil;
_UIObject_release(self.ybdsetBtn);self.ybdsetBtn=nil;
end















local _this
local _teamItemCmpIndex={
bg=0,
head=1,
nameTxt=2,
zmFightValueText=3,
signBgIcon=4,
signIcon=5,
signKuangIcon=6,
xmName=7,
xmIcon=8,
xmBtn=9,
fight=10,
state=11,
time=12,
joinBtn=13,
joinSign=14,
missSign=15,
resProgressImg=16,
resProgressTxt=17,
findClick=18,
progressBar=19,
timeRoot=20,
icon=21,
guiShuText=22,
arenaIcon=23,
targetInfoPanel=24,
notDataPanel=25,
notDataTips=26,
}




function UIXianJie_JiJie_teamListWarWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_JiJie_teamListWarWin:__delete()
_this=nil
self:unbindComponents()
self:clearUpdateTimer()
end




function UIXianJie_JiJie_teamListWarWin:onShow(argtable,afterOnloaded)

xianjieController:reqMassTeamList()
local isOpenYBDPage=argtable and argtable.isOpenYBDPage
self.page=argtable and argtable.page
self.parentWin=argtable and argtable.parentWin
if isOpenYBDPage then
self:onYbdsetBtn(isOpenYBDPage)
UIManager:invokeUIMethod("UIXianJie_JiJie_teamListBgWin","changeExtraArgs",nil)
end

self:refresh(true)
end

function UIXianJie_JiJie_teamListWarWin:onShowArgRecv(argtable,afterOnloaded)
self:refresh()
end


function UIXianJie_JiJie_teamListWarWin:onHide()
self:clearUpdateTimer()
end

function UIXianJie_JiJie_teamListWarWin:refresh(isInit)
self:clearUpdateTimer()
if isInit then
self.teamsList=xianjieModel:getJiJieSimpleDataListByJJType(xjJjJieBaseType.eWar)or{}
end

local num=#self.teamsList
local hasTeam=num>0
self.itemScrollView:setActive(hasTeam)
self.noSign:setActive(not hasTeam)
if hasTeam then

self:refreshTeamList()


self:setUpdateTimer()
end

local isOpenYbdSys=xianjieModel:checkJiJieYBDSysIsOpen()
self.ybdsetBtn:setActive(isOpenYbdSys)
end

function UIXianJie_JiJie_teamListWarWin:refreshTeamList()
local num=#self.teamsList
self.waitDataXmGuidList={}
self.itemPanel:setChildLayoutGroupCreateItems(num,function(idx)
if _this==nil then return end
local item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
local teamData=self.teamsList[idx]

























































local sceneType=xianjieModel:getScenceType()
local isMoJieMass=teamData.isMoJieMass or false
local isInMoJie=xianjienSceneType:isMoJie(sceneType)or false
local isSameScene=isMoJieMass==isInMoJie
if isSameScene then
item:SetChildActive(_teamItemCmpIndex.targetInfoPanel,true)
item:SetChildActive(_teamItemCmpIndex.notDataPanel,false)
local guid=teamData.guid
local entityType=xianjieModel:getEntityTypeByGuid(guid,teamData.sceneidx)
local isArena=false
if entityType==xjServerEnityType.eClientBuild then
isArena=xianjieModel:checkClientBdIsArenaByGuid(guid)
if isArena then

local arenaId=mathHelper.int64_to_number(guid)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
local targetName=cfg and cfg.name or"未知擂台"
item:SetChildText(_teamItemCmpIndex.nameTxt,targetName)


local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local sceneIdx=arenaData.sceneidx
local xyNameStr
local hasOccupy=sceneIdx and sceneIdx~=0 or nil
if hasOccupy then
xyNameStr=xianjieController:getCrossServerNamebySCidx(sceneIdx)
else
xyNameStr="无"
end
item:SetChildText(_teamItemCmpIndex.guiShuText,xyNameStr)
end
end
item:SetChildActive(_teamItemCmpIndex.arenaIcon,isArena)
else
item:SetChildActive(_teamItemCmpIndex.targetInfoPanel,false)
item:SetChildActive(_teamItemCmpIndex.notDataPanel,true)
local typeStr=isMoJieMass and"魔界目标 "or"仙界目标 "
local tipsStr=FMT.fmt("{0}无法查看信息",typeStr)
item:SetChildText(_teamItemCmpIndex.notDataTips,tipsStr)
end



local teamFight=teamData.fight and mathHelper.int64_to_number(teamData.fight)or 0
item:SetChildText(_teamItemCmpIndex.fight,mathHelper.formatNumber5(teamFight,2))

local nowTime=timeHelper.getServerShortTime()
local chuZhenTime=teamData.sec or 0
local stateStr=''
local timeStr="--:--:--"
local isStarted=false
local isShowTime=false
if chuZhenTime==0 then
stateStr="<color=#549327>出击中</color>"
isStarted=true
elseif nowTime>=chuZhenTime then
stateStr="<color=#ca631d>准备出击</color>"
else
stateStr="<color=#ca631d>集结中</color>"
timeStr=timeHelper.format_time_stamp(chuZhenTime-nowTime)
isShowTime=true
end
item:SetChildText(_teamItemCmpIndex.state,stateStr)
item:SetChildText(_teamItemCmpIndex.time,timeStr)
item:SetChildActive(_teamItemCmpIndex.timeRoot,isShowTime)
item:SetChildActive(_teamItemCmpIndex.progressBar,not isStarted)
if not isStarted then
local percent=teamData.now/teamData.max*100
item:SetChildProgressValue(_teamItemCmpIndex.progressBar,percent,100)
item:SetChildProgressText(_teamItemCmpIndex.progressBar,FMT.fmt("{0}/{1}",teamData.now,teamData.max))
end


local isJoined=teamData.on==1
item:SetChildActive(_teamItemCmpIndex.joinBtn,not isJoined and not isStarted)
item:SetChildActive(_teamItemCmpIndex.joinSign,isJoined)
item:SetChildActive(_teamItemCmpIndex.missSign,not isJoined and isStarted)
item:SetChildButtonClick(_teamItemCmpIndex.joinBtn,function()
if _this==nil then return end
_this:onItemJoinClick(idx)
end,true)


item:SetChildButtonClick(_teamItemCmpIndex.findClick,function()
if _this==nil then return end

_this:onInfoBtnClick(idx)
end,true)
end)
end

function UIXianJie_JiJie_teamListWarWin:refreshTeamList_update()
local grids=self.itemPanel:getChildLayoutGroupGridList()
for idx=1,grids.Count do
local item=grids[idx-1]
local teamData=self.teamsList[idx]


local nowTime=timeHelper.getServerShortTime()
local chuZhenTime=teamData.sec or 0
local stateStr=''
local timeStr="--:--:--"
local isStarted=false
local isShowTime=false
if chuZhenTime==0 then
stateStr="<color=#549327>出击中</color>"
isStarted=true
elseif nowTime>=chuZhenTime then
stateStr="<color=#ca631d>准备出击</color>"
else
stateStr="<color=#ca631d>集结中</color>"
timeStr=timeHelper.format_time_stamp(chuZhenTime-nowTime)
isShowTime=true
end
item:SetChildText(_teamItemCmpIndex.state,stateStr)
item:SetChildText(_teamItemCmpIndex.time,timeStr)
item:SetChildActive(_teamItemCmpIndex.timeRoot,isShowTime)


local isJoined=teamData.on==1
if not isJoined then
item:SetChildActive(_teamItemCmpIndex.joinBtn,not isJoined and not isStarted)
item:SetChildActive(_teamItemCmpIndex.missSign,not isJoined and isStarted)
end
end
end

function UIXianJie_JiJie_teamListWarWin:setUpdateTimer()
self:clearUpdateTimer()
if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
if not _this then
return
end
self:refreshTeamList_update()
end)
end
end

function UIXianJie_JiJie_teamListWarWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIXianJie_JiJie_teamListWarWin:rec_detail(guildid)
local guidStr=tostring(guildid)
if self.waitDataXmGuidList[guidStr]then
self:refresh()
end
end




function UIXianJie_JiJie_teamListWarWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_JiJie_teamListWarWin:onCloseBtn()

UIManager:invokeUIMethod(self.parentWin,"onClickClose")
end



function UIXianJie_JiJie_teamListWarWin:onGotoBtn()

UIManager:invokeUIMethod("UIXianJieMainWin","onTanChaBtn")

self:onCloseBtn()
end



function UIXianJie_JiJie_teamListWarWin:onInfoPaixu()
end



function UIXianJie_JiJie_teamListWarWin:onFightPaixu()
end



function UIXianJie_JiJie_teamListWarWin:onYbdsetBtn(page)
if not xianjieModel:checkJiJieYBDSysIsOpen()then
local str=systemModel.getOpenTips(SYSTEM_DEFINE.eXianJieYuBeiDui)
return UIManager.error(str)
end


local parentPage=self.page

page=page or self.page
UIManager:showWindow('UIXianJie_JiJie_YBDSetBgWin',{page=page,extraArgs={parentPage=parentPage}})
end

function UIXianJie_JiJie_teamListWarWin:onItemJoinClick(idx)
local teamData=self.teamsList[idx]
local targetGuid=teamData.guid
local massguid=teamData.massguid
local actorId=teamData.actorid
local sceneidx=teamData.sceneidx

local teamDirtyFlag=xianjieModel:getJiJieDirtyData(actorId,massguid,targetGuid,sceneidx)
if not teamDirtyFlag then

UIManager.error("集结不存在")
return xianjieController:reqMassTeamList()
end

local zmData=xianjieModel:getZongMenData(actorId)
local zmSceneIdx=zmData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(zmSceneIdx)then

return UIManager.error("无法加入其他仙域的集结")
end


















UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=massguid,sceneidx=sceneidx})
end

function UIXianJie_JiJie_teamListWarWin:onInfoBtnClick(idx)
local teamData=self.teamsList[idx]
local infoguid=teamData.guid
local massguid=teamData.massguid
local actorId=teamData.actorid
local sceneidx=teamData.sceneidx
UIManager:showWindow("UIXianJie_JiJie_msgWin",{actorId=actorId,guid=massguid,sceneidx=sceneidx})















end