







def_class("UIXFWDAdjustWin",UIWindowBase)









function UIXFWDAdjustWin:bindComponents()

self.excBtnA=UIButton.get(self,0)
self.excBtnB=UIButton.get(self,1)
self.excBtnC=UIButton.get(self,2)
self.playerA=UIObject.get(self,3)
self.playerB=UIObject.get(self,4)
self.teamScrollViewA=UIObject.get(self,5)
self.teamScrollViewB=UIObject.get(self,6)
self.adjustBtn=UIButton.get(self,7)
self.fightBtn=UIButton.get(self,8)
self.skipFight=UIToggleButton.get(self,9)
self.skipMask=UIButton.get(self,10)

self.excBtnA:setButtonClick(function()self:onExcBtnA()end)

self.excBtnB:setButtonClick(function()self:onExcBtnB()end)

self.excBtnC:setButtonClick(function()self:onExcBtnC()end)

self.adjustBtn:setButtonClick(function()self:onAdjustBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.skipMask:setButtonClick(function()self:onSkipMask()end)



end


function UIXFWDAdjustWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.excBtnA);self.excBtnA=nil;
_UIObject_release(self.excBtnB);self.excBtnB=nil;
_UIObject_release(self.excBtnC);self.excBtnC=nil;
_UIObject_release(self.playerA);self.playerA=nil;
_UIObject_release(self.playerB);self.playerB=nil;
_UIObject_release(self.teamScrollViewA);self.teamScrollViewA=nil;
_UIObject_release(self.teamScrollViewB);self.teamScrollViewB=nil;
_UIObject_release(self.adjustBtn);self.adjustBtn=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.skipFight);self.skipFight=nil;
_UIObject_release(self.skipMask);self.skipMask=nil;
end


















local funcCfg={
[XFWD_DATA_TYPE.eMatching]={
getDatas=function()
return UIXianFaWenDaoControl:getMatchingData()
end,
getTargetTeamFValue=function(index)
return UIXianFaWenDaoControl:getMatchingTargetTeamFValue(index)
end,
handleFightIndex=function(index)
return-index
end,
closeFunc=function(isSkip)
UIXianFaWenDaoControl:showXianFaWenDaoChallengeWin()
end
},
[XFWD_DATA_TYPE.eRecord]={
getDatas=function()
return UIXianFaWenDaoControl:getRecordData()
end,
getTargetTeamFValue=function(index)
return UIXianFaWenDaoControl:getRecordTargetTeamFValue(index)
end,
handleFightIndex=function(index)
return index
end,
closeFunc=function(isSkip)
UIXianFaWenDaoControl:showXianFaWenDaoWin()
if not isSkip then
UIXianFaWenDaoControl:reqRecordList()
end

end
}
}

function UIXFWDAdjustWin:onLoaded(...)
self:bindComponents()

self.btns={
self.excBtnA,
self.excBtnB,
self.excBtnC
}

self.teamScrollViewA:setChildScrollViewInit(0.5,true,nil,nil)
self.teamScrollViewB:setChildScrollViewInit(0.5,true,nil,nil)

self.skipNeedFC=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'skip_cnd')

self.isSkip=UIXianFaWenDaoControl:isSkipFight()
self.skipFight:setToggle(self.isSkip)
self.skipFight:setToggleChange(function(name,isOn)
self.isSkip=isOn
UIXianFaWenDaoControl:setSkipFightState(isOn)
end)
end


function UIXFWDAdjustWin:__delete()
self:unbindComponents()
end

function UIXFWDAdjustWin:isCanSkipFight()
local count=gameUtilityModel:getData_counter(gameCounterType.eXFWDFightNum)
return count>=self.skipNeedFC
end




function UIXFWDAdjustWin:onShow(argtable,afterOnloaded)
self:refresh(argtable)
end

function UIXFWDAdjustWin:onShowArgRecv(argtable)
self:refresh(argtable)
end

function UIXFWDAdjustWin:refresh(argtable)
self.isWaiting=false

self.skipMask:setActive(not self:isCanSkipFight())

