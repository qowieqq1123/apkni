







def_class("UIXWSAdjustWin",UIWindowBase)









function UIXWSAdjustWin:bindComponents()

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


function UIXWSAdjustWin:unbindComponents()
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




















function UIXWSAdjustWin:onLoaded(...)
self:bindComponents()

self.btns={
self.excBtnA,
self.excBtnB,
self.excBtnC
}

self.teamScrollViewA:setChildScrollViewInit(0.5,true,nil,nil)
self.teamScrollViewB:setChildScrollViewInit(0.5,true,nil,nil)

self.isSkip=XiWeiSaiController:isSkipFight()
self.skipFight:setToggle(self.isSkip)
self.skipFight:setToggleChange(function(name,isOn)
self.isSkip=isOn
XiWeiSaiController:setSkipFightState(isOn)
end)

end


function UIXWSAdjustWin:__delete()
self:unbindComponents()
end




function UIXWSAdjustWin:onShow(argtable,afterOnloaded)
if argtable and argtable.showAdjustWin then
loadingControl.closeCloud()
end
self:refresh(argtable)
end

function UIXWSAdjustWin:onShowArgRecv(argtable)
self:refresh(argtable)
end


function UIXWSAdjustWin:onHide()

end

function UIXWSAdjustWin:refresh(argtable)
self.isWaiting=false

self.skipMask:setActive(false)

self.excBtnSelectId=nil
self:setExBtns(0)
self.indexList={0,1,2}
self.targetPos=argtable.selectPos
self.targetGroup=argtable.selectGroup
self.myTeam=self:getMyTeamData(argtable.myTeam)
self.monTeam=argtable.monTeam
self:refreshMyTeam()
self:refreshMonsterTeam()
self:setPlayerAInfo()
self:setPlayerBInfo()
end

function UIXWSAdjustWin:setExBtns(selId)
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

function UIXWSAdjustWin:getMyTeamData(teams)

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

local teamData=XiWeiSaiController.getFightTeamDataEx()
if not teamData then
teamData=XiWeiSaiController.getDefendTeamDataEx()
end
return teamData
end

function UIXWSAdjustWin:refreshMyTeam()
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
end
fval=fval+UIDiscipleModel:getDiscipleFightValue(dzId)
else
item:SetChildActive(id,false)
end
end
item:SetChildText(1,fval)
item:SetChildActive(7,false)
end
end

function UIXWSAdjustWin:refreshMonsterTeam()
self.teamScrollViewB:setChildScrollViewCreateGrids(3,0)
local posInfo=XiWeiSaiController.getPosInfo(self.targetGroup,self.targetPos)
if not posInfo then
logErr("refreshMonsterTeam 没有对手数据")
return
end
local fvalArr

if posInfo.isRobot then
local oneFight=math.ceil(posInfo.fight/3)
fvalArr={oneFight,oneFight,oneFight}
end
local grids=self.teamScrollViewB:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,FMT.fmt('第{0}场',i))
local team=self.monTeam[i]
local fvCount=posInfo.isRobot and fvalArr[i]or 0
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
local fightValNum=mathHelper.int64_to_number(td.netData.fightvalue)
fvCount=fvCount+fightValNum

UIDiscipleModel:setDiscipleXianMoHeadImage(widget,6,td.netData)
end
else
item:SetChildActive(id,false)
end
end
item:SetChildText(1,fvCount)
item:SetChildActive(7,false)
end
end

function UIXWSAdjustWin:setPlayerAInfo()
local widget=self.playerA:getChildWidgetBase()
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=nil})
local name=FMT.fmt('【{0}】\n{1}',loginModel:getMyServerName(),playerModel:getActorName())
widget:SetChildText(1,name)
end

function UIXWSAdjustWin:setPlayerBInfo()
self.monInfo={}
local widget=self.playerB:getChildWidgetBase()
local posInfo=XiWeiSaiController.getPosInfo(self.targetGroup,self.targetPos)



local iconInfo=posInfo.iconInfo
local name=playerModel:getOtherActorName(posInfo.name)
local server=posInfo.serverNmae
local sname=FMT.fmt('【{0}】\n{1}',server,name)
widget:SetChildText(1,sname)
local isLose=mathHelper.validInt64(posInfo.actorId)and posInfo.name==''
if isLose then
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=iconInfo})
end
widget:SetChildActive(0,not isLose)
widget:SetChildActive(2,isLose)
self.monInfo.name=name
self.monInfo.server=server
self.monInfo.iconInfo=iconInfo

if posInfo.isRobot then
widget:SetChildActive(0,true)
widget:SetChildActive(2,false)
local name=posInfo.name
local server=loginModel:getMyServerName()
local sname=FMT.fmt('【{0}】\n{1}',server,name)
widget:SetChildText(1,sname)
self.monInfo.name=name
self.monInfo.server=server

else
local name=posInfo.name
local server=posInfo.serverNmae
local sname=FMT.fmt('【{0}】\n{1}',server,name)
widget:SetChildText(1,sname)
self.monInfo.name=name
self.monInfo.server=server
end

self.monInfo.iconInfo=iconInfo
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=iconInfo})
end

function UIXWSAdjustWin:handleExcBtn(selId)
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

function UIXWSAdjustWin:openFightingWin(group,pos,myTeam,monTeam)
local tempTeam=table.deepCopy(myTeam)
local faZeData=nil
fightController.showPrepareWin(eFightPreSelectType.wdcqxiweisaifightteam,{
enterTxt='问鼎苍穹',
mapId=818009,
dontCloseStage=true,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
skipShouYuanCheck=true,
isHomeBattle=true,
multipleMonsterListEx=monTeam,
multipleTeams=tempTeam,
showZhenFa=false,
faZeData=faZeData,
statePriorityCheck=false,

cancelCallBack=function()
loadingControl.openCloud(function()
UIFullWenDingCangQiongControl:showHaiXuanWin({showAdjustWin=true,selectPos=pos,selectGroup=group,monTeam=monTeam,myTeam=myTeam,})
fightController:closeSelectStage()
end)
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
XiWeiSaiController:saveFightTeam(sendData)
loadingControl.openCloud(function()
UIFullWenDingCangQiongControl:showHaiXuanWin({showAdjustWin=true,selectPos=pos,selectGroup=group,monTeam=monTeam,myTeam=teams,})
fightController:closeSelectStage()
end)
end
})
end

function UIXWSAdjustWin:handleFight()
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
teamList[i]={#dt,dt,{818009,0}}
end
local clientFight48={self.targetGroup,self.targetPos}

local args={}
local name=FMT.fmt('[{0}]{1}',loginModel:getMyServerName(),playerModel:getActorName())
args.player1={name,playerModel:getActorIconInfo()}
name=FMT.fmt('[{0}]{1}',self.monInfo.server,self.monInfo.name)
args.player2={name,self.monInfo.iconInfo}
if self.isSkip then
args.isSkip=true
args.loading=false
else
args.loading=true
end
args.oldPos=XiWeiSaiController.getPlayerRank()
fightModel:setSendExtraArgs(eBattleType.wdcqxiweisai,args)


fightLaunchController:sendFightEx(eBattleLaunch.wdcqxiweisai,teamList,clientFight48)


self.isWaiting=true

if self.isSkip then
self:onCloseClick()
end
end





function UIXWSAdjustWin:onExcBtnA()
self:handleExcBtn(1)
end



function UIXWSAdjustWin:onExcBtnB()
self:handleExcBtn(2)
end



function UIXWSAdjustWin:onExcBtnC()
self:handleExcBtn(3)
end



function UIXWSAdjustWin:onAdjustBtn()
local team={}
for i,v in ipairs(self.myTeam)do
local nt={}
for k,vv in pairs(v)do
nt[tostring(vv[3])]=vv
end
team[i]=nt
end
self:openFightingWin(self.targetGroup,self.targetPos,team,self.monTeam)
end



function UIXWSAdjustWin:onFightBtn()
if self.isWaiting then
return
end
self:handleFight()
end



function UIXWSAdjustWin:onSkipMask()
end

function UIXWSAdjustWin:onCloseClick()
self:closeSelf()
end
