







def_class("UIXM_LXWJ_wjBattleWin",UIWindowBase)









function UIXM_LXWJ_wjBattleWin:bindComponents()

self.lunGridPanel=UIObject.get(self,0)



end


function UIXM_LXWJ_wjBattleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lunGridPanel);self.lunGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_wjBattleWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_wjBattleWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_wjBattleWin:onHide()

end




function UIXM_LXWJ_wjBattleWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
self.openReplay=argtable.openReplay
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
self:refreshTime()
end

function UIXM_LXWJ_wjBattleWin:refreshTime()
local fightState=lingxuwenjianModel:getFightState()
local fightState_old=self.fightState
self.fightState=fightState
if self.fightState~=fightState_old then
self:checkRefresh()
end
end

function UIXM_LXWJ_wjBattleWin:checkRefresh()
local hasBattle=self:checkHasBattle()
if hasBattle then
local needRefresh=lingxuwenjianModel:checkReplayList(0,0,-1)
if not needRefresh then
self:refreshView()
else
self.lunGridPanel:setActive(false)
end
else
self:refreshView()
end
end

function UIXM_LXWJ_wjBattleWin:checkHasBattle()
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFight then
if self.fightState>eLXWJ_Fight_State.eWJIdle then
return true
end
elseif raceState==eLXWJ_State.eFinish then
return true
end
return false
end

function UIXM_LXWJ_wjBattleWin:checkHasBattle2()
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFight then
if self.fightState>=eLXWJ_Fight_State.eWJIdle then
return true
end
elseif raceState==eLXWJ_State.eFinish then
return true
end
return false
end

function UIXM_LXWJ_wjBattleWin:refreshView()
self.lunGridPanel:setActive(true)
self.isInit=true

self.replayLookup={}
local replayList=lingxuwenjianModel:getReplayList(0,0,-1)or{}
for i=1,3 do
self.replayLookup[i]=replayList[i]
end

local func=function(i)
if _this==nil then return end
local item=_this.lunGridPanel:getChildLayoutGroupGridItem(i-1)
_this:refreshItem(item,i)
item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onReplayClick(i)
end)
end
self.lunGridPanel:setChildLayoutGroupCreateItems(3,func)


local checkJump=false
if self.openReplay~=nil then
local idx=self.openReplay
local data=self.replayLookup[idx]
if data then

end
self.openReplay=nil
end
if not checkJump then
lingxuwenjianController:doCloseCloud()
end
end

function UIXM_LXWJ_wjBattleWin:refreshItem(item,idx)
if item==nil then
item=_this.lunGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local data=self.replayLookup[idx]
local zyData_my=lingxuwenjianModel:getWJTData(0,idx)
local zyData_enemy=lingxuwenjianModel:getWJTData(1,idx)

local time_str=lingxuwenjianModel:getWJTFightTimeDesc(idx)
item:SetChildText(0,FMT.fmt('第{0}轮 ( 　{1})',idx,time_str))

local showReplay=false
if data~=nil and self:checkHasBattle()then
if not lingxuwenjianModel:checkInWJTFight(self.fightState,idx)then
showReplay=true
end
end
item:SetChildActive(2,showReplay)

local showBattleIcon=not showReplay
item:SetChildActive(1,showBattleIcon)

if self:checkHasBattle2()then
if data~=nil then
local myWidget
local enemyWidget
local inSide=lingxuwenjianModel:getInWJTSide(data.actorid)
if inSide==1 then
myWidget=item:GetChildWidgetBase(3)
enemyWidget=item:GetChildWidgetBase(4)
else
myWidget=item:GetChildWidgetBase(4)
enemyWidget=item:GetChildWidgetBase(3)
end
local showResult=not lingxuwenjianModel:checkInWJTFight(self.fightState,idx)


local hasMy=zyData_my~=nil
myWidget:SetChildActive(4,not hasMy)
myWidget:SetChildActive(5,hasMy)
if hasMy then

myWidget:SetChildActive(0,showResult)
if showResult then

local abname,icon=lingxuwenjianModel:getResultIcon4(data.result,true)
myWidget:SetChildCSImageSprite(0,abname,icon)
end

local headParams={iconInfo=zyData_my.iconInfo,scale=0.5}
playerController:setHeadIcon(myWidget,1,headParams)

