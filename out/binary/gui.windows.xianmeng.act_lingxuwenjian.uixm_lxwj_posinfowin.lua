







def_class("UIXM_LXWJ_posInfoWin",UIWindowBase)









function UIXM_LXWJ_posInfoWin:bindComponents()

self.attackBtn=UIButton.get(self,0)
self.attactTxt=UIText.get(self,1)
self.changeBtn=UIButton.get(self,2)
self.defFightTxt=UIText.get(self,3)
self.defRateTxt=UIText.get(self,4)
self.descTxt=UIText.get(self,5)
self.fightText=UIText.get(self,6)
self.frameSp=UIObject.get(self,7)
self.involvePanel=UIObject.get(self,8)
self.involveTxt=UIText.get(self,9)
self.noTeamTips=UIText.get(self,10)
self.playerHead=UIObject.get(self,11)
self.replayBtn=UIButton.get(self,12)
self.root=UIObject.get(self,13)
self.teamObj=UIObject.get(self,14)
self.teamOneGrid=UIObject.get(self,15)
self.teamTwoGrid=UIObject.get(self,16)
self.tipsObj=UIObject.get(self,17)
self.tipsTxt=UIText.get(self,18)
self.zmNameTxt=UIText.get(self,19)

self.attackBtn:setButtonClick(function()self:onAttackBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.replayBtn:setButtonClick(function()self:onReplayBtn()end)



end


function UIXM_LXWJ_posInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attackBtn);self.attackBtn=nil;
_UIObject_release(self.attactTxt);self.attactTxt=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.defFightTxt);self.defFightTxt=nil;
_UIObject_release(self.defRateTxt);self.defRateTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.involvePanel);self.involvePanel=nil;
_UIObject_release(self.involveTxt);self.involveTxt=nil;
_UIObject_release(self.noTeamTips);self.noTeamTips=nil;
_UIObject_release(self.playerHead);self.playerHead=nil;
_UIObject_release(self.replayBtn);self.replayBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.teamObj);self.teamObj=nil;
_UIObject_release(self.teamOneGrid);self.teamOneGrid=nil;
_UIObject_release(self.teamTwoGrid);self.teamTwoGrid=nil;
_UIObject_release(self.tipsObj);self.tipsObj=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.zmNameTxt);self.zmNameTxt=nil;
end
















local _this=nil


function UIXM_LXWJ_posInfoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_posInfoWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UIXM_LXWJ_posInfoWin')

end


function UIXM_LXWJ_posInfoWin:onHide()

end




function UIXM_LXWJ_posInfoWin:onShow(argtable,afterOnloaded)











self.posData=argtable.posData
self.teamDzList=argtable.teamDzList
self.teamwinrate=argtable.teamwinrate
self.zyData=argtable.zyData
local extraParams=argtable.extraParams

self:refreshView()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4747,1,{},0,false,false,0,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end


local checkJump=false
if extraParams then
local openReplay=extraParams.openReplay
if openReplay then
checkJump=true
local pos=self.posData
local posData_={pos[1],pos[2],pos[3]}
UIManager:showWindow('UIXM_LXWJ_replayWin',{posData=posData_,openReplay=openReplay})
end
end
if not checkJump then
lingxuwenjianController:doCloseCloud()
end
end

function UIXM_LXWJ_posInfoWin:refreshView()
local pos=self.posData
local zyData=self.zyData

local headParams={iconInfo=zyData.iconInfo,scale=0.8}
playerController:setHeadIcon(self.winid,self.playerHead:getID(),headParams)

self.zmNameTxt:setText(zyData.actorname)

local rate=self.teamwinrate/100
local defRate_str
if pos[2]==0 then
defRate_str=FMT.fmt('赛季问剑胜率：{0}%',rate)
else
defRate_str=FMT.fmt('赛季防守胜率：{0}%',rate)
end
self.defRateTxt:setText(defRate_str)

local fight=mathHelper.formatNumber6(zyData.fightvalue_num)
local fight_str
if pos[2]==0 then
fight_str='问剑阵容战力：'
else
fight_str='防守阵容战力：'
end
self.fightText:setText(fight_str)
self.defFightTxt:setText(fight)

local desc_str
if pos[2]==0 then
desc_str='问剑阵容'
else
desc_str='防守阵容'
end
self.descTxt:setText(desc_str)

local hasTeam=next(self.teamDzList)~=nil
self.teamObj:setActive(hasTeam)
self.noTeamTips:setActive(not hasTeam)
if hasTeam then

self:refreshDefTeam(1)

