









local xjEntityHud_clickTeam={}
local poslp={
[1]={
{-138,-2},
},
[2]={
{-138,-2},{148,-2},
},
[3]={
{-104,92},{-104,-97},{114,92},
},
[4]={
{-104,92},{-104,-97},{114,92},{116,-97},
},
[5]={
{-104,92},{-138,-2},{-104,-97},{114,92},{148,-2}
},
[6]={
{-104,92},{-138,-2},{-104,-97},{114,92},{148,-2},{116,-97},
},
}
local _ab=globalABLookup.xianguan
local _this

function xjEntityHud_clickTeam:onInit()
self.needFollow=true
self.showtqtip=false
self._istqShow=false
end


function xjEntityHud_clickTeam:onCreateWidget(widget)

local ent=xianjieController:getEntity(self.m_key)
local trans=ent:getHudBindingTransform()
xianjieController:setFollowTarget(trans)
_this=self
notifySystem:listenNotify(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
notifySystem:listenNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)

widget:SetChildCanvasGroupAlpha(14,1)

local teamHandle=ent:getTeamHandle()
self.thismarchguid=teamHandle.marchguid
local ismy=teamHandle:checkMyTeam()
local btns={}

widget:SetChildButtonClick(0,function()
self:onBeginClick()
end)
btns[#btns+1]={0}

local openDetail=teamHandle:checkDetailOpen()
widget:SetChildActive(1,openDetail)
if openDetail then
widget:SetChildButtonClick(1,function()
self:onDetailClick()
end)
btns[#btns+1]={1}
end

local openSpeedup=teamHandle:checkSpeeUpOpen()
widget:SetChildActive(2,openSpeedup)
if openSpeedup then
widget:SetChildButtonClick(2,function()
self:onSpeedUpClick()
end)
btns[#btns+1]={2}
end

widget:SetChildButtonClick(3,function()
self:onEndClick()
end)
btns[#btns+1]={3}


local showEmo=false
widget:SetChildActive(4,showEmo)
if showEmo then
widget:SetChildButtonClick(4,function()
self:onEmoClick()
end)
btns[#btns+1]={4}
end

local openRetract=teamHandle:checkRetractOpen()
widget:SetChildActive(5,openRetract)
if openRetract then
widget:SetChildButtonClick(5,function()
self:onCallBackClick()
end)
btns[#btns+1]={5}
end


local istqShow=false
local xgid=false
if teamHandle then
istqShow,xgid=xianguanModel.isTTMS_tequan()
if teamHandle.enemyType==xjEnemyType.eSelf or teamHandle.enemyType==xjEnemyType.eAllies then
istqShow=false
end
if teamHandle.teamType==xjTeamHandleType.eMarchBack then
istqShow=false
end
end

widget:SetChildActive(8,istqShow)
if istqShow then
UIManager:invokeUIMethod("UIXianJieFuncStorageWin","hideFuncList")
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
local str=''
local cd=xianguanModel.ttms_YJZZ_Cd()
if cd>0 then
self._istqShow=true
widget:SetChildActive(15,false)
else
self._istqShow=false
local maxTimes=xianguanConfig.getTeQuanCfg(tqid,"times")or 0
local usedTimes=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getTimes")or 0
if usedTimes>=maxTimes then
str=string.format("今天：<color=#f36666>%d/%d</color>",maxTimes-usedTimes,maxTimes)
widget:SetChildActive(15,false)
else
str=string.format("今天：<color=#aae252>%d/%d</color>",maxTimes-usedTimes,maxTimes)
widget:SetChildActive(15,true)
end
end

widget:SetChildText(9,str)

self.showtqtip=false
widget:SetChildActive(11,self.showtqtip==true)
if self.showtqtip==true then
widget:SetChildCanvasGroupDOFade(11,1,0.5,nil)
else
widget:SetChildCanvasGroupAlpha(11,0)
end
local tipspanelwdg=widget:GetChildWidgetBase(11)
local jobCfg=xianguanConfig.getJobConfig(nil,xgid)
local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
tipspanelwdg:SetChildCSImageSprite(0,_ab,jobIconName)
local tqname=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'name')
tipspanelwdg:SetChildText(1,tqname)

local tipsCfg=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'tipsDesc')
tipspanelwdg:SetChildText(4,tipsCfg[1]or'每周可迷惑敌对仙域祖师10次')
tipspanelwdg:SetChildText(5,tipsCfg[2]or'有50%概率使对方被召回或得到25%的行军加速')

widget:SetChildButtonClick(8,function()
self:onTqttmsClick(widget)
end)
widget:SetChildButtonClick(10,function()
self:onTqtipsClick(widget)
end)
end







local lp=poslp[6]
for i,v in ipairs(btns)do
v[2]=lp[v[1]+1]
end
if not self.showAnim then
self.showAnim=true
for i,v in ipairs(btns)do
local pos=v[2]
widget:SetChildAnchoredPos(v[1],0,0)
widget:SetChildDOAnchorPos(v[1],Vector3.New(pos[1],pos[2]),0.25,nil)
end
else
for i,v in ipairs(btns)do
local pos=v[2]
widget:SetChildAnchoredPos(v[1],pos[1],pos[2])
end
end


local name=teamHandle:getOwnerName()
local enemyType=teamHandle.enemyType
local name_str=xianjieModel.getColorStrByEnemyType(enemyType,name)
widget:SetChildText(7,name_str)

self:refreshTime(widget)

self:refreshPJXJBtn(widget,teamHandle)
end



function xjEntityHud_clickTeam.onChangeXianGuanJob()
if not _this then return end
local widget=_this:getWidget()
widget:SetChildActive(8,false)
end

function xjEntityHud_clickTeam.onTeQuanInfoChange(tqData)
if not _this then return end
if tqData.tqid==XIANGUAN_PRIVILEGE_POJIEZHUTIAN then
xianguanModel:set_PZXJ_march_guid(_this.thismarchguid)
local widget=_this:getWidget()
widget:SetChildCanvasGroupAlpha(14,0)
local ent=xianjieController:getEntity(_this.m_key)
if ent then
local teamHandle=ent:getTeamHandle()
_this:refreshPJXJBtn(widget,teamHandle)
end
end
end

function xjEntityHud_clickTeam:onPZXJTeQuanHide()
local widget=self:getWidget()
if widget then
widget:SetChildCanvasGroupAlpha(14,0)
end
end

function xjEntityHud_clickTeam:refreshTime(widget)
local ent=xianjieController:getEntity(self.m_key)
local teamHandle=ent:getTeamHandle()
local lerpTime=teamHandle:geLerpTime()
lerpTime=math.ceil(lerpTime)
local time_str=timeHelper.format_time_stamp(lerpTime,true)
widget:SetChildText(6,time_str)
end

function xjEntityHud_clickTeam:refreshMHbtnTime(widget)
if self._istqShow then
local cd=xianguanModel.ttms_YJZZ_Cd()
if cd>0 then
local time_str=string.format("<color=#f36666>下次使用:%s</color>",timeHelper.format_time_stamp(cd,true))
widget:SetChildText(12,time_str)
widget:SetChildActive(15,false)
else
self._istqShow=false
widget:SetChildText(12,'')
local istqShow,xgid=xianguanModel.isTTMS_tequan()
if xgid then
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
local maxTimes=xianguanConfig.getTeQuanCfg(tqid,"times")or 0
local usedTimes=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getTimes")or 0
if usedTimes>=maxTimes then
widget:SetChildText(9,string.format("今天：<color=#f36666>%d/%d</color>",maxTimes-usedTimes,maxTimes))
widget:SetChildActive(15,false)
else
widget:SetChildText(9,string.format("今天：<color=#aae252>%d/%d</color>",maxTimes-usedTimes,maxTimes))
widget:SetChildActive(15,true)
end

end
end
end
end

function xjEntityHud_clickTeam:refreshPJXJBtn(widget,teamHandle)
local istqShow=false
local xgid=false
if teamHandle then
istqShow,xgid=xianguanModel.isPZXJTequan()

if not(teamHandle.enemyType==xjEnemyType.eSelf or teamHandle.enemyType==xjEnemyType.eAllies)then
istqShow=false
end
if teamHandle.teamType==xjTeamHandleType.eMarchBack then
istqShow=false
end
end





widget:SetChildActive(13,istqShow)
local childWidget=widget:GetChildWidgetBase(13)
if istqShow then
UIManager:invokeUIMethod("UIXianJieFuncStorageWin","hideFuncList")
local tqid=XIANGUAN_PRIVILEGE_POJIEZHUTIAN
local str=''
local cd=xianguanModel.get_PZXJ_Cd()
if cd>0 then
self._isPJXJtqShow=true
else
self._isPJXJtqShow=false
local maxTimes=xianguanConfig.getTeQuanCfg(tqid,"times")or 0
local usedTimes=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getTimes")or 0
if usedTimes>=maxTimes then
str=string.format("本周：<color=#f36666>%d/%d</color>",maxTimes-usedTimes,maxTimes)
else
str=string.format("本周：<color=#aae252>%d/%d</color>",maxTimes-usedTimes,maxTimes)
end
end

childWidget:SetChildText(0,str)

self.showtqtip=false
childWidget:SetChildActive(3,self.showtqtip==true)
if self.showtqtip==true then
childWidget:SetChildCanvasGroupDOFade(3,1,0.5,nil)
else
childWidget:SetChildCanvasGroupAlpha(3,0)
end
local tipspanelwdg=childWidget:GetChildWidgetBase(3)
local jobCfg=xianguanConfig.getJobConfig(nil,xgid)
local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
tipspanelwdg:SetChildCSImageSprite(0,_ab,jobIconName)
local tqname=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'name')
tipspanelwdg:SetChildText(1,tqname)

local tipsCfg=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'tipsDesc')or{}
local effectArgs=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'effectArgs')or defaultT

tipspanelwdg:SetChildText(4,tipsCfg[1]or'仙官【逐界仙君】特权')
tipspanelwdg:SetChildText(5,tipsCfg[2]or FMT.fmt('可让一个友方行军在<color=#549327>{0}秒后</color>达到目的地',effectArgs[1]))

widget:SetChildButtonClick(13,function()
self:onTqPoJieClick(childWidget)
end)
childWidget:SetChildButtonClick(2,function()
self:onTqpjTipsClick(childWidget)
end)
end
end


function xjEntityHud_clickTeam:refreshPJXJbtnTime(widget)
if self._isPJXJtqShow then
if not widget then return end
local cd=xianguanModel.get_PZXJ_Cd()
if cd>0 then
local childWidget=widget:GetChildWidgetBase(13)
local time_str=string.format("<color=#f36666>下次使用:%s</color>",timeHelper.format_time_stamp(cd,true))
childWidget:SetChildText(0,time_str)
else
self._isPJXJtqShow=false
local childWidget=widget:GetChildWidgetBase(13)
childWidget:SetChildText(0,'')
local istqShow,xgid=xianguanModel.isPZXJTequan()
if xgid then
local tqid=XIANGUAN_PRIVILEGE_POJIEZHUTIAN
local maxTimes=xianguanConfig.getTeQuanCfg(tqid,"times")or 0
local usedTimes=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getTimes")or 0
if usedTimes>=maxTimes then
childWidget:SetChildText(0,string.format("本周：<color=#f36666>%d/%d</color>",maxTimes-usedTimes,maxTimes))
else
childWidget:SetChildText(0,string.format("本周：<color=#f36666>%d/%d</color>",maxTimes-usedTimes,maxTimes))
end
childWidget:SetChildText(0,'')
end
end
end
end


function xjEntityHud_clickTeam:onRemoveWidget(widget)

xianjieController:removeFollowTarget()

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)
notifySystem:removelistener(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
notifySystem:removelistener(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)
_this=nil
end


function xjEntityHud_clickTeam:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshTime(widget)
self:refreshMHbtnTime(widget)
self:refreshPJXJbtnTime(widget)
end
end

function xjEntityHud_clickTeam:onBeginClick()
if not self:checkWidget()then return end
local clickEntKey=self.m_key

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)

local sceneidx,spos=xianjieController:invokeEntityFunc(clickEntKey,'getTeamPosStart')
if xianjieModel:checkSceneIndex(sceneidx)then
xianjieController:lookAtPosition(spos,nil,0.2,nil,DG.Tweening.Ease.Linear)
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local func=function()
xianjieController:lookAtPosition(spos,nil,0.2,nil,DG.Tweening.Ease.Linear)
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end

function xjEntityHud_clickTeam:onDetailClick()
if not self:checkWidget()then return end

if not self:checkWidget()then return end
local clickEntKey=self.m_key
local teamHandle=xianjieController:invokeEntityFunc(clickEntKey,'getTeamHandle')
local isHasDetail=teamHandle:checkDetail(true)
if not isHasDetail then
return
end

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)
if teamHandle then
teamHandle:onDetailShow()
end
end

function xjEntityHud_clickTeam:onSpeedUpClick()
if not self:checkWidget()then return end
local clickEntKey=self.m_key
local teamHandle=xianjieController:invokeEntityFunc(clickEntKey,'getTeamHandle')
local isCanSpeedUp=teamHandle:checkSpeeUp(true)
if not isCanSpeedUp then
return
end

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)
if teamHandle then
local onlyKey=teamHandle.onlykey
UIManager:invokeUIMethod("UIXianJieMainWin","openSpeedUpWinByOnlyKey",onlyKey)
end
end

function xjEntityHud_clickTeam:onCallBackClick()
if not self:checkWidget()then return end
local clickEntKey=self.m_key
local teamHandle=xianjieController:invokeEntityFunc(clickEntKey,'getTeamHandle')
if teamHandle then
local flag=teamHandle:doRetract()
if flag then

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)
end
end
end

function xjEntityHud_clickTeam:onEmoClick()
if not self:checkWidget()then return end


xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)
UIManager.error('敬请期待')
end

function xjEntityHud_clickTeam:onEndClick()
if not self:checkWidget()then return end
local clickEntKey=self.m_key

xianjieModel:leaveSceneState(xjSceneStateType.eClickTeam)

local sceneidx,epos=xianjieController:invokeEntityFunc(clickEntKey,'getTeamPosEnd')
if xianjieModel:checkSceneIndex(sceneidx)then
xianjieController:lookAtPosition(epos,nil,0.2,nil,DG.Tweening.Ease.Linear)
else
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx)
local func=function()
xianjieController:lookAtPosition(epos,nil,0.2,nil,DG.Tweening.Ease.Linear)
end
xianjieController:jumpXianJie(sceneType,nil,func)
end
end


function xjEntityHud_clickTeam:onTqttmsClick(widget)
if not self:checkWidget()then return end
if self.showtqtip==true then
self.showtqtip=not self.showtqtip
widget:SetChildActive(11,self.showtqtip==true)
widget:SetChildCanvasGroupAlpha(11,0)
end
local isWSBX,xgid=xianguanModel.isTTMS_tequan()
if isWSBX then
local cd=xianguanModel.ttms_YJZZ_Cd()
if cd>0 then
UIManager.info(FMT.fmt("迷惑冷却中:{0}",timeHelper.format_time_stamp12(cd)))
else
local marchguid=self.thismarchguid
local _fun=function()
xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)
if marchguid then
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
xianguanModel.useTTMS_YJZZ_tequan(xgid,tqid,marchguid)
else
UIManager.info("行军已经结束")
end
end
local showdata=
{
type='UIDialouge',
title='提示',
content='密使是否使用以假作真特权<color=#CA631D>迷惑</color>对方？\n有50%几率令其<color=#CA631D>减速50%</color>。',
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
else
UIManager.info("以假作真特权已过期")
end
end


function xjEntityHud_clickTeam:onTqtipsClick(widget)
if not self:checkWidget()then return end
self.showtqtip=not self.showtqtip
widget:SetChildActive(11,self.showtqtip==true)
if self.showtqtip==true then
widget:SetChildCanvasGroupDOFade(11,1,0.5,nil)
else
widget:SetChildCanvasGroupAlpha(11,0)
end
end


function xjEntityHud_clickTeam:onTqPoJieClick(widget)
if not self:checkWidget()then return end
if self.showtqpojietip==true then
self.showtqpojietip=not self.showtqpojietip
widget:SetChildActive(3,self.showtqpojietip==true)
widget:SetChildCanvasGroupAlpha(3,0)
end
local isWSBX,xgid=xianguanModel.isPZXJTequan()
if isWSBX then
local cd=xianguanModel.get_PZXJ_Cd()
if cd>0 then
UIManager.info(FMT.fmt("{0}后使用",timeHelper.format_time_stamp12(cd)))
else
local tqid=XIANGUAN_PRIVILEGE_POJIEZHUTIAN

local privilegeKey=xianguanConfig.getTeQuanFindKey(xgid,tqid)
local privilegeObj=xianguanModel:getSelfTequanObj(privilegeKey)
if privilegeObj then
if not privilegeObj:checkUseCondition()then
return
end
else
return
end


local name=xianguanConfig.getTeQuanCfg(tqid,"name")or 0
local marchguid=self.thismarchguid
local _fun=function()

local clickEntKey=self.m_key
local teamHandle=xianjieController:invokeEntityFunc(clickEntKey,'getTeamHandle')
local isOut30=false
if teamHandle then
local lerpTime,wayTime=teamHandle:geLerpTime()
isOut30=wayTime>30
end

if isOut30 then


if marchguid then
local json_str=jsonHelper.encode({9,marchguid})
xianguanController.sendUsePrivilege(xgid,tqid,json_str)





else
UIManager.info("行军已经结束")
end
else
UIManager.error("行军到达目的地时间少于30秒，使用失败！")
end
end

local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianJieSpeedUp4)
if check then
_fun()
else
local effectArgs=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'effectArgs')or defaultT
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('使用后队伍将在{1}秒后到达目的地，是否使用{0}特权?',name,effectArgs[1]),
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianJieSpeedUp4,flag)
end,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

end
else
UIManager.info("以假作真特权已过期")
end
end



function xjEntityHud_clickTeam:onTqpjTipsClick(widget)
if not self:checkWidget()then return end
self.showtqpojietip=not self.showtqpojietip
widget:SetChildActive(3,self.showtqpojietip==true)
if self.showtqpojietip==true then
widget:SetChildCanvasGroupDOFade(3,1,0.5,nil)
else
widget:SetChildCanvasGroupAlpha(3,0)
end
end


function xjEntityHud_clickTeam:onDelete()

end

return xjEntityHud_clickTeam
