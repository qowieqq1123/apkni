







def_class("UIXM_ZZSH_monsterMyTeamWin",UIWindowBase)









function UIXM_ZZSH_monsterMyTeamWin:bindComponents()

self.cliskMask=UIButton.get(self,0)
self.missSign=UIObject.get(self,1)
self.goingSign=UIObject.get(self,2)
self.commitBtn=UIButton.get(self,3)
self.autoBtn=UIButton.get(self,4)
self.costObj=UIButton.get(self,5)
self.ruleBtn=UIButton.get(self,6)
self.tipsTxt=UIText.get(self,7)
self.noSign=UIObject.get(self,8)
self.closeBtn=UIButton.get(self,9)
self.itemScrollView=UIObject.get(self,10)
self.infoItem=UIObject.get(self,11)
self.skillPanel=UIObject.get(self,12)
self.fightSortBtn=UIButton.get(self,13)
self.costIcon=UIImage.get(self,14)
self.costDesc=UIText.get(self,15)
self.commitBtnTxt=UIText.get(self,16)
self.ruleSelect=UIObject.get(self,17)
self.fightSortIcon=UIImage.get(self,18)
self.skillClick=UIButton.get(self,19)
self.skillScrollView=UIObject.get(self,20)
self.itemPanel=UIObject.get(self,21)
self.autoMark=UIImage.get(self,22)
self.autoDesc=UIText.get(self,23)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.autoBtn:setButtonClick(function()self:onAutoBtn()end)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fightSortBtn:setButtonClick(function()self:onFightSortBtn()end)

self.skillClick:setButtonClick(function()self:onSkillClick()end)



end


function UIXM_ZZSH_monsterMyTeamWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.missSign);self.missSign=nil;
_UIObject_release(self.goingSign);self.goingSign=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.autoBtn);self.autoBtn=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.infoItem);self.infoItem=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.fightSortBtn);self.fightSortBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.ruleSelect);self.ruleSelect=nil;
_UIObject_release(self.fightSortIcon);self.fightSortIcon=nil;
_UIObject_release(self.skillClick);self.skillClick=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.autoMark);self.autoMark=nil;
_UIObject_release(self.autoDesc);self.autoDesc=nil;
end
















local _this
local singleH=96
local itemPanelH=246

function UIXM_ZZSH_monsterMyTeamWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_ZZSH_monsterMyTeamWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_monsterMyTeamWin:onHide()

end




function UIXM_ZZSH_monsterMyTeamWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
self.fightSortType=1
self:refreshSortBtn()
self:refreshInfo()
self:refreshTeams(true)

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshState()
end)
end
end

function UIXM_ZZSH_monsterMyTeamWin:containQBGuid(guid)
return self.qbGuid==guid
end

function UIXM_ZZSH_monsterMyTeamWin:refreshView(guid)
if self.qbGuid==guid then
self:refreshInfo()
self:refreshTeams(true)
end
end

function UIXM_ZZSH_monsterMyTeamWin:refreshInfo()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local teamData=zhengzhanshanhaiModel:getMyPvETeam(self.qbGuid,qbData.infotype)
local detail_xm=qbData:getDetail_xm()
local curNum=detail_xm.teamNum
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()


local widget=self.infoItem:getWidgetBase()
self.infoWidget=widget
local cfg=qbData:getCfg()
self.isBoss=cfg.stage>=5

local bgIcon=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.stage)
widget:SetChildCSImageSprite(0,globalABLookup.global,bgIcon)

local groupid=cfg.monster[1]
comHelper.setChildModelRawImage_monsterGroup(widget,groupid,1,0,eHeadCenterType.eHead)

local stageBGIcon=FMT.fmt('image_gwtouxiangdjk_{0}',cfg.stage)
widget:SetChildCSImageSprite(2,globalABLookup.global,stageBGIcon)
widget:SetChildText(3,tostring(cfg.stage))





local nameStr=qbData:getName()
widget:SetChildText(5,nameStr)