self:refreshDefTeam(2)
else
local no_str='该祖师已超七天音讯全无\n门下弟子群龙无首，丧失战意\n<color=#C82C2C>（问剑或被进攻时将被判定为战败）</color>'
self.noTeamTips:setText(no_str)
end

local isInvolve=lingxuwenjianModel:checkInDef()
self.involvePanel:setActive(not isInvolve)
if not isInvolve then
local tipsInvolve=cfgHelper.get2(cfg_lingxuwenjianconfig_get,1,'tipsZhenYanWin')
self.involveTxt:setText(tipsInvolve)
end

self:refreshPanelState()
end

function UIXM_LXWJ_posInfoWin:refreshDefTeam(teamIndex)
local def_team=self.teamDzList
local teamGrid=teamIndex==1 and self.teamOneGrid or self.teamTwoGrid
local list={}
for i=1,5 do
local idx=(teamIndex-1)*5+i
local netData=def_team[idx]
if netData~=nil then
table.insert(list,netData)
end
end
local num=4
teamGrid:setChildLayoutGroupCreateItems(num)
local grids=teamGrid:getChildLayoutGroupGridList()
for i=1,num do
local netData=list[i]
local item=grids[i-1]
local has=netData~=nil
item:SetChildActive(0,not has)
item:SetChildActive(1,has)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onHeadClick(teamIndex)
end)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(item,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,item,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end
end
end

function UIXM_LXWJ_posInfoWin:refreshPanelState()
local pos=self.posData
local zyData=self.zyData

local raceState=lingxuwenjianModel:getLunState()
local showAtk=false
local showChange=false
local isGray=false
local btn_str
local tips_str
if pos[2]==0 then

if lingxuwenjianModel:isLeader()then
local check=false
local fightState=lingxuwenjianModel:getFightState()
if raceState==eLXWJ_State.eStandby then
check=true
elseif fightState==eLXWJ_Fight_State.eFight then
if lingxuwenjianModel:hasEnemy()and lingxuwenjianModel:checkBattleResult()==nil then
check=true
end
end
if check then
showChange=true
end
end
else

if raceState==eLXWJ_State.eStandby then
if pos[1]==0 and lingxuwenjianModel:isLeader()then
showChange=true
end
elseif raceState==eLXWJ_State.eFight then
if pos[1]==1 then
local fightState=lingxuwenjianModel:getFightState()
if fightState==eLXWJ_Fight_State.eFight then
local result=lingxuwenjianModel:checkBattleResult()
if result==nil then
local blood=zyData.blood
local isLife=blood>0
if isLife then
local winSign=lingxuwenjianModel:getWinSign(pos[2],pos[3])
if not winSign then
showAtk=true
local max=lingxuwenjianModel:getMaxAttackTimes()
local cur=lingxuwenjianModel:getAttackTimes()or 0
local lerp=max-cur
if lerp<0 then lerp=0 end
isGray=lerp<=0
btn_str=FMT.fmt('攻击（{0}/{1})',lerp,max)
else
tips_str='已战胜该阵眼，无法重复挑战'
end
else
tips_str='该阵眼已沦陷'
end
end
end
end
end
end

self.attackBtn:setActive(showAtk)
if showAtk then
self.attactTxt:setText(btn_str)
self.attackBtn:setChildImageExGray(isGray)

local isInvolve=lingxuwenjianModel:checkInDef()
self.attackBtn:setChildAnchoredPosition(isInvolve and Vector2(0,-270)or Vector2(0,-305))
end

self.changeBtn:setActive(showChange)

local showTips=tips_str~=nil
self.tipsObj:setActive(showTips)
if showTips then
self.tipsTxt:setText(tips_str)
end

local showReplay=false
if pos[2]>0 then

if raceState==eLXWJ_State.eFight or raceState==eLXWJ_State.eFinish then


showReplay=true

end
end
self.replayBtn:setActive(showReplay)
end

function UIXM_LXWJ_posInfoWin:onHeadClick(teamIndex)
local teamDzList=self.teamDzList
if next(teamDzList)==nil then
UIManager.error('该玩家尚未设置防守阵容')
return
end
local pos=self.posData
local zyData=self.zyData
local callback=function(teamDzList_,other)
if _this==nil then return end
lingxuwenjianController:showOtherPlayerRivalInfo(teamDzList_)
end
local lxwjteamtype
if pos[2]==0 then
lxwjteamtype=2
else
lxwjteamtype=1
end
local server_id
if pos[1]==0 then
server_id=playerModel:getActorServerID()
else
local enemyData=lingxuwenjianModel:getEnemyData()
server_id=enemyData.enemyserverid
end
local send_args={serverid=server_id,lxwjteamtype=lxwjteamtype}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eLingXuWenJianDef2,zyData.actorid,send_args,callback,false,true)
end