self.excBtnSelectId=nil
self:setExBtns(0)
self.indexList={0,1,2}
self.dataType=argtable.dataType or XFWD_DATA_TYPE.eMatching
self.targetIndex=argtable.selectIndex
self.myTeam=self:getMyTeamData(argtable.myTeam)
self.monTeam=argtable.monTeam
self:refreshMyTeam()
self:refreshMonsterTeam()
self:setPlayerAInfo()
self:setPlayerBInfo()
end

function UIXFWDAdjustWin:setPlayerAInfo()
local widget=self.playerA:getChildWidgetBase()
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=nil})
local name=FMT.fmt('【{0}】\n{1}',loginModel:getMyServerName(),playerModel:getActorName())
widget:SetChildText(1,name)
end

function UIXFWDAdjustWin:setPlayerBInfo()
self.monInfo={}
local widget=self.playerB:getChildWidgetBase()
local datas=funcCfg[self.dataType].getDatas()
local data=datas[self.targetIndex]
self.fightIndex=funcCfg[self.dataType].handleFightIndex(data.index)
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(data.actorid)
if robbotType==1 then
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
local actoricon=robotcfg.headImage[1]
actoricon=bit.bor(actoricon,bit.lshift(robotcfg.headImage[2],16))
local iconInfo={actoricon=actoricon}
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=iconInfo})
local name=UIXianFaWenDaoControl:getRobbitName(data.actorid,robotID)
self.monInfo.rcName=name
local server=loginModel:getMyServerName()
local sname=FMT.fmt('【{0}】\n{1}',server,name)
widget:SetChildText(1,sname)
self.monInfo.name=name
self.monInfo.server=server
self.monInfo.iconInfo=iconInfo
else
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=data.iconInfo})
local name
local server
if data.actorname==''then
name=UIXianFaWenDaoControl:getRobbitName(data.actorid,1,true)
self.monInfo.rcName=name
server=loginModel:getMyServerName()
else
name=data.actorname
server=loginModel:getServerName(data.serverid)
end
local sname=FMT.fmt('【{0}】\n{1}',server,name)
widget:SetChildText(1,sname)
self.monInfo.name=name
self.monInfo.server=server
self.monInfo.iconInfo=data.iconInfo
end
end

function UIXFWDAdjustWin:refreshMonsterTeam()
self.teamScrollViewB:setChildScrollViewCreateGrids(3,0)
local datas=funcCfg[self.dataType].getDatas()
local data=datas[self.targetIndex]
local fvalArr
if data.isRobbit then
fvalArr=funcCfg[self.dataType].getTargetTeamFValue(self.targetIndex)
end
local grids=self.teamScrollViewB:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,FMT.fmt('第{0}场',i))
local team=self.monTeam[i]
local fvCount=data.isRobbit and fvalArr[i]or 0
for ii=1,5 do
local id=ii+1
local td=team[ii]
if td then
item:SetChildActive(id,true)
local widget=item:GetChildWidgetBase(id)
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
widget:SetChildActive(4,false)
if td.typo==fightEntityType.monster then
comHelper.setChildModelRawImage_monster(widget,td.monsterID,2,0,eHeadCenterType.eHead)
local cfg=cfgHelper.get1(cfg_monsterconfig_get,td.monsterID)
local jobIcon=UIDiscipleModel:getJobIconName(cfg.job or 1)
widget:SetChildCSImageSprite(3,globalABLookup.global,jobIcon)
widget:SetChildActive(7,false)
comHelper.setChildModelHeadIconBGByColor(widget,5,cfg.color or 1)

UIDiscipleModel:setDiscipleXianMoHeadImage(widget,6,nil)
else
local image=UIDiscipleModel.calculationDiscipleImageBase(td.netData)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,widget,modelParams)
local jobIcon=UIDiscipleModel:getJobIconName(image.job)
widget:SetChildCSImageSprite(3,globalABLookup.global,jobIcon)

local dzId=td.netData.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
widget:SetChildActive(7,isSpDz)
comHelper.setChildModelHeadIconBGByColor(widget,5,image.color)

UIDiscipleModel:setDiscipleXianMoHeadImage(widget,6,td.netData)
fvCount=fvCount+td.netData.fightValNum
end
else
item:SetChildActive(id,false)
end
end
fvCount=UIDiscipleModel:fightValueConversion(fvCount)
item:SetChildText(1,fvCount)
item:SetChildActive(7,false)
end
end