local xmData=qbData:getXM()
local hasXM=xmData~=nil
widget:SetChildActive(6,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(6,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(8,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
widget:SetChildText(9,xmName_str)

local detail=qbData:getDetail()
local percent
if detail then
percent=detail.percent
else
percent=10000
end
local rate_str=FMT.fmt('{0}%',percent/100)
if self.isBoss and percent<=1 then
percent=0
rate_str="垂死"
end
widget:SetChildIconFillAmount(10,percent/10000)
widget:SetChildText(11,rate_str)



local wayTime=zhengzhanshanhaiModel:getQingBaoWayTime(qbData)
local way_str=timeHelper.format_time_stamp3(wayTime)
widget:SetChildText(13,way_str)

self:refreshState()

local teamNum_str=FMT.fmt('{0}/{1}',curNum,fixNum)
widget:SetChildText(16,teamNum_str)

local hasMy=detail_xm.hasMy

self.tipsTxt:setText(FMT.fmt('目前仙盟最大集结队伍数量：{0}',maxNum))

local showCost=not hasMy and teamData.sec<0
self.costObj:setActive(showCost)
if showCost then
self.costIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtXuKongLing),false)
local need=zhengzhanshanhaiController:getZZSHCfg('consume',1)
local num_str=tostring(need)
self.costDesc:setText(num_str)
end

if teamData.sec<0 then
local isCreater=detail_xm.isCreater

self.commitBtn:setActive(true)
self.goingSign:setActive(false)
self.missSign:setActive(false)
local showAuto=true
self.autoBtn:setActive(showAuto)

if showAuto then
local autoGray=not isCreater
self.autoMark:setImageExGray(autoGray)
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
self.autoDesc:setText(FMT.fmt('集结{0}支队伍自动出击',fixNum))
self:refreshAutoMark(detail_xm)
end

local commit_str
local commit_gray
local btnY
if hasMy then

if isCreater then

commit_str='出发'

local isFixNum=curNum>=fixNum
commit_gray=not isFixNum
else
commit_str='等待出发'
commit_gray=true
end
btnY=-268
else

commit_str='参与集结'

local isFull=curNum>=maxNum
commit_gray=isFull
btnY=-290
end
self.commitBtnTxt:setText(commit_str)

self.commitBtn:setChildImageExGray(commit_gray)

self.commitBtn:setLocalPosY(btnY)
else

self.commitBtn:setActive(false)
self.goingSign:setActive(hasMy)
self.missSign:setActive(not hasMy)
self.autoBtn:setActive(false)
end


local skillParamList=cfg.showSkillParam
local isShowSkill=skillParamList~=nil and next(skillParamList)~=nil
self.skillPanel:setActive(isShowSkill)
if isShowSkill then
local skillCount=#skillParamList
self.skillScrollView:setChildScrollViewCreateGrids(skillCount,skillCount)
local grids=self.skillScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local skillItem=grids[i-1]
local skillParam=skillParamList[i]
local skillId=skillParam[1]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg then
skillItem:SetChildActive(-1,true)
skillItem:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
skillItem:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onSkillBtnClick(skillParamList)
end)
else
skillItem:SetChildActive(-1,false)
end
end
end
end

function UIXM_ZZSH_monsterMyTeamWin:refreshState()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData==nil then return end
local teamData=zhengzhanshanhaiModel:getMyPvETeam(self.qbGuid,qbData.infotype)
if teamData==nil then return end
local widget=self.infoWidget

local state,time=zhengzhanshanhaiModel:getPvETeamState(zhengzhanshanhaiModel.qbType.eMonster,teamData.sec,true)
widget:SetChildText(14,state)
local time_str
if time>0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str='--'
end
widget:SetChildText(15,time_str)
end

