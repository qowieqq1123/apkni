







def_class("UISubAct_zongmendabi_adjust_win",UIWindowBase)









function UISubAct_zongmendabi_adjust_win:bindComponents()

self.playerA=UIObject.get(self,0)
self.playerB=UIObject.get(self,1)
self.teamScrollViewA=UIObject.get(self,2)
self.teamScrollViewB=UIObject.get(self,3)
self.adjustBtn=UIButton.get(self,4)
self.fightBtn=UIButton.get(self,5)
self.skipFight=UIToggleButton.get(self,6)
self.skipMask=UIButton.get(self,7)
self.excBtnA=UIButton.get(self,8)
self.excBtnB=UIButton.get(self,9)

self.adjustBtn:setButtonClick(function()self:onAdjustBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.skipMask:setButtonClick(function()self:onSkipMask()end)

self.excBtnA:setButtonClick(function()self:onExcBtnA()end)

self.excBtnB:setButtonClick(function()self:onExcBtnB()end)



end


function UISubAct_zongmendabi_adjust_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.playerA);self.playerA=nil;
_UIObject_release(self.playerB);self.playerB=nil;
_UIObject_release(self.teamScrollViewA);self.teamScrollViewA=nil;
_UIObject_release(self.teamScrollViewB);self.teamScrollViewB=nil;
_UIObject_release(self.adjustBtn);self.adjustBtn=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.skipFight);self.skipFight=nil;
_UIObject_release(self.skipMask);self.skipMask=nil;
_UIObject_release(self.excBtnA);self.excBtnA=nil;
_UIObject_release(self.excBtnB);self.excBtnB=nil;
end


















local _this=nil


function UISubAct_zongmendabi_adjust_win:onLoaded(...)
self:bindComponents()

self.btns={
self.excBtnA,
self.excBtnB,
}

self.teamScrollViewA:setChildScrollViewInit(0.5,true,nil,nil)
self.teamScrollViewB:setChildScrollViewInit(0.5,true,nil,nil)

self.skipNeedFC=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,'skip_cnd')

self.isSkip=activitiesHandle_zongmendabi:isSkipFight()
self.skipFight:setToggle(self.isSkip)
self.skipFight:setToggleChange(function(name,isOn)
self.isSkip=isOn
activitiesHandle_zongmendabi:setSkipFightState(isOn)
end)
end


function UISubAct_zongmendabi_adjust_win:__delete()
self:unbindComponents()
end




function UISubAct_zongmendabi_adjust_win:onShow(argtable,afterOnloaded)
_this=self
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self.tab_idx=argtable.tab_idx
self.targetIndex=argtable.selectIndex
self.matchList=argtable.matchList
self:refresh(argtable)
end

function UISubAct_zongmendabi_adjust_win:refresh(argtable)
self.myTeam=self:getMyTeamData(argtable.myTeam)
self.monTeam=argtable.monTeam
self.monsterFightEx=argtable.monsterFightEx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.isWaiting=false

self.skipMask:setActive(false)

self.excBtnSelectId=nil
self:setExBtns(0)
self.indexList={0,1}
self:refreshMyTeam()
self:refreshMonsterTeam()
self:setPlayerAInfo()
self:setPlayerBInfo()
end

function UISubAct_zongmendabi_adjust_win:setPlayerAInfo()
local widget=self.playerA:getChildWidgetBase()
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=nil})
local name=FMT.fmt('【{0}】\n{1}',loginModel:getMyServerName(),UISettingModel:getZMName())
widget:SetChildText(1,name)
end

function UISubAct_zongmendabi_adjust_win:setPlayerBInfo()
self.monInfo={}
local widget=self.playerB:getChildWidgetBase()
local data=self.matchList[self.targetIndex]
playerController:setHeadIcon(widget,0,{scale=0.75,iconInfo=data.iconInfo})
local server=loginModel:getMyServerName()
local sname=FMT.fmt('【{0}】\n{1}',server,data.sect_name)
widget:SetChildText(1,sname)
self.monInfo.name=data.sect_name
self.monInfo.server=server
self.monInfo.iconInfo=data.iconInfo
end

function UISubAct_zongmendabi_adjust_win:refreshMonsterTeam()
self.teamScrollViewB:setChildScrollViewCreateGrids(2,0)
local data=self.monTeam[self.targetIndex]
local fvalArr=self.monsterFightEx
local grids=self.teamScrollViewB:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,FMT.fmt('第{0}场',i))
local team=self.monTeam[i]
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
if td.monsterID~=0 then
comHelper.setChildModelRawImage_monster(widget,td.monsterID,2,0,eHeadCenterType.eHead)
local cfg=cfgHelper.get1(cfg_monsterconfig_get,td.monsterID)
local jobIcon=UIDiscipleModel:getJobIconName(cfg.job or 1)
widget:SetChildActive(6,false)
widget:SetChildCSImageSprite(3,globalABLookup.global,jobIcon)
comHelper.setChildModelHeadIconBGByColor(widget,5,cfg.color or 1)
else
item:SetChildActive(id,false)
end
else
local image=UIDiscipleModel.calculationDiscipleImageBase(td.netData)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,widget,modelParams)
local jobIcon=UIDiscipleModel:getJobIconName(image.job)

local dzId=td.netData.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
widget:SetChildActive(6,isSpDz)

widget:SetChildCSImageSprite(3,globalABLookup.global,jobIcon)
comHelper.setChildModelHeadIconBGByColor(widget,5,image.color)
end
else
item:SetChildActive(id,false)
end
end
local fvCount=fvalArr[i]or 0
item:SetChildText(1,fvCount)
item:SetChildActive(7,false)
end
end