function UIXFWDAdjustWin:refreshMyTeam()
self.teamScrollViewA:setChildScrollViewCreateGrids(3,0)
local grids=self.teamScrollViewA:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,FMT.fmt('第{0}场',i))
local team=self.myTeam[i]
local fval=0
for ii=1,5 do
local id=ii+1
local td=team[ii]
if td then
item:SetChildActive(id,true)
local widget=item:GetChildWidgetBase(id)
local dzId=td[3]
widget:SetChildActive(1,true)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
widget:SetChildActive(2,true)
widget:SetChildActive(4,false)
comHelper.setChildModelRawImage(widget,dzId,2,0,eHeadCenterType.eHead)
local jobicon=UIDiscipleModel:getJobIconNameX(dzId)
widget:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(dzId)
widget:SetChildActive(7,isSpDz)
local info=UIDiscipleModel:getDiscipleImageInfo(dzId)
comHelper.setChildModelHeadIconBGByColor(widget,5,info.color)

UIDiscipleModel:setDiscipleXianMoHeadImage(widget,6,dzData)
else
widget:SetChildActive(2,false)
widget:SetChildActive(4,true)
comHelper.setChildModelHeadIconBGByColor(widget,5,1)

UIDiscipleModel:setDiscipleXianMoHeadImage(widget,6,nil)
end
fval=fval+UIDiscipleModel:getDiscipleFightValue(dzId)
else
item:SetChildActive(id,false)
end
end
fval=UIDiscipleModel:fightValueConversion(fval)
item:SetChildText(1,fval)
item:SetChildActive(7,false)
end
end

function UIXFWDAdjustWin:getMyTeamData(teams)
if teams then
local list={}
for i,v in ipairs(teams)do
local nt={}
for k,vv in pairs(v)do
nt[vv[1]]=vv
end
list[i]=nt
end
return list
end
local teamData={{},{},{}}
local team=UIXianFaWenDaoControl:getFightTeam()
if team then
for i,v in ipairs(team)do
if v~='0'then
local dzId=int64.new(v)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[pId]={pId,1,dzId}
end
end
end
return teamData
end
team=UIXianFaWenDaoControl:getTeam()
for i,v in ipairs(team)do
local dzId=tostring(v)
if dzId~='0'then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[pId]={pId,1,v}
end
end
return teamData
end

function UIXFWDAdjustWin:openFightingWin(index,myTeam,monTeam)
local tempTeam=table.deepCopy(myTeam)
local faZeData=UIXianFaWenDaoControl:getFazeList()
local dataType=self.dataType
fightController.showPrepareWin(fightPreSelectModel.fightType.xianfawendao,{
enterTxt='仙法问道',
mapId=818004,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
skipShouYuanCheck=true,
isHomeBattle=true,
multipleMonsterListEx=monTeam,
multipleTeams=tempTeam,
showZhenFa=false,
faZeData=faZeData,
statePriorityCheck=false,
enterCallBack=function(teamList,zfId)

end,
cancelCallBack=function()
UIXianFaWenDaoControl:showXianFaWenDaoAdjustWin({selectIndex=index,myTeam=myTeam,monTeam=monTeam,dataType=dataType})
end,
executeCallback=function(guidList)
local teams={}
local sendData={}
for i,v in ipairs(guidList)do
local td={}
for ii,vv in ipairs(v)do
if vv[1]==1 then
local id=tostring(vv[2])
td[id]={ii,1,vv[2]}
table.insert(sendData,id)
else
table.insert(sendData,'0')
end
end
teams[i]=td
end
UIXianFaWenDaoControl:saveFightTeam(sendData)
UIXianFaWenDaoControl:showXianFaWenDaoAdjustWin({selectIndex=index,myTeam=teams,monTeam=monTeam,dataType=dataType})
end
})
end

function UIXFWDAdjustWin:setExBtns(selId)
for i,v in ipairs(self.btns)do
local widget=v:getChildWidgetBase()
if selId==0 then
widget:SetChildActive(-1,true)
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
else
widget:SetChildActive(-1,i~=selId)
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
end
end
end

function UIXFWDAdjustWin:handleExcBtn(selId)
if not self.excBtnSelectId then
self:setExBtns(selId)
self.excBtnSelectId=selId
for i=1,3 do
local index=self.indexList[i]
local widget=self.teamScrollViewA:getChildScrollViewItemWidget(index)
widget:SetChildActive(7,i~=selId)
end
else