local xmName1=xianmengModel:getXMName()
local name_str=FMT.fmt('{0}\n{1}',xmName1,zyData_my.actorname)
local showMy=false
if playerModel:checkActorId(zyData_my.actorid)then
showMy=true
end
myWidget:SetChildText(2,name_str)
myWidget:SetChildActive(3,showMy)
end

local hasEnemy=zyData_enemy~=nil
enemyWidget:SetChildActive(4,not hasEnemy)
enemyWidget:SetChildActive(5,hasEnemy)
if hasEnemy then

enemyWidget:SetChildActive(0,showResult)
if showResult then

local abname_,icon_=lingxuwenjianModel:getResultIcon4(data.result,false)
enemyWidget:SetChildCSImageSprite(0,abname_,icon_)
end

local headParams={iconInfo=zyData_enemy.iconInfo,scale=0.5}
playerController:setHeadIcon(enemyWidget,1,headParams)

local enemyData=lingxuwenjianModel:getEnemyData()
local xmName2=enemyData.enemyname
local name_str=FMT.fmt('{0}\n{1}',xmName2,zyData_enemy.actorname)
local showMy=false
enemyWidget:SetChildText(2,name_str)
enemyWidget:SetChildActive(3,showMy)
end
else
local myWidget=item:GetChildWidgetBase(3)
local enemyWidget=item:GetChildWidgetBase(4)

local hasMy=zyData_my~=nil
myWidget:SetChildActive(4,not hasMy)
myWidget:SetChildActive(5,hasMy)
if hasMy then

myWidget:SetChildActive(0,false)

local headParams={iconInfo=zyData_my.iconInfo,scale=0.5}
playerController:setHeadIcon(myWidget,1,headParams)

local xmName1=xianmengModel:getXMName()
local name_str=FMT.fmt('{0}\n{1}',xmName1,zyData_my.actorname)
local showMy=false
if playerModel:checkActorId(zyData_my.actorid)then
showMy=true
end
myWidget:SetChildText(2,name_str)
myWidget:SetChildActive(3,showMy)
end

local hasEnemy=zyData_enemy~=nil
enemyWidget:SetChildActive(4,not hasEnemy)
enemyWidget:SetChildActive(5,hasEnemy)
if hasEnemy then

enemyWidget:SetChildActive(0,false)

local headParams={iconInfo=zyData_enemy.iconInfo,scale=0.5}
playerController:setHeadIcon(enemyWidget,1,headParams)

local enemyData=lingxuwenjianModel:getEnemyData()
local xmName2=enemyData.enemyname
local name_str=FMT.fmt('{0}\n{1}',xmName2,zyData_enemy.actorname)
local showMy=false
enemyWidget:SetChildText(2,name_str)
enemyWidget:SetChildActive(3,showMy)
end
end
else
local myWidget=item:GetChildWidgetBase(3)
local enemyWidget=item:GetChildWidgetBase(4)

myWidget:SetChildActive(4,true)
myWidget:SetChildActive(5,false)

enemyWidget:SetChildActive(4,true)
enemyWidget:SetChildActive(5,false)
end
end

function UIXM_LXWJ_wjBattleWin:onReplayClick(idx)
local data=self.replayLookup[idx]
if data~=nil and data.len>0 then
local isCrossServer=true
local args={eReplayType=eRePlayerType.lingxuwenjian2}
local zyData=lingxuwenjianModel:getWJTData(0,idx)
local player1={zyData.actorid,zyData.actorname,zyData.iconInfo}
local zyData_=lingxuwenjianModel:getWJTData(1,idx)
local player2={zyData_.actorid,zyData_.actorname,zyData_.iconInfo}
local inSide=lingxuwenjianModel:getInWJTSide(data.actorid)
if inSide==1 then
args.player1=player1
args.player2=player2
else
args.player1=player2
args.player2=player1
end
args.data={src=0,lxwjtype=0,lxwjkey=-1,openReplay=idx}
args.showBattle=true

local args2={}
args2.player1={args.player1[2],args.player1[3]}
args2.player2={args.player2[2],args.player2[3]}
args2.hideFlag=true
args2.showWinTimes=true
fightModel:setSendExtraArgs(eBattleType.lingxuwenjian2,args2)
fightController:send_log_list(data.list,args,isCrossServer)
end
end

function UIXM_LXWJ_wjBattleWin:rec_replay(src,lxwjtype,lxwjkey)
self:refreshView()
end

function UIXM_LXWJ_wjBattleWin:rec_posResult(idx)
if self.isInit then
self:refreshItem(nil,idx)
end
end