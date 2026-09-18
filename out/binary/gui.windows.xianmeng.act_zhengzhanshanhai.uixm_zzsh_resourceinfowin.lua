







def_class("UIXM_ZZSH_resourceInfoWin",UIWindowBase)









function UIXM_ZZSH_resourceInfoWin:bindComponents()

self.mask=UIObject.get(self,0)
self.frameAnim=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.costIcon=UIImage.get(self,3)
self.costDesc=UIText.get(self,4)
self.ruleBtn=UIButton.get(self,5)
self.attackShowBtn=UIButton.get(self,6)
self.resInfo=UIObject.get(self,7)
self.rewardPanel=UIObject.get(self,8)
self.costObj=UIButton.get(self,9)
self.commitBtn=UIButton.get(self,10)
self.cancelBtn=UIButton.get(self,11)
self.ruleSelect=UIObject.get(self,12)
self.attackNumObj=UIObject.get(self,13)
self.fightSign=UIObject.get(self,14)
self.attackNum=UIText.get(self,15)
self.PKorNotBtn=UIButton.get(self,16)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.attackShowBtn:setButtonClick(function()self:onAttackShowBtn()end)

self.costObj:setButtonClick(function()self:onCostObj()end)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.PKorNotBtn:setButtonClick(function()self:onPKorNotBtn()end)



end


function UIXM_ZZSH_resourceInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.frameAnim);self.frameAnim=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.attackShowBtn);self.attackShowBtn=nil;
_UIObject_release(self.resInfo);self.resInfo=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.ruleSelect);self.ruleSelect=nil;
_UIObject_release(self.attackNumObj);self.attackNumObj=nil;
_UIObject_release(self.fightSign);self.fightSign=nil;
_UIObject_release(self.attackNum);self.attackNum=nil;
_UIObject_release(self.PKorNotBtn);self.PKorNotBtn=nil;
end
















local _this


function UIXM_ZZSH_resourceInfoWin:onLoaded(...)
_this=self
self:bindComponents()
local pos=self:getChildCanvas(-1)
UIManager:invokeUIMethod('UIXM_ZZSH_PvEMainWin','setMoneyRootCanves',true,pos[1],pos[2]+1)
end


function UIXM_ZZSH_resourceInfoWin:__delete()
_this=nil
self:unbindComponents()
if UIManager:isActive('UIXM_ZZSH_resourceAllTeamWin')then
UIManager:closeWindow('UIXM_ZZSH_resourceAllTeamWin')
end
if self.mapView then
if self:checkWin()then
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','setMapView',self.mapView)
end
end
UIManager:invokeUIMethod('UIXM_ZZSH_PvEMainWin','setMoneyRootCanves',false)
end


function UIXM_ZZSH_resourceInfoWin:onHide()
if self.ZSTime then
self.ZSTime=nil
end

end

function UIXM_ZZSH_resourceInfoWin:getMapView()
local view=UIManager:invokeUIMethod('UIXM_ZZSH_selfPVETeamWin','getMapView')
if view==nil then
view=UIManager:invokeUIMethod('UIXM_ZZSH_monsterSelectWin','getMapView')
end
if view==nil then
view=UIManager:invokeUIMethod('UIXM_ZZSH_resourceSelectWin','getMapView')
end
return view
end




function UIXM_ZZSH_resourceInfoWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
self.mapView=argtable.view
self.baodiflag=argtable.baodiflag
local view
view=self:getMapView()
if view then
self.mapView.scale=view.scale
view.g_x=self.mapView.g_x
view.g_y=self.mapView.g_y
view.isChange=true
end
self.autoCheck=false
self:refreshMask()
self:refreshInfo()
local cb=function()
self:onLoadFinish()
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameAnim:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
end
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
if self.baodiflag then
if self.baodiflag==1 then
self:onCommitBtn()
elseif self.baodiflag==0 then
self:onCancelBtn()
end

end

end

function UIXM_ZZSH_resourceInfoWin:containQBGuid(guid)
return self.qbGuid==guid
end

function UIXM_ZZSH_resourceInfoWin:refreshView(guid)
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if qbData==nil then
return
end
self.qbGuid=guid
if self.mapView then
self.mapView.g_x=qbData.x
self.mapView.g_y=qbData.y
end
self:refreshInfo()
UIManager:invokeUIMethod('UIXM_ZZSH_resourceAllTeamWin','refreshView',guid)
end

function UIXM_ZZSH_resourceInfoWin:clearMapView()
self.mapView=nil
end

function UIXM_ZZSH_resourceInfoWin:refreshTime()
self:refreshResourceNum()
self:refreshState()
end

function UIXM_ZZSH_resourceInfoWin:onLoadFinish()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end

function UIXM_ZZSH_resourceInfoWin:checkWin()
return not UIManager:isActive('UIXM_ZZSH_selfPVETeamWin')and
not UIManager:isActive('UIXM_ZZSH_monsterSelectWin')and
not UIManager:isActive('UIXM_ZZSH_resourceSelectWin')
end

function UIXM_ZZSH_resourceInfoWin:refreshMask()
local showMask=self:checkWin()
self.mask:setActive(showMask)
end

function UIXM_ZZSH_resourceInfoWin:refreshInfo()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local xmData,ZSflag=qbData:getXM()
local cfg=qbData:getCfg()
local detail=qbData:getDetail()
local myTeam=detail.myTeam
local hasMy=myTeam~=nil
local checkFlag=detail:checkXM()
local max_atkNum=cfg.max
local atkNum=qbData:getAllTeamNum()

local showAttactNum=atkNum>0
self.attackNumObj:setActive(showAttactNum)
if showAttactNum then
self.attackNum:setText(tostring(atkNum))
end


local widget=self.resInfo:getWidgetBase()
self.resWidget=widget


local showModel=cfg.model~=nil
widget:SetChildActive(0,showModel)
if showModel then
local modelParams=comHelper.getMonsterModelParamsEx(cfg.model)
local size=cfg.modelSet[5]or cfg.modelSet[1]
widget:SetChildUIModelShowTarget(0,modelParams.body,size,modelParams.componets,eAnimationID.stand)
end
local showModelIcon=cfg.modelIcon~=nil
widget:SetChildActive(14,showModelIcon)
if showModelIcon then
widget:SetChildCSImageSprite(14,globalABLookup.zzshentityicons,cfg.modelIcon)
end


widget:SetChildActive(15,false)

if ZSflag==1 then
local lerp=self:judetime()
if lerp>0 then
widget:SetChildActive(15,true)
self:setZhuanShuTimer(widget,lerp)
end
end

local nameStr=qbData:getName()
widget:SetChildText(2,nameStr)

local collectNum=detail.collectNum or 0
local teamNum_str=FMT.fmt('队伍：<color=#171311>{0}/{1}</color>',collectNum,max_atkNum)
widget:SetChildText(3,teamNum_str)
local showTeamSign=checkFlag~=0
widget:SetChildActive(4,showTeamSign)
if showTeamSign then
local teamSignIcon=checkFlag==1 and'image_ben_1'or'image_di_1'
widget:SetChildCSImageSprite(4,globalABLookup.global,teamSignIcon)
end

local xmData=qbData:getXM()
local hasXM=xmData~=nil
widget:SetChildActive(5,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

widget:SetChildCSImageSprite(6,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(5,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(7,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
else
xmName_str='无'
end
widget:SetChildText(8,xmName_str)

self:refreshResourceNum(detail,widget)

local wayTime=zhengzhanshanhaiModel:getQingBaoWayTime(qbData)
local way_str=timeHelper.format_time_stamp3(wayTime)
widget:SetChildText(11,way_str)

local showState=hasMy
widget:SetChildActive(12,showState)
if showState then
self:refreshState()
end


local rewards=cfg.rewardShow
local rnum=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local showSign=itemnum<=0
rwItem:SetChildActive(1,showSign)
end

local showCost=not hasMy
self.costObj:setActive(showCost)
if showCost then
self.costIcon:setImageIcon(moneyModel.getIconNameEx(eMoneyType.mtXuKongLing),false)
local need=zhengzhanshanhaiModel:getXuKongLingNeed(qbData.infotype)
local num_str=tostring(need)
self.costDesc:setText(num_str)
end

local showCommit=not hasMy
self.commitBtn:setActive(showCommit)







local showCancel=hasMy
self.cancelBtn:setActive(showCancel)

local gather=zhengzhanshanhaiController:getZZSHCfg('gather')
local stage=cfg.stage

local icon=(stage<=gather[2])and 2 or 1
self.PKorNotBtn:setSprite(globalABLookup.zzshicons,FMT.fmt('button_shanhaisjlbtp_{0}',icon))

end


function UIXM_ZZSH_resourceInfoWin:refreshState()
local widget=self.resWidget
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData==nil then return end
local detail=qbData:getDetail()
local myTeam=detail.myTeam
if myTeam==nil then return end
local state,time=zhengzhanshanhaiModel:getPvETeamState(qbData.infotype,myTeam.sec,true)

local state_str=FMT.fmt('{0}：',state)
widget:SetChildText(12,state_str)

local time_str
if time>=0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str=''
end
widget:SetChildText(13,time_str)
end

function UIXM_ZZSH_resourceInfoWin:refreshResourceNum(detail,widget)
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
if qbData==nil then return end
if detail==nil then
detail=qbData:getDetail()
end
if widget==nil then
widget=self.resInfo:getWidgetBase()
end
local cfg=qbData:getCfg()
local cur=detail:getLerpRes()
local max=cfg.moneynum
widget:SetChildIconFillAmount(9,cur/max)
local rate_str=FMT.fmt('{0}/{1}',mathHelper.formatNumber2(cur),mathHelper.formatNumber2(max))
widget:SetChildText(10,rate_str)
end

function UIXM_ZZSH_resourceInfoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_ZZSH_resourceInfoWin:onClickMask()
self:onCloseClick()
end

function UIXM_ZZSH_resourceInfoWin:onCloseClick()
self:closeSelf()
end

function UIXM_ZZSH_resourceInfoWin:onRuleBtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='act_zzsh_resource_rule_%d'
d.closeCB=function()
if _this==nil then return end
_this:refreshRuleSelect(false)
end
UIManager:showWindow('UIRuleWin',d)
self:refreshRuleSelect(true)
end

function UIXM_ZZSH_resourceInfoWin:refreshRuleSelect(flag)
self.ruleSelect:setActive(flag)
end

function UIXM_ZZSH_resourceInfoWin:onAttackShowBtn()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local detail=qbData:getDetail()
if detail then
UIManager:showWindow('UIXM_ZZSH_resourceAllTeamWin',{qbGuid=self.qbGuid})
end
end

function UIXM_ZZSH_resourceInfoWin:onCostObj()
gainControl:showGainWin(eMoneyType.mtXuKongLing)
end

function UIXM_ZZSH_resourceInfoWin:onCommitBtn()
local qbGuid=self.qbGuid
local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData==nil then
UIManager.info('该宝地已被采空')
return
end
if not qbData:checkXM(true)then
return
end

local detail=qbData:getDetail()
local curRes=detail:getLerpRes()
if curRes<=0 then
UIManager.info('该宝地已被采空')
return
end
if not zhengzhanshanhaiModel:checkMyPvEWaiPaiNum(true)then
return
end
local cfg=qbData:getCfg()
local max_atkNum=cfg.max

local checkFlag=detail:checkXM()
local collectNum=detail.collectNum or 0
if checkFlag~=2 then
if collectNum>=max_atkNum then
UIManager.info('采集空位已满')
return
end
end

if not zhengzhanshanhaiModel:checkXuKongLingCost(qbData.infotype,true)then
return
end

local cb=function()
if _this==nil then return end

UIManager:showWindow('UIXM_ZZSH_resourceDiZiWin',{qbGuid=self.qbGuid})
end

local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHtips)
local check2=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHtips2)
local gather=zhengzhanshanhaiController:getZZSHCfg('gather')
local wayTime=zhengzhanshanhaiModel:getQingBaoWayTime(qbData)
local arriveTime=timeHelper.getServerShortTime()+wayTime
local gotoTeams=zhengzhanshanhaiModel:getAllResourcePvETeams_goto(qbGuid,arriveTime)
local gotoMyTeams=zhengzhanshanhaiModel:getMyXMAllResourcePvETeams_goto(qbGuid)

if cfg.stage<=gather[2]then
if collectNum+#gotoTeams>=max_atkNum then
UIManager.info('将有其他队伍抢先到达，现在前往将无功而返')
return
end
end

if checkFlag==2 and not check then
local content='该宝地已有其他仙盟入驻采集，前往采集将发生战斗，是否继续？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=cb,
showclosebtn=true,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHtips,flag)

end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
elseif checkFlag~=2 and cfg.stage>gather[2]then
local nextFunc=function()
local content='该宝地与其他仙盟队伍遭遇将发生战斗，战斗失败采集资源会被部分抢夺，是否继续？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=cb,
showclosebtn=true,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHtips2,flag)

end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
local okfunc=check2 and cb or nextFunc
if collectNum+#gotoMyTeams>=max_atkNum then
local content='将有本仙盟其他队伍抢先到达，现在前往将可能无功而返，是否继续安排采集？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=okfunc,
showclosebtn=true,
}
self.tipsDialog=UIDialogManager.newDialog(showdata)
self.tipsDialog:show()
else
okfunc()
end
else
cb()
end
end

function UIXM_ZZSH_resourceInfoWin:onCancelBtn()
local qbGuid=self.qbGuid
if not zhengzhanshanhaiModel:checkInMyWaiPai(qbGuid)then
return
end
local content='是否确认撤回该队伍？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
if not zhengzhanshanhaiModel:checkInMyWaiPai(qbGuid)then
return
end
zhengzhanshanhaiController:reqPvETeamBack(qbGuid)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end




function UIXM_ZZSH_resourceInfoWin:onPKorNotBtn()
local qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
local cfg=qbData:getCfg()
local gather=zhengzhanshanhaiController:getZZSHCfg('gather')
local stage=cfg.stage

if stage<=gather[2]then
self:showTips2()
else
self:showTips1()
end

end

function UIXM_ZZSH_resourceInfoWin:showTips1()
local args={}
args.desclist={}
local num=10
local name='zzsh_baodi_pk_rule_%d'
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(args.desclist,str)
end
end
args.title1="争斗宝地"

args.pos=Vector2(0,0)
UIManager:showWindow('UIDescribeTips7',args)
end


function UIXM_ZZSH_resourceInfoWin:showTips2()
local args={}
args.desclist={}
local num=10
local name='zzsh_baodi_safe_rule_%d'
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(args.desclist,str)
end
end
args.title1="安全宝地"

args.pos=Vector2(0,0)
UIManager:showWindow('UIDescribeTips7',args)
end


function UIXM_ZZSH_resourceInfoWin:setZhuanShuTimer(widget,lerp)
local func
func=function()
local lerp=self:judetime()
if lerp>0 then
local time_str=FMT.fmt('{0}后消失',timeHelper.format_time_stamp(lerp))
widget:SetChildText(15,time_str)
else
self.ZSTime=nil
end
end

func()
self.ZSTime=self:setTimer(1,0,func)
end

function UIXM_ZZSH_resourceInfoWin:judetime()
local remove=zhengzhanshanhaiController:getZZSHCfg('remove')
local y,m,d=timeHelper.getServerData()
local t1=timeHelper.timeServer(y,m,d,remove,0,0)
local cur=gameUtilityModel.getServerLongTime()
if cur>t1 then
local w=timeHelper.getWeakDateEx2(cur)
if w==5 then
t1=t1+(24-remove)*3600
else
t1=t1+86400
end
end
local lerp=t1-cur
return lerp
end