function UISubAct_zongmendabi_adjust_win:refreshMyTeam()
self.teamScrollViewA:setChildScrollViewCreateGrids(2,0)
local grids=self.teamScrollViewA:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,FMT.fmt('第{0}场',i))
local team=self.myTeam[i]
local fval=0
local hasDZ
for ii=1,5 do
local id=ii+1
local td=team[ii]
if td then
local dzId=td[3]
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
hasDZ=true
item:SetChildActive(id,true)
local widget=item:GetChildWidgetBase(id)
widget:SetChildActive(1,true)
widget:SetChildActive(2,true)
widget:SetChildActive(4,false)
comHelper.setChildModelRawImage(widget,dzId,2,0,eHeadCenterType.eHead)
local jobicon=UIDiscipleModel:getJobIconNameX(dzId)
widget:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(dzId)
widget:SetChildActive(6,isSpDz)

local info=UIDiscipleModel:getDiscipleImageInfo(dzId)
comHelper.setChildModelHeadIconBGByColor(widget,5,info.color)
fval=fval+UIDiscipleModel:getDiscipleFightValue(dzId)
else
item:SetChildActive(id,false)
end
else
item:SetChildActive(id,false)
end
end
item:SetChildText(1,fval)
item:SetChildActive(7,false)
item:SetChildActive(8,not hasDZ)
end
end

function UISubAct_zongmendabi_adjust_win:getMyTeamData(teams)
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
local teamData={{},{}}
local team={{},{}}
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

function UISubAct_zongmendabi_adjust_win:openFightingWin(index,myTeam,monTeam)
local actID=self.actID
local subType=self.subType
local subid=self.subid
local tab_idx=self.tab_idx
local data=self.matchList[self.targetIndex]
local idx_=data.idx
local sub_actcfg=activitiesModel:getSubActivityConfig(subType,subid)
local tempTeam=table.deepCopy(myTeam)
local dataType=self.dataType
local dzCountLimit=sub_actcfg.deflist[2]
local singleFightDescStr=FMT.fmt('每个队伍最多可上阵{0}名弟子',dzCountLimit)
fightController.showPrepareWin(fightPreSelectModel.fightType.zongmendabi,{
enterTxt='宗门大比',
mapId=818002,
dzCountLimit=dzCountLimit,
singleFightDescStr=singleFightDescStr,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
skipShouYuanCheck=true,
isHomeBattle=true,
monsterFightEx=_this.monsterFightEx,
multipleMonsterListEx=monTeam,
multipleTeams=tempTeam,
editorTeam=false,
showZhenFa=false,
statePriorityCheck=false,
enterCallBack=function(teamList,zfId)
local sub_actInfo=activitiesModel:getSubActInfo(actID,subType,subid)
sub_actInfo:setSaveMyTeam(teamList)
fightLaunchController:sendFightEx(eBattleLaunch.zongmendabi,teamList,{actID,subType,subid,idx_})
local args={}
args.player1={UISettingModel:getZMName(),playerModel:getActorIconInfo()}
args.player2={data.sect_name,data.iconInfo}
fightModel:setSendExtraArgs(eBattleType.zongmendabi,args)
end,
cancelCallBack=function()
activitiesController:jump(actID,subType,subid,{tab_idx=tab_idx})
end
})
end

function UISubAct_zongmendabi_adjust_win:setExBtns(selId)
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

function UISubAct_zongmendabi_adjust_win:handleExcBtn(selId)
if not self.excBtnSelectId then
self:setExBtns(selId)
self.excBtnSelectId=selId
for i=1,2 do
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

for i=1,2 do
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

function UISubAct_zongmendabi_adjust_win:onExcBtnA()
self:handleExcBtn(1)
end

function UISubAct_zongmendabi_adjust_win:onExcBtnB()
self:handleExcBtn(2)
end


function UISubAct_zongmendabi_adjust_win:onHide()

end




function UISubAct_zongmendabi_adjust_win:onAdjustBtn()
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

function UISubAct_zongmendabi_adjust_win:onFightBtn()
if self.isWaiting then
return
end
local actID=self.actID
local subType=self.subType
local subid=self.subid
local data=self.matchList[self.targetIndex]
local idx_=data.idx

local teamList={}
local hasDZs={}
local notAllDZ=true
for i,v in ipairs(self.myTeam)do
local dt={}
local hasDZ=false
for ii=1,5 do
local d=v[ii]
if d then
hasDZ=true
dt[ii]={1,d[3]}
else
dt[ii]={0,int64.new('0')}
end
end
if hasDZ then
notAllDZ=false
end
hasDZs[i]=hasDZ
teamList[i]={#dt,dt,{818004,0}}
end
if notAllDZ then
UIManager.error(FMT.fmt('未有弟子上阵'))
return
end
for i=1,#hasDZs do
if not hasDZs[i]then
UIManager.error(FMT.fmt('第{0}队未有弟子上阵',i))
return
end
end
self.sub_actInfo:setSaveMyTeam(teamList)
fightLaunchController:sendFightEx(eBattleLaunch.zongmendabi,teamList,{actID,subType,subid,idx_,self.isSkip and 1 or 0})
local args={}
local name=FMT.fmt('[{0}]{1}',loginModel:getMyServerName(),UISettingModel:getZMName())
args.player1={name,playerModel:getActorIconInfo()}
name=FMT.fmt('[{0}]{1}',self.monInfo.server,self.monInfo.name)
args.player2={name,self.monInfo.iconInfo}
if self.isSkip then
args.isSkip=true
end
fightModel:setSendExtraArgs(eBattleType.zongmendabi,args)

self.isWaiting=true

if self.isSkip then
self:onCloseClick()
end
end

function UISubAct_zongmendabi_adjust_win:onSkipMask()

end

function UISubAct_zongmendabi_adjust_win:onCloseClick()

self:closeSelf()
end