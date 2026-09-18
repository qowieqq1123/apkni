







def_class("UIXFWDChallengeWin",UIWindowBase)









function UIXFWDChallengeWin:bindComponents()

self.score=UIText.get(self,0)
self.fightValue=UIText.get(self,1)
self.refreshBtn=UIButton.get(self,2)
self.enterPos=UIObject.get(self,3)
self.leavePos=UIObject.get(self,4)
self.competitor_1=UIObject.get(self,5)
self.competitor_2=UIObject.get(self,6)
self.competitor_3=UIObject.get(self,7)
self.scoreIcon=UIImage.get(self,8)
self.refreshText=UIText.get(self,9)
self.count=UIText.get(self,10)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)
self.competitor={
self.competitor_1,
self.competitor_2,
self.competitor_3,
}



end


function UIXFWDChallengeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.score);self.score=nil;
_UIObject_release(self.fightValue);self.fightValue=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.enterPos);self.enterPos=nil;
_UIObject_release(self.leavePos);self.leavePos=nil;
_UIObject_release(self.competitor_1);self.competitor_1=nil;
_UIObject_release(self.competitor_2);self.competitor_2=nil;
_UIObject_release(self.competitor_3);self.competitor_3=nil;
_UIObject_release(self.scoreIcon);self.scoreIcon=nil;
_UIObject_release(self.refreshText);self.refreshText=nil;
_UIObject_release(self.count);self.count=nil;
self.competitor=nil;
end
















local _itemIndex=
{
headIcon=0,
name=1,
scoreIcon=2,
scoreValue=3,
model=4,
fightValue=5,
challengeBtn=6,
payRoot=7,
payIcon=8,
payValue=9,
infoRoot=10,
modelPos=11,
server=12,
infoBG=13,
challengeTxt=14,
}




function UIXFWDChallengeWin:onLoaded(...)
self:bindComponents()

self.tweenerDict={}
end


function UIXFWDChallengeWin:__delete()
self:unbindComponents()
end

function UIXFWDChallengeWin:clearTweener()
for i,v in ipairs(self.tweenerDict)do
v:Kill()
end
self.tweenerDict={}
self.isPlaying=false
end




function UIXFWDChallengeWin:onShow(argtable,afterOnloaded)

self.Exscore=argtable and argtable[1]or nil
self:refresh(true)
end

function UIXFWDChallengeWin:onShowArgRecv(argtable)
self.Exscore=argtable and argtable[1]or nil
self:refresh()
end

function UIXFWDChallengeWin:refresh(playAnim)
local fvalue=UIXianFaWenDaoControl:getTeamTotalFightValue()
self.fightValue:setText(mathHelper.formatNumber3(fvalue))
local score=self.Exscore or UIXianFaWenDaoControl:getScore()
self.Exscore=nil
self.score:setText(score)

self:startCountDown()

local icon=UIXianFaWenDaoControl:getScoreIconName()
self.scoreIcon:setChildIcon(icon,true)

local isTruce=UIXianFaWenDaoControl:isInTruceTime()
local tt,ft,pt=UIXianFaWenDaoControl:getAllChallengeTimes()
self.hasTimes=pt>0
self.hasFree=ft>0
if isTruce then
self.count:setText(FMT.fmt('今日切磋：{0}次',ft))
elseif self.hasFree then
self.count:setText(FMT.fmt('今日免费挑战：{0}次',ft))
else
self.count:setText(FMT.fmt('今日剩余挑战：{0}次',pt))
end

local datas=UIXianFaWenDaoControl:getMatchingData()
for i,v in ipairs(self.competitor)do
local widget=v:getChildWidgetBase()
local data=datas[i]
if data then
v:setActive(true)
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(data.actorid)
if robbotType==1 then
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
if robotcfg then
local actoricon=robotcfg.headImage[1]
actoricon=bit.bor(actoricon,bit.lshift(robotcfg.headImage[2],16))
playerController:setHeadIcon(widget,_itemIndex.headIcon,{scale=0.75,iconInfo={actoricon=actoricon}})
local name=UIXianFaWenDaoControl:getRobbitName(data.actorid,robotID)

widget:SetChildText(_itemIndex.server,FMT.fmt('[{0}]',loginModel:getMyServerName()))
widget:SetChildText(_itemIndex.name,name)
widget:SetChildIcon(_itemIndex.scoreIcon,icon,true)
widget:SetChildText(_itemIndex.scoreValue,data.score)
local fv=UIXianFaWenDaoControl:getMatchingTargetFightValue(i,fvalue)
widget:SetChildText(_itemIndex.fightValue,mathHelper.formatNumber3(fv))