local td=self.myTeam[self.excBtnSelectId]
self.myTeam[self.excBtnSelectId]=self.myTeam[selId]
self.myTeam[selId]=td

local id=self.indexList[self.excBtnSelectId]
self.indexList[self.excBtnSelectId]=self.indexList[selId]
self.indexList[selId]=id





for i=1,3 do
local index=self.indexList[i]
local widget=self.teamScrollViewA:getChildScrollViewItemWidget(index)
widget:SetChildText(0,FMT.fmt('第{0}场',i))
widget:SetChildActive(7,false)
end
local sId=self.indexList[self.excBtnSelectId]
local dId=self.indexList[selId]
local widgetA=self.teamScrollViewA:getChildScrollViewItemWidget(sId)
local widgetB=self.teamScrollViewA:getChildScrollViewItemWidget(dId)
local posA=widgetA:GetChildAnchoredPosition(-1)
local posB=widgetB:GetChildAnchoredPosition(-1)
widgetA:SetChildDOAnchorPosY(-1,posB.y,0.5,nil)
widgetB:SetChildDOAnchorPosY(-1,posA.y,0.5,nil)
self.excBtnSelectId=nil
self:setExBtns(0)
end
end

function UIXFWDAdjustWin:onExcBtnA()
self:handleExcBtn(1)
end

function UIXFWDAdjustWin:onExcBtnB()
self:handleExcBtn(2)
end

function UIXFWDAdjustWin:onExcBtnC()
self:handleExcBtn(3)
end


function UIXFWDAdjustWin:onHide()

end




function UIXFWDAdjustWin:onAdjustBtn()
local team={}
for i,v in ipairs(self.myTeam)do
local nt={}
for k,vv in pairs(v)do
nt[tostring(vv[3])]=vv
end
team[i]=nt
end
self:openFightingWin(self.targetIndex,team,self.monTeam)
end

function UIXFWDAdjustWin:onFightBtn()
if self.isWaiting then
return
end

if UIXianFaWenDaoControl:isMoneyNumFull()then
local tips=FMT.fmt('今日{0}已达获取上限，是否跳转？',moneyModel.getMoneyName(eMoneyType.mtZhanYuDian))
UIDialogManager.getConfirmDialog3(nil,tips,function()
self:handleFight()
end,REPEAT_TYPE.eXFWDZhanYUDain)
else
self:handleFight()
end
end

function UIXFWDAdjustWin:handleFight()
local teamList={}
for i,v in ipairs(self.myTeam)do
local dt={}
for ii=1,5 do
local d=v[ii]
if d then
dt[ii]={1,d[3]}
else
dt[ii]={0,int64.new('0')}
end
end
teamList[i]={#dt,dt,{818004,0}}
end
local tt,ft,pt=UIXianFaWenDaoControl:getAllChallengeTimes()
fightLaunchController:sendFightEx(eBattleLaunch.xianfawendao,teamList,{self.fightIndex,ft>0 and 0 or 1})







local datas=funcCfg[self.dataType].getDatas()
local data=datas[self.targetIndex]
if self.monInfo.rcName then
UIXianFaWenDaoControl:setRecordName(data.actorid,self.monInfo.rcName)
UIXianFaWenDaoControl:saveRecordData()
end

local args={}
local name=FMT.fmt('[{0}]{1}',loginModel:getMyServerName(),playerModel:getActorName())
args.player1={name,playerModel:getActorIconInfo()}
name=FMT.fmt('[{0}]{1}',self.monInfo.server,self.monInfo.name)
args.player2={name,self.monInfo.iconInfo}
if self.isSkip then
args.isSkip=true
end
fightModel:setSendExtraArgs(eBattleType.xianfawendao,args)

self.isWaiting=true

if self.isSkip then
self:onCloseClick()
end
end

function UIXFWDAdjustWin:onSkipMask()
local count=gameUtilityModel:getData_counter(gameCounterType.eXFWDFightNum)
UIManager.info(FMT.fmt('再进行{0}场战斗可使用',self.skipNeedFC-count))
end

function UIXFWDAdjustWin:onCloseClick()
funcCfg[self.dataType].closeFunc(self.isSkip)


end