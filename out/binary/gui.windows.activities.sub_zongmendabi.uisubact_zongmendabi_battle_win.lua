







def_class("UISubAct_zongmendabi_battle_win",UIWindowBase)









function UISubAct_zongmendabi_battle_win:bindComponents()

self.root=UIObject.get(self,0)
self.ruleBtn=UIButton.get(self,1)
self.selfZMInfoPanel=UIObject.get(self,2)
self.battleTeamGrid=UIObject.get(self,3)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UISubAct_zongmendabi_battle_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.selfZMInfoPanel);self.selfZMInfoPanel=nil;
_UIObject_release(self.battleTeamGrid);self.battleTeamGrid=nil;
end
















local _this


function UISubAct_zongmendabi_battle_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_zongmendabi_battle_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_zongmendabi_battle_win:onHide()

end




function UISubAct_zongmendabi_battle_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:refreshSelfInfo()

local check=self.sub_actInfo:checkBattleList()
if not check then
self:refreshBattlesGrid()
else
self.battleTeamGrid:setActive(false)
end
end

function UISubAct_zongmendabi_battle_win:refreshSelfInfo()
local self_widget=self.selfZMInfoPanel:getWidgetBase()

local rank=self.myData.my_rank
local canInRank=activitiesHandle_zongmendabi.canInRank(self.subid,self.myData.score)
local rank_str
local showRank=false
if rank>0 and canInRank then
if rank>3 then
rank_str=FMT.fmt('第{0}名',rank)
else
rank_str=''
showRank=true
end
else
rank_str='未上榜'
end
self_widget:SetChildText(2,rank_str)

self_widget:SetChildActive(0,showRank)
if showRank then
local rankIcon=FMT.fmt('icon_phbmingci_{0}',rank)
self_widget:SetChildCSImageSprite(0,globalABLookup.rankList,rankIcon)
self_widget:SetChildText(1,rank)
end

playerController:setHeadIcon(self_widget,3,{iconInfo=nil,scale=0.7})

local name=UISettingModel:getZMName()
self_widget:SetChildText(5,name)

self:refreshBattleNum()

local fight=self.sub_actInfo:getDefTeamsFight()
self_widget:SetChildText(7,tostring(fight))

local score=self.myData.score
self_widget:SetChildCSImageIcon(8,moneyModel.getIconNameEx(eMoneyType.mtSectScore),true)
self_widget:SetChildScale(8,Vector3(0.5,0.5,1))
self_widget:SetChildText(9,tostring(score))
end

function UISubAct_zongmendabi_battle_win:refreshBattleNum()
local self_widget=self.selfZMInfoPanel:getWidgetBase()
local challengelist=self.sub_actcfg.challengelist
local battlenum=self.myData.use_times
local max_battlenum=challengelist[1]
local lerp=max_battlenum-battlenum
if lerp<0 then lerp=0 end
local battlenum_str=FMT.fmt('今日免费次数：<color=#7d3b17>{0}</color>',lerp)
self_widget:SetChildText(6,battlenum_str)
end

function UISubAct_zongmendabi_battle_win:findActorIndex(actorid)
for i,data in ipairs(self.matchList)do
if mathHelper.compareInt64(actorid,data.actorid)then
return i
end
end
return nil
end

function UISubAct_zongmendabi_battle_win:refreshBattlesGrid()
self.matchList=table.weakCopy(self.myData.matchList)or{}
local c=#self.matchList
if c>1 then
table.sort(self.matchList,function(a,b)
return a.pk_score>b.pk_score
end)
end
self.battleTeamGrid:setActive(true)
self.battleTeamGrid:setChildLayoutGroupCreateItems(c)
local grids=self.battleTeamGrid:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
self:refreshBattleItem(item,i)

item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onBattleItemHeadClick(i)
end)

item:SetChildButtonClick(7,function()
if _this==nil then return end
_this:onBattleItemBattleClick(i)
end)

item:SetChildButtonClick(13,function()
if _this==nil then return end
_this:onBattleItemLookClick(i)
end)

item:SetChildButtonClick(15,function()
if _this==nil then return end
_this:onBattleItemBattleClick(i)
end)
end
end

function UISubAct_zongmendabi_battle_win:refreshBattleItem(item,idx)
if item==nil then
item=self.battleTeamGrid:getChildLayoutGroupGridItem(idx-1)
end

local data=self.matchList[idx]

playerController:setHeadIcon(item,0,{iconInfo=data.iconInfo,scale=0.7})

item:SetChildText(2,data.sect_name)

item:SetChildText(4,tostring(data.fight_value))

item:SetChildCSImageIcon(5,moneyModel.getIconNameEx(eMoneyType.mtSectScore),true)
item:SetChildScale(5,Vector3(0.5,0.5,1))
item:SetChildText(6,tostring(data.pk_score))

self:refreshBattleItemState(item,idx)
end

function UISubAct_zongmendabi_battle_win:refreshBattleItemState(item,idx)
if item==nil then
item=self.battleTeamGrid:getChildLayoutGroupGridItem(idx-1)
end

local data=self.matchList[idx]
local result=data.fight_result
local hasResult=result>0
item:SetChildActive(7,not hasResult)
item:SetChildActive(12,hasResult)
item:SetChildActive(14,hasResult)
if hasResult then
local resultIcon
if result==1 then
resultIcon='image_zongmenduizhanui_3'
elseif result==2 then
resultIcon='image_zongmenduizhanui_5'
elseif result==3 then
resultIcon='image_zongmenduizhanui_4'
end
item:SetChildCSImageSprite(12,globalABLookup.zonmengdabi_battle,resultIcon)
else
local challengelist=self.sub_actcfg.challengelist
local battlenum=self.myData.use_times
local max_battlenum=challengelist[1]
local lerp=max_battlenum-battlenum
local hasfree=lerp>0
local btn_str=hasfree and'对战'or''
item:SetChildText(8,btn_str)
item:SetChildActive(9,not hasfree)
if not hasfree then
lerp=math.abs(lerp)
local costs=challengelist[2]
local cost=costs[lerp+1]
if cost==nil then
cost=costs[#costs]
end
local itemid=cost[1]
local itemnum=cost[2]
local hasnum=moneyModel.getMoney(itemid)
item:SetChildCSImageIcon(10,moneyModel.getIconNameEx(itemid),true)
local num_str
if hasnum>=itemnum then
num_str=tostring(itemnum)
else
num_str=toColorString(FONT_COLOR.eRedColor,itemnum)
end
item:SetChildText(11,num_str)
end
end

local log_len=data.log_len
item:SetChildActive(13,log_len>0)
end

function UISubAct_zongmendabi_battle_win:onBattleItemHeadClick(idx)
local data=self.matchList[idx]
if data.robotID==nil then
local callback=function(teamDzList)
if _this==nil then return end
activitiesHandle_zongmendabi.showOtherPlayerRivalInfo(_this.subid,teamDzList)
end
local args={serverid=data.server_id,actID=self.actID,subType=self.subType,subid=self.subid}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eZongMenDaBiDef2,data.actor_id,args,callback,true)
else
local str=cfgHelper.getlang('act_zongmendabi_tips_3')
UIManager.info(str)
end
end

function UISubAct_zongmendabi_battle_win:onBattleItemLookClick(idx)
local data=self.matchList[idx]
if data.log_len>0 then
local sendServerType=activitiesModel:getSendMessageSeverType(self.actID)
local isCrossServer=sendServerType~=sendMessageServerType.eNone
local args={eReplayType=eRePlayerType.zongmendabi}
args.player1={playerModel:getActorID(),UISettingModel:getZMName(),playerModel:getActorIconInfo()}
args.player2={data.actor_id,data.sect_name,data.iconInfo}
args.data={actID=self.actID,subType=self.subType,subid=self.subid,tab_idx=self.tab_idx}
fightController:send_log_list(data.logList,args,isCrossServer)
end
end

function UISubAct_zongmendabi_battle_win:onBattleItemBattleClick(idx)
local data=self.matchList[idx]
if data.log_len>0 then

return
end

local challengelist=self.sub_actcfg.challengelist
local battlenum=self.myData.use_times
local max_battlenum=challengelist[1]
local lerp=max_battlenum-battlenum
local hasfree=lerp>0
if not hasfree then
lerp=math.abs(lerp)
local costs=challengelist[2]
local cost=costs[lerp+1]
if cost==nil then
cost=costs[#costs]
end
local itemid=cost[1]
local itemnum=cost[2]
local callback=function()
if _this==nil then return end
_this:onBattleItemBattleClickEx(idx,itemid,itemnum)
end
moneySystem:useMoney(itemid,itemnum,callback,WARNING_TYPE.eWarning)
return
end
self:onBattleItemBattleClickEx(idx)
end

function UISubAct_zongmendabi_battle_win:onBattleItemBattleClickEx(idx,itemid,itemnum)
local callback=function()
if _this==nil then return end
_this:onBattle(idx)
end
local isfree=itemid==nil
if not isfree then

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZongMenDaBiBuyChallengeDialog)
if not flag then
local iconname=iconHelper.getIconName(itemid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local contentStr=FMT.fmt('是否消耗{0}<color=#7d3b17>{1}</color> 进行对战？',iconStr,itemnum)
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
if _this==nil then return end

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZongMenDaBiBuyChallengeDialog,flag)
end,
okcallback=function()
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
callback()
end
else
callback()
end
end