local gId=robotcfg.monTeamId[1]
local gcfg=cfgHelper.get1(cfg_monstergroup_get,gId)
local mId=gcfg.monList[1]
local mcfg=cfgHelper.get1(cfg_monsterconfig_get,mId)
local anim=mountHelper.getMountAniByBody(mcfg.modelid[1])
widget:SetChildUIModelShowTarget(_itemIndex.model,mcfg.modelid[1],0.7,mcfg.modelid[2],anim)
local mount=UIXianFaWenDaoControl:getMatchingTargetMount(i)
local scale=isometricMapSystem:getModelScale(mount,true)
widget:SetChildUIModelMount(_itemIndex.model,mount,nil,'zuoqidian',scale*0.5,Vector3.New(0,0,0),nil)
else
logErr(FMT.fmt('缺少机器人配置{0}',robotID))
end



else
playerController:setHeadIcon(widget,_itemIndex.headIcon,{scale=0.75,iconInfo=data.iconInfo})
local name
local server
if data.actorname==''then
name=UIXianFaWenDaoControl:getRobbitName(data.actorid,1,true)
server=loginModel:getMyServerName()




else
name=data.actorname
server=loginModel:getServerName(data.serverid)




end
widget:SetChildText(_itemIndex.server,FMT.fmt('[{0}]',server))
widget:SetChildText(_itemIndex.name,name)
widget:SetChildIcon(_itemIndex.scoreIcon,icon,true)
widget:SetChildText(_itemIndex.scoreValue,data.score)
local fv=tonumber(tostring(data.fightvalue))
widget:SetChildText(_itemIndex.fightValue,mathHelper.formatNumber3(fv))

local imageInfo=UIDiscipleModel.calculationDiscipleImageBase(data)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
local anim=mountHelper.getMountAniByBody(modelParams.body)
widget:SetChildUIModelShowTarget(_itemIndex.model,modelParams.body,0.7,modelParams.componets,anim)
local mount=UIXianFaWenDaoControl:getMatchingTargetMount(i)
local scale=isometricMapSystem:getModelScale(mount,true)
widget:SetChildUIModelMount(_itemIndex.model,mount,nil,'zuoqidian',scale*0.5,Vector3.New(0,0,0),nil)
end
local useMoney=not(self.hasFree or not self.hasTimes)
local md
if useMoney then
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local index=tt-cfg.free+1
md=cfg.consume[index][1]
end

widget:SetChildButtonClick(_itemIndex.challengeBtn,function()
if isTruce and not self.hasFree then
UIManager.error('切磋次数不足')
elseif self.hasTimes then
if useMoney then







local func=function()
self:reqAndOpenFightingWin(i)
end
moneySystem:useMoney(md[1],md[2],func,WARNING_TYPE.eWarning)
else
self:reqAndOpenFightingWin(i)
end
else
UIManager.error('挑战次数不足')
end
end)
if not useMoney or isTruce then
widget:SetChildActive(_itemIndex.payRoot,false)
else
widget:SetChildActive(_itemIndex.payRoot,true)
local iconName=moneyModel.getIconNameEx(md[1])
widget:SetChildIcon(_itemIndex.payIcon,iconName,true)
widget:SetChildText(_itemIndex.payValue,md[2])
end

if isTruce then
widget:SetChildText(_itemIndex.challengeTxt,"切磋")
else
widget:SetChildText(_itemIndex.challengeTxt,"挑战")
end
else
v:setActive(false)
end
end

if playAnim then
self:clearTweener()
self.isPlaying=true
self:playAndWaitEnter(function()
self.isPlaying=false
end)
else

for i,v in ipairs(self.competitor)do
local widget=v:getChildWidgetBase()
local tpos=widget:GetChildPosition(_itemIndex.modelPos)
widget:SetChildPosition(_itemIndex.model,tpos)
widget:SetChildCanvasGroupAlpha(_itemIndex.infoRoot,1)
widget:SetChildIconColor(_itemIndex.infoBG,Color.New(1,1,1,1))
end
end
end

function UIXFWDChallengeWin:playEnterAnim(widget,callback)
widget:SetChildIconColor(_itemIndex.infoBG,Color.New(1,1,1,0))
widget:SetChildCanvasGroupAlpha(_itemIndex.infoRoot,0)

local tpos=widget:GetChildPosition(_itemIndex.modelPos)
local spos=self.enterPos:getChildPosition()
spos.y=math.random()*10-5
widget:SetChildPosition(_itemIndex.model,spos)
local tran=widget:GetCommonComponent(_itemIndex.model,'Transform')
local tweener=_DOTweenProxy.DoPath(tran,{tpos,Vector3.New(spos.x-5,spos.y,spos.z),Vector3.New(tpos.x+5,tpos.y,tpos.z)},1,_pathType.CubicBezier)
tweener:OnComplete(function()
local tweener2=widget:SetChildCanvasGroupDOFade(_itemIndex.infoRoot,1,0.25)
table.insert(self.tweenerDict,tweener2)
local tweener3=widget:SetChildImageDOColor(_itemIndex.infoBG,Color.New(1,1,1,1),0.25)
table.insert(self.tweenerDict,tweener3)
if callback then
tweener2:OnComplete(function()
callback()
end)
end
end)
table.insert(self.tweenerDict,tweener)
end