function UIXM_LXWJ_posInfoWin:onChangeBtn()
local pos=self.posData
local raceState=lingxuwenjianModel:getLunState()
if pos[2]~=0 then

if raceState==eLXWJ_State.eStandby then
lingxuwenjianController:openMemberList(2,{fzid=pos[2],zyid=pos[3]})
else
UIManager.error('本阶段无法进行成员安排')
end
else

local fightState=lingxuwenjianModel:getFightState()
local check=false
if raceState==eLXWJ_State.eStandby then
check=true
elseif fightState==eLXWJ_Fight_State.eFight then
if lingxuwenjianModel:hasEnemy()and lingxuwenjianModel:checkBattleResult()==nil then
check=true
end
else
UIManager.error('本阶段无法进行成员安排')
end
if check then
lingxuwenjianController:openMemberList(4)
end
end
end

function UIXM_LXWJ_posInfoWin:onAttackBtn()
local zyData=self.zyData
if lingxuwenjianController:checkBattleCond(zyData.lxwjtype,zyData.lxwjkey,true)then
self:onBattle()
end
end

function UIXM_LXWJ_posInfoWin:onBattle()
local max=lingxuwenjianModel:getMaxAttackTimes()
local cur=lingxuwenjianModel:getAttackTimes()or 0
local lerp=max-cur
if lerp<=0 then
UIManager.error('攻击次数不足')
return
end

local zyData=self.zyData
local zfid=zyData.lxwjtype
local zyid=zyData.lxwjkey
local defTeams=self.teamDzList
local pos=self.posData
local openPos={pos[1],pos[2],pos[3]}
local multipleMonsterListEx={}
local monsterFightEx={}
for teamIndex=1,2 do
multipleMonsterListEx[teamIndex]={}
local fight=0
local pos=0
for posIndex=(teamIndex-1)*5+1,teamIndex*5 do
local arrangeDZ=defTeams[posIndex]
pos=pos+1
if arrangeDZ then
local d={pos=pos,typo=fightEntityType.diZi,guid=arrangeDZ.discipleguid,netData=arrangeDZ}
table.insert(multipleMonsterListEx[teamIndex],d)
fight=fight+arrangeDZ.fightValNum
end
end
monsterFightEx[teamIndex]=fight
end
local temNum=2
local dzCountLimit=4
local mapId=cfgHelper.get2(cfg_lingxuwenjianconfig_get,1,'mapid')
local singleFightDescStr=FMT.fmt('每个队伍最多可上阵{0}名弟子',dzCountLimit)
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.lingxuwenjian,temNum)
fightController.showPrepareWin(eFightPreSelectType.lingxuwenjian,{
enterTxt='仙盟战',
skipShouYuanCheck=true,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=true,
mapId=mapId,
dzCountLimit=dzCountLimit,
singleFightDescStr=singleFightDescStr,
editorTeam=false,
showZhenFa=false,
closeByCloud=true,
closeByCloudDelay=5,
monsterFightEx=monsterFightEx,
multipleMonsterListEx=multipleMonsterListEx,
multipleTeams=teamData,
enterCallBack=function(teamList,zfId)
if not lingxuwenjianController:checkBattleCond(zfid,zyid,true)then
return
end
fightLaunchController:sendFightEx(eBattleLaunch.lingxuwenjian,teamList,{zfid,zyid})
local args={}
args.player1={playerModel:getActorName(),playerModel:getActorIconInfo()}
args.player2={zyData.actorname,zyData.iconInfo}
fightModel:setSendExtraArgs(eBattleType.lingxuwenjian,args)
end,
cancelCallBack=function()
lingxuwenjianController:setMarkCloud(true)
local jumpParam={openPos=openPos}
limitActivitiesController:jump(LIMIT_ACT_TYPE.eLingXuWenJian,jumpParam)
end,
})
end

function UIXM_LXWJ_posInfoWin:onReplayBtn()
local pos=self.posData
local posData={pos[1],pos[2],pos[3]}
UIManager:showWindow('UIXM_LXWJ_replayWin',{posData=posData})
end

function UIXM_LXWJ_posInfoWin:rec_over()
UIManager:invokeUIMethod('UIXM_LXWJ_memberTwoWin','onClickClose')
UIManager:invokeUIMethod('UIXM_LXWJ_memberFourWin','onClickClose')
end