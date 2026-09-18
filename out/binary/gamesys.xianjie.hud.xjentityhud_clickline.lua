









local xjEntityHud_clickLine={}
local poslp={
{-118,63},{-118,-70},{118,-70},{118,63},
}
local _ab=globalABLookup.xianguan
local _this

function xjEntityHud_clickLine:onInit()
self.needFollow=true
local data=self.data
self.clickEntKey=data[1]
self.showtqtip=false
self._istqShow=false
end


function xjEntityHud_clickLine:onCreateWidget(widget)
_this=self
notifySystem:listenNotify(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
local btns={}

widget:SetChildButtonClick(0,function()
self:onBeginClick()
end)
btns[#btns+1]={0}

local sceneidx=xianjieModel:getSceneIndex()
local openPlane=not xianjienSceneIndexType:isOhterXianYu(sceneidx)
widget:SetChildActive(1,openPlane)
if openPlane then
widget:SetChildButtonClick(1,function()
self:onPlaneClick()
end)
btns[#btns+1]={1}
end

widget:SetChildButtonClick(2,function()
self:onPosClick()
end)
btns[#btns+1]={2}

widget:SetChildButtonClick(3,function()
self:onEndClick()
end)
btns[#btns+1]={3}


local istqShow=false
local xgid=false
local teamHandle=xianjieController:invokeEntityFunc(self.clickEntKey,'getTeamHandle')
if teamHandle then
self.thismarchguid=teamHandle.marchguid
istqShow,xgid=xianguanModel.isTTMS_tequan()
if teamHandle.enemyType==xjEnemyType.eSelf or teamHandle.enemyType==xjEnemyType.eAllies then
istqShow=false
end
if teamHandle.teamType==xjTeamHandleType.eMarchBack then
istqShow=false
end
end

widget:SetChildActive(5,istqShow)
if istqShow then
UIManager:invokeUIMethod("UIXianJieFuncStorageWin","hideFuncList")
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
local str=''
local cd=xianguanModel.ttms_YJZZ_Cd()
if cd>0 then
self._istqShow=true
widget:SetChildActive(10,false)
else
self._istqShow=false
local maxTimes=xianguanConfig.getTeQuanCfg(tqid,"times")or 0
local usedTimes=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getTimes")or 0
if usedTimes>=maxTimes then
str=string.format("今天：<color=#f36666>%d/%d</color>",maxTimes-usedTimes,maxTimes)
widget:SetChildActive(10,false)
else
str=string.format("今天：<color=#aae252>%d/%d</color>",maxTimes-usedTimes,maxTimes)
widget:SetChildActive(10,true)
end
end

widget:SetChildText(6,str)

self.showtqtip=false
widget:SetChildActive(8,self.showtqtip==true)
if self.showtqtip==true then
widget:SetChildCanvasGroupDOFade(8,1,0.5,nil)
else
widget:SetChildCanvasGroupAlpha(8,0)
end
local tipspanelwdg=widget:GetChildWidgetBase(8)
local jobCfg=xianguanConfig.getJobConfig(nil,xgid)
local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
tipspanelwdg:SetChildCSImageSprite(0,_ab,jobIconName)
local tqname=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'name')
tipspanelwdg:SetChildText(1,tqname)

local tipsCfg=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'tipsDesc')
tipspanelwdg:SetChildText(4,tipsCfg[1]or'每周可迷惑敌对仙域祖师10次')
tipspanelwdg:SetChildText(5,tipsCfg[2]or'有50%概率使对方被召回或得到25%的行军加速')

widget:SetChildButtonClick(5,function()
self:onTqttmsClick(widget)
end)
widget:SetChildButtonClick(7,function()
self:onTqtipsClick(widget)
end)
end

for i,v in ipairs(btns)do
v[2]=poslp[v[1]+1]
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

self:refreshPJXJBtn(widget)
end

function xjEntityHud_clickLine:refreshPJXJBtn(widget)
local clickEntKey=self.clickEntKey
local teamHandle=xianjieController:invokeEntityFunc(clickEntKey,'getTeamHandle')
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

widget:SetChildActive(4,istqShow)
local childWidget=widget:GetChildWidgetBase(4)
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

widget:SetChildButtonClick(4,function()
self:onTqPoJieClick(childWidget)
end)
childWidget:SetChildButtonClick(2,function()
self:onTqpjTipsClick(childWidget)
end)
end
end


function xjEntityHud_clickLine:refreshMHbtnTime(widget)
if self._istqShow then
local cd=xianguanModel.ttms_YJZZ_Cd()
if cd>0 then
local time_str=string.format("<color=#f36666>下次使用:%s</color>",timeHelper.format_time_stamp(cd,true))
widget:SetChildText(9,time_str)
widget:SetChildActive(10,false)
else
self._istqShow=false
widget:SetChildText(9,'')
local istqShow,xgid=xianguanModel.isTTMS_tequan()
if xgid then
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
local maxTimes=xianguanConfig.getTeQuanCfg(tqid,"times")or 0
local usedTimes=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getTimes")or 0
if usedTimes>=maxTimes then
widget:SetChildText(6,string.format("今天：<color=#f36666>%d/%d</color>",maxTimes-usedTimes,maxTimes))
widget:SetChildActive(10,false)
else
widget:SetChildText(6,string.format("今天：<color=#aae252>%d/%d</color>",maxTimes-usedTimes,maxTimes))
widget:SetChildActive(10,true)
end

end
end
end
end


function xjEntityHud_clickLine:refreshPJXJbtnTime(widget)
if self._isPJXJtqShow then
if not widget then return end
local cd=xianguanModel.get_PZXJ_Cd()
if cd>0 then
local childWidget=widget:GetChildWidgetBase(4)
local time_str=string.format("<color=#f36666>下次使用:%s</color>",timeHelper.format_time_stamp(cd,true))
childWidget:SetChildText(0,time_str)
else
self._isPJXJtqShow=false
local childWidget=widget:GetChildWidgetBase(4)
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


function xjEntityHud_clickLine:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshMHbtnTime(widget)
self:refreshPJXJbtnTime(widget)
end
end



function xjEntityHud_clickLine:onRemoveWidget(widget)
notifySystem:removelistener(notifyConfig.onChangeXianGuanJob,self.onChangeXianGuanJob)
_this=nil
end

function xjEntityHud_clickLine:onBeginClick()
if not self:checkWidget()then return end
local clickEntKey=self.clickEntKey

xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)

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

function xjEntityHud_clickLine:onPlaneClick()
if not self:checkWidget()then return end
local data=self.data
local cpos=data[4]

xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)

local gridX,gridZ=xianjieController:worldPos2WorldGridPos(cpos.x,cpos.z)
xianjieController:onClickEmptyPos(nil,gridX,gridZ)
end

function xjEntityHud_clickLine:onPosClick()
if not self:checkWidget()then return end
local clickEntKey=self.clickEntKey

xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)