function UIXFWDChallengeWin:playAndWaitEnter(callback)
for i,v in ipairs(self.competitor)do
local widget=v:getChildWidgetBase()
self:playEnterAnim(widget,i==3 and callback or nil)
end
end

function UIXFWDChallengeWin:playLeaveAnim(widget,callback)
local tweener=widget:SetChildCanvasGroupDOFade(_itemIndex.infoRoot,0,0.25)
tweener:OnComplete(function()
local tpos=self.leavePos:getChildPosition()
tpos.y=math.random()*10-5
local spos=widget:GetChildPosition(_itemIndex.modelPos)
local tran=widget:GetCommonComponent(_itemIndex.model,'Transform')
local tweener2=_DOTweenProxy.DoPath(tran,{tpos,Vector3.New(spos.x-5,spos.y,spos.z),Vector3.New(tpos.x+5,tpos.y,tpos.z)},1,_pathType.CubicBezier)
tweener2:SetEase(_Ease.InQuad)
table.insert(self.tweenerDict,tweener2)
if callback then
tweener2:OnComplete(function()
callback()
end)
end
end)
table.insert(self.tweenerDict,tweener)
local tweener3=widget:SetChildImageDOColor(_itemIndex.infoBG,Color.New(1,1,1,0),0.25)
table.insert(self.tweenerDict,tweener3)
end

function UIXFWDChallengeWin:playAndWaitLeave(callback)
for i,v in ipairs(self.competitor)do
local widget=v:getChildWidgetBase()
self:playLeaveAnim(widget,i==3 and callback or nil)
end
end

function UIXFWDChallengeWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIXFWDChallengeWin:startCountDown()
self:clearTimer()
local ltime=UIXianFaWenDaoControl:getMatchTime()
local cd=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'match_cd')
local etime=ltime+cd
if etime-gameUtilityModel.getServerShortTime()<=0 then
self:clearTimer()
self.refreshText:setText('刷新')
self.refreshBtn:setChildGraphicGray(false)
return
end
self.refreshBtn:setChildGraphicGray(true)
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
if dt>0 then
self.refreshText:setText(FMT.fmt('刷新({0})',dt))
else
self:clearTimer()
self.refreshText:setText('刷新')
self.refreshBtn:setChildGraphicGray(false)
end
end
self.timer=self:setTimer(1,0,tick)
tick()
end


function UIXFWDChallengeWin:onHide()
self:clearTweener()
end

function UIXFWDChallengeWin:getTeamData()
local team=UIXianFaWenDaoControl:getTeam()
local teamData={{},{},{}}
for i,v in ipairs(team)do
local dzId=tostring(v)
if dzId~='0'then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[dzId]={pId,1,v}
end
end
return teamData
end

function UIXFWDChallengeWin:getMultipleMonsterList(monList)
local list={}
for i,v in ipairs(monList)do
local mcfg=cfgHelper.get1(cfg_monstergroup_get,v)

local tlist={}
list[i]=tlist
for ii,monsterID in ipairs(mcfg.monList)do
local d={typo=fightEntityType.monster,monsterID=monsterID}
table.insert(tlist,d)
end
end
return list
end

function UIXFWDChallengeWin:reqAndOpenFightingWin(index)
local datas=UIXianFaWenDaoControl:getMatchingData()
local data=datas[index]
local robotID,robbotType=UIXianFaWenDaoControl:getRobbotInfo(data.actorid)
local callback=function(rec_data)
local teamData={{},{},{}}
for i,v in pairs(rec_data)do
if v.flag==1 then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[#tdata+1]={pos=pId,typo=fightEntityType.diZi,guid=v.discipleguid,netData=v}
end
end

UIXianFaWenDaoControl:showXianFaWenDaoAdjustWin({selectIndex=index,monTeam=teamData})
end
if robbotType==1 then
local robotcfg=cfgHelper.get1(cfg_robotmonsterconfig_get,robotID)
local monList=self:getMultipleMonsterList(robotcfg.monTeamId)

UIXianFaWenDaoControl:showXianFaWenDaoAdjustWin({selectIndex=index,monTeam=monList})
else
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eXianFaWenDao1,data.actorid,{serverid=data.serverid},callback,true)
end
end





function UIXFWDChallengeWin:onRefreshBtn()
local ltime=UIXianFaWenDaoControl:getMatchTime()
local currtime=gameUtilityModel.getServerShortTime()
local cd=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'match_cd')
local etime=ltime+cd
local dt=etime-currtime
if dt>0 then
UIManager.info(FMT.fmt('{0}秒后可刷新',dt))
else
if self.isPlaying then
return
end
UIXianFaWenDaoControl:setMatchTime(currtime)
self:startCountDown()
self.isPlaying=true
self:playAndWaitLeave(function()
self.isPlaying=false
UIXianFaWenDaoControl:reqMatching()
end)
end
end

function UIXFWDChallengeWin:onCloseClick()

UIXianFaWenDaoControl:showXianFaWenDaoWin()
end