function UISubAct_zongmendabi_battle_win:onBattle(idx)
local data=self.matchList[idx]
local robotID=data.robotID

if robotID==nil then
local callback=function(defTeams)
if _this==nil then return end
_this:onBattle_player(idx,defTeams)
end
local args={serverid=data.server_id,actID=self.actID,subType=self.subType,subid=self.subid}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eZongMenDaBiDef1,data.actor_id,args,callback,true)
else
self:onBattle_robot(idx)
end
end

function UISubAct_zongmendabi_battle_win:onBattle_player(idx,defTeams)
local actID=self.actID
local subType=self.subType
local subid=self.subid
local tab_idx=self.tab_idx
local data=self.matchList[idx]
local idx_=data.idx
defTeams=defTeams or{}
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

local mySaveTeam=self.sub_actInfo:getMySaveTeam()
local multipleTeams={}
for teamIdx=1,2 do
local defTeam=mySaveTeam and mySaveTeam[teamIdx]or self.sub_actInfo:getDefTeamFive(teamIdx)
multipleTeams[teamIdx]={}
for posIdx,dis_guid in ipairs(defTeam)do
if mathHelper.validInt64(dis_guid)then
local dzData=UIDiscipleModel:getDiscipleData(dis_guid)
if dzData then
multipleTeams[teamIdx][tostring(dis_guid)]={posIdx,eTeamEntityType.dizi,dis_guid}
end
end
end
end

local temNum=2
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.zongmendabi,temNum)
local args={
actID=self.actID,
subType=self.subType,
subid=self.subid,
tab_idx=self.tab_idx,
selectIndex=idx,
myTeam=multipleTeams,
monTeam=multipleMonsterListEx,
monsterFightEx=monsterFightEx,
matchList=self.matchList
}
UIManager:showWindow('UISubAct_zongmendabi_adjust_win',args)
end

function UISubAct_zongmendabi_battle_win:onBattle_robot(idx)
local actID=self.actID
local subType=self.subType
local subid=self.subid
local tab_idx=self.tab_idx
local data=self.matchList[idx]
local idx_=data.idx
local robotID=data.robotID
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
if robotcfg==nil then



return
end
local monTeamId=robotcfg.monTeamId
local multipleMonsterListEx={}
local monsterFightEx={}
for teamIndex=1,2 do
multipleMonsterListEx[teamIndex]={}
local groupid=monTeamId[teamIndex]
local fight=data.fights[teamIndex]
local monList=cfgHelper.get2(cfg_monstergroup_get,groupid,'monList')
for i,monsterID in ipairs(monList)do
local d={typo=fightEntityType.monster,monsterID=monsterID}
table.insert(multipleMonsterListEx[teamIndex],d)
end
monsterFightEx[teamIndex]=fight
end

local mySaveTeam=self.sub_actInfo:getMySaveTeam()
local multipleTeams={}
for teamIdx=1,2 do
local defTeam=mySaveTeam and mySaveTeam[teamIdx]or self.sub_actInfo:getDefTeamFive(teamIdx)
multipleTeams[teamIdx]={}
for posIdx,dis_guid in ipairs(defTeam)do
if mathHelper.validInt64(dis_guid)then
local dzData=UIDiscipleModel:getDiscipleData(dis_guid)
if dzData then
multipleTeams[teamIdx][tostring(dis_guid)]={posIdx,eTeamEntityType.dizi,dis_guid}
end
end
end
end

local args={
actID=self.actID,
subType=self.subType,
subid=self.subid,
tab_idx=self.tab_idx,
selectIndex=idx,
myTeam=multipleTeams,
monTeam=multipleMonsterListEx,
monsterFightEx=monsterFightEx,
matchList=self.matchList
}

UIManager:showWindow('UISubAct_zongmendabi_adjust_win',args)
end

function UISubAct_zongmendabi_battle_win:onRuleBtn()
local d={}
d.title='宗门对战 '
d.mode=3
d.name='act_zongmendabi_battle_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_zongmendabi_battle_win:rec_matchList()
self:refreshSelfInfo()
self:refreshBattlesGrid()
end

function UISubAct_zongmendabi_battle_win:rec_newday()
self:refreshBattleNum()
self.sub_actInfo:checkBattleList()
end