function UIXM_ZZSH_monsterMyTeamWin:refreshTeams(isInit)
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData==nil then return end
if self.teamsList==nil or isInit then
local list={}
local detail_xm=qbData:getDetail_xm()
for key,v in pairs(detail_xm.allTeam)do
table.insert(list,v)
end
self.teamsList=list
end
local num=#self.teamsList
if num>1 then
table.sort(self.teamsList,function(a,b)
if self.fightSortType==1 then
return a.fight_num>b.fight_num
else
return a.fight_num<b.fight_num
end
end)
end
local isShow=num>0
local newlist=table.weakCopy(self.teamsList)
self.itemScrollView:setActive(isShow)
self.noSign:setActive(not isShow)
if isShow then
local teamData=zhengzhanshanhaiModel:getMyPvETeam(self.qbGuid,qbData.infotype)
local detail_xm=qbData:getDetail_xm()
local isWait=teamData.sec<0
local isCreater=detail_xm.isCreater

if isCreater then
local _maxNum,_fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
if num<_maxNum then
newlist[#newlist+1]={isjijiedui=true}
num=num+1
end
end
self.itemPanel:setChildLayoutGroupCreateItems(num,function(idx)
local item=self.itemPanel:getChildLayoutGroupGridItem(idx-1)
local team=newlist[idx]
item:SetChildActive(11,false)
item:SetChildActive(13,true)
if team and team.isjijiedui then
item:SetChildActive(7,false)
item:SetChildActive(11,true)
item:SetChildActive(13,false)
item:SetChildButtonClick(12,function()
if _this==nil then return end
_this:onYbdaddbtn()
end)

_this:delayDo(0.8,function()
if _this==nil then return end
local posy=singleH*num-itemPanelH
if posy<0 then
posy=0
end
_this.winlua:SetChildLocalPosY(self.itemPanel:getID(),posy)
end)
return
end

item:SetChildText(1,tostring(idx))

local headParams={iconInfo=team.iconInfo,scale=0.6}
playerController:setHeadIcon(item,2,headParams)

item:SetChildText(3,team.sectname)

item:SetChildText(4,team.actorname)

local dzlist=team.discipleList or{}
local dznum=5
item:SetChildLayoutGroupCreateItems(5,dznum)
local grids=item:GetChildLayoutGroupGridList(5)
for i=1,dznum do
local netData=dzlist[i]
local dzitem=grids[i-1]
local has=netData~=nil and netData.flag>0
dzitem:SetChildActive(0,not has)
dzitem:SetChildActive(1,has)




if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzitem,1,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(2,dzitem,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzitem:SetChildCSImageSprite(3,globalABLookup.global,jobicon)
end
end

item:SetChildText(6,mathHelper.formatNumber5(team.fight_num,2))

local isCreate=team.isCreate
item:SetChildActive(7,isCreate)

local isMy=team.isMy
item:SetChildActive(8,isMy)

local showLeave=false
local showKickout=false
if isWait then
if isCreater then
if isMy then
showLeave=true
else
showKickout=true
end
else
if isMy then
showLeave=true
end
end
end
item:SetChildActive(9,showLeave)
item:SetChildActive(10,showKickout)
if showLeave then
item:SetChildButtonClick(9,function()
if _this==nil then return end
_this:onLeaveBtnClick(idx)
end)
end
if showKickout then
item:SetChildButtonClick(10,function()
if _this==nil then return end
_this:onKickoutBtnClick(idx)
end)
end
end)
end
end

function UIXM_ZZSH_monsterMyTeamWin:onLeaveBtnClick(idx)
local qbGuid=self.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then return end
local detail_xm=qbData:getDetail_xm()
if detail_xm==nil then return end

local team=self.teamsList[idx]
local taractorid=team.actorid
local isCreater=detail_xm.isCreater
local isMy=team.isMy
local check=false
if isCreater and isMy then
check=true
elseif isMy then
check=true
end
if check then
local moneyName=moneyModel.getMoneyName(eMoneyType.mtXuKongLing)
local content=FMT.fmt('是否退出退伍（{0}将返还）',moneyName)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
local qbData_=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData_==nil then return end
local teamData_=zhengzhanshanhaiModel:getMyPvETeam(qbGuid,qbData_.infotype)
if teamData_==nil then return end
if teamData_.sec>0 then
UIManager.error('队伍已出发，无法退出')
return
end
zhengzhanshanhaiController:reqMonsterJiJieKickout(qbGuid,taractorid)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end

function UIXM_ZZSH_monsterMyTeamWin:onKickoutBtnClick(idx)
local qbGuid=self.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then return end
local detail_xm=qbData:getDetail_xm()
if detail_xm==nil then return end
local team=self.teamsList[idx]
local taractorid=team.actorid
local isCreater=detail_xm.isCreater
local isMy=team.isMy
if isCreater and not isMy then
local content='是否将该玩家踢出退伍'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
local qbData_=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData_==nil then return end
local teamData_=zhengzhanshanhaiModel:getMyPvETeam(qbGuid,qbData_.infotype)
if teamData_==nil then return end
if teamData_.sec>0 then
UIManager.error('队伍已出发，无法踢出')
return
end
zhengzhanshanhaiController:reqMonsterJiJieKickout(qbGuid,taractorid)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end

function UIXM_ZZSH_monsterMyTeamWin:onCommitBtn()
local qbGuid=self.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then
UIManager.info('该异兽已被消灭')
return
end
local teamData=zhengzhanshanhaiModel:getMyPvETeam(qbGuid,qbData.infotype)
if teamData==nil then
UIManager.info('该队伍行程已结束')
end

local detail_xm=qbData:getDetail_xm()
local maxNum,fixNum=zhengzhanshanhaiModel:getMaxMonsterTeamNum()
local curNum=detail_xm.teamNum
if teamData.sec<0 then


local hasMy=detail_xm.hasMy
if hasMy then

local isCreater=detail_xm.isCreater
if isCreater then


local isFixNum=curNum>=fixNum
if not isFixNum then
UIManager.info(FMT.fmt('至少集结{0}支队伍才能出发',fixNum))
return
end

zhengzhanshanhaiController:reqMonsterGo(qbGuid)
else


end
else

if not zhengzhanshanhaiModel:checkPvEJoin(qbGuid,true)then
return
end


local isFull=curNum>=maxNum
if isFull then
UIManager.info('队伍已满员')
return
end

if not zhengzhanshanhaiModel:checkMyPvEWaiPaiNum(true)then
return
end
if not zhengzhanshanhaiModel:checkXuKongLingCost(qbData.infotype,true)then
return
end

local mapId=zhengzhanshanhaiModel:getMapID(2)
local cfg=qbData:getCfg()
local monsterGroupId=cfg.monster[1]
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local winArgs=
{
enterCallBack=function(selectList,zfId,mapId)
if zhengzhanshanhaiModel:checkJoin()then
local qbData_=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData_~=nil then
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,v[2])
end

zhengzhanshanhaiController:reqMonsterJion(qbGuid,dzlist)
else
UIManager.error('该异兽已被消灭')
end
end
fightController:closeSelectStage()
zhengzhanshanhaiController:finishFightOpen({showCloud=false,jumpQB=qbGuid,jumpQB2=qbGuid,not_showlogtips=true})
end,
enterTxt="山海世界",
cancelCallBack=function()
fightController:closeSelectStage()
zhengzhanshanhaiController:finishFightOpen({showCloud=false,jumpQB=qbGuid,jumpQB2=qbGuid,not_showlogtips=true})
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
sureBodyid=5280,
mapId=mapId,
setteamlist_nil=true,


}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
zhengzhanshanhaiController:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=zhengzhanshanhaiModel.checkDZSortFunc
zhengzhanshanhaiController:setFigthReady(true)
fightController.showPrepareWin(fightPreSelectModel.fightType.zzshPvEMonster,winArgs)
end
end
end

function UIXM_ZZSH_monsterMyTeamWin:onCostObj()
gainControl:showGainWin(eMoneyType.mtXuKongLing)
end

function UIXM_ZZSH_monsterMyTeamWin:onCliskMask()
self:onCloseBtn()
end

function UIXM_ZZSH_monsterMyTeamWin:onCloseBtn()
self:closeSelf()
end

function UIXM_ZZSH_monsterMyTeamWin:onRuleBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='act_zzsh_monster_join_rule_%d'
d.closeCB=function()
if _this==nil then return end
_this:refreshRuleSelect(false)
end
UIManager:showWindow('UIRuleWin',d)
self:refreshRuleSelect(true)
end

function UIXM_ZZSH_monsterMyTeamWin:refreshRuleSelect(flag)
self.ruleSelect:setActive(flag)
end

function UIXM_ZZSH_monsterMyTeamWin:onFightSortBtn()
if self.fightSortType==1 then
self.fightSortType=2
else
self.fightSortType=1
end
self:refreshSortBtn()
self:refreshTeams()
end

function UIXM_ZZSH_monsterMyTeamWin:refreshSortBtn()
local fightIcon
if self.fightSortType==1 then
fightIcon='button_tybukepailie'
else
fightIcon='button_tykepailie'
end
self.fightSortIcon:setSprite(globalABLookup.global,fightIcon)
end

function UIXM_ZZSH_monsterMyTeamWin:onSkillBtnClick(skillParam)
local skillCount=#skillParam
if skillCount<3 then
self:showWindow('UITeXingTipsListWin',{skillParamList=skillParam,pos={-220,230},posType=2})
else
self:showWindow('UITeXingTipsListWin',{skillParamList=skillParam,pos={-50,0}})
end

end

function UIXM_ZZSH_monsterMyTeamWin:onSkillClick()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local cfg=qbData:getCfg()
local skillParamList=cfg.showSkillParam
local isShowSkill=skillParamList~=nil and next(skillParamList)~=nil
if isShowSkill then
self:onSkillBtnClick(skillParamList)
end
end

function UIXM_ZZSH_monsterMyTeamWin:onAutoBtn()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData==nil then return end
local teamData=zhengzhanshanhaiModel:getMyPvETeam(self.qbGuid,qbData.infotype)
if teamData==nil then return end
if teamData.sec>0 then return end
local detail_xm=qbData:getDetail_xm()
local isCreater=detail_xm.isCreater
if not isCreater then
UIManager.error('只有发起集结的祖师才可更改设置')
return
end
if self.lockClick and Time.realtimeSinceStartup<self.lockClick then
UIManager.error('操作太频繁，请稍后尝试')
return
end
self.lockClick=Time.realtimeSinceStartup+2

local setoutnum=detail_xm.setoutnum
if setoutnum>0 then
zhengzhanshanhaiController:reqMonsterChange(self.qbGuid,0)
else
local mass=zhengzhanshanhaiController:getZZSHCfg('mass')
zhengzhanshanhaiController:reqMonsterChange(self.qbGuid,mass[1])
end
end

function UIXM_ZZSH_monsterMyTeamWin:refreshAutoMark(detail_xm)
local setoutnum=detail_xm.setoutnum
local isCheck=setoutnum>0
local icon=isCheck and'image_dygou_2'or'image_dygou_1'
self.autoMark:setSprite(globalABLookup.global,icon)
local isCreater=detail_xm.isCreater
local isGray=not isCreater
self.autoMark:setImageExGray(isGray)
end

function UIXM_ZZSH_monsterMyTeamWin:rec_changeJiJie(guid)
if guid==self.qbGuid then
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData then
local detail_xm=qbData:getDetail_xm()
if detail_xm then
self:refreshAutoMark(detail_xm)
end
end
end
end


function UIXM_ZZSH_monsterMyTeamWin:onYbdaddbtn()
local qbData=zhengzhanshanhaiModel:getQingBaoData(_this.qbGuid)

if qbData==nil then return end
local teamData_=zhengzhanshanhaiModel:getMyPvETeam(_this.qbGuid,qbData.infotype)
if teamData_==nil then return end
if teamData_.sec>0 then
UIManager.error('队伍已出发')
return
end
zhengzhanshanhaiModel:setqbguid(_this.qbGuid)
local cfg=qbData:getCfg()
if cfg.stage then
zhengzhanshanhaiController:send_20_251(cfg.stage,_this.qbGuid)
end

end