xianjieModel:enterSceneState_clickTeam_before(clickEntKey)
end

function xjEntityHud_clickLine:onEndClick()
if not self:checkWidget()then return end
local clickEntKey=self.clickEntKey

xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)

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

function xjEntityHud_clickLine.onChangeXianGuanJob()
if not _this then return end
local widget=_this:getWidget()
widget:SetChildActive(5,false)
end

function xjEntityHud_clickLine:onTqttmsClick(widget)
if not self:checkWidget()then return end
if self.showtqtip==true then
self.showtqtip=not self.showtqtip
widget:SetChildActive(8,self.showtqtip==true)
widget:SetChildCanvasGroupAlpha(8,0)
end
local isWSBX,xgid=xianguanModel.isTTMS_tequan()
if isWSBX then
local cd=xianguanModel.ttms_YJZZ_Cd()
if cd>0 then
UIManager.info(FMT.fmt("迷惑冷却中:{0}",timeHelper.format_time_stamp12(cd)))
else
local marchguid=self.thismarchguid
local clickEntKey=self.clickEntKey
local _fun=function()

if marchguid then
local sceneidx,epos=xianjieController:invokeEntityFunc(clickEntKey,'getTeamPosStart')
if xianjieModel:checkSceneIndex(sceneidx)then
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
xianguanModel.useTTMS_YJZZ_tequan(xgid,tqid,marchguid)
_this:onPosClick()
else
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
xianguanModel.useTTMS_YJZZ_tequan(xgid,tqid,marchguid)
_this:onPosClick()
end
else
UIManager.info("行军已经结束")
end
end
local showdata=
{
type='UIDialouge',
title='提示',
content='已经选中该玩家的行军线\n密使是否对其进行<color=#CA631D>迷惑</color>？\n有50%几率令其<color=#CA631D>减速50%</color>。',
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


function xjEntityHud_clickLine:onTqtipsClick(widget)
if not self:checkWidget()then return end
self.showtqtip=not self.showtqtip
widget:SetChildActive(8,self.showtqtip==true)
if self.showtqtip==true then
widget:SetChildCanvasGroupDOFade(8,1,0.5,nil)
else
widget:SetChildCanvasGroupAlpha(8,0)
end
end


function xjEntityHud_clickLine:onTqPoJieClick(widget)
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
local _fun=function()

local clickEntKey=self.clickEntKey
local teamHandle=xianjieController:invokeEntityFunc(clickEntKey,'getTeamHandle')
local isOut30=false
if teamHandle then
local lerpTime,wayTime=teamHandle:geLerpTime()
isOut30=wayTime>30
end

if isOut30 then
if teamHandle.marchguid then
local sceneidx,epos=xianjieController:invokeEntityFunc(clickEntKey,'getTeamPosStart')

if xianjieModel:checkSceneIndex(sceneidx)then
local json_str=jsonHelper.encode({9,teamHandle.marchguid})
xianguanController.sendUsePrivilege(xgid,tqid,json_str)
xianguanModel:set_PZXJ_march_guid(teamHandle.marchguid,1.5)
self:onPosClick()
else
xianguanModel:set_PZXJ_march_guid(teamHandle.marchguid,1.5)
local func=function()
local json_str=jsonHelper.encode({9,teamHandle.marchguid})
xianguanController.sendUsePrivilege(xgid,tqid,json_str)
end

xianjieModel:leaveSceneState(xjSceneStateType.eClickLine)

xianjieModel:enterSceneState_clickTeam_before(clickEntKey,func)

end

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



function xjEntityHud_clickLine:onTqpjTipsClick(widget)
if not self:checkWidget()then return end
self.showtqpojietip=not self.showtqpojietip
widget:SetChildActive(3,self.showtqpojietip==true)
if self.showtqpojietip==true then
widget:SetChildCanvasGroupDOFade(3,1,0.5,nil)
else
widget:SetChildCanvasGroupAlpha(3,0)
end
end


return xjEntityHud_clickLine