
UIFullXJForceControl=gameState.addListener(fullScreenUI.create())

local _winName={
[xianjieForceType.eXianGong]="UIXianGongMainWin",
[xianjieForceType.eYuJing]="UIYuJingMainWin",
[xianjieForceType.ePengLai]="UIPengLaiMainWin",
[xianjieForceType.eJiuYuan]="UIJiuYuanMainWin",
}

function UIFullXJForceControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eXianGong,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullXJForceControl:showXianGongMainWindow(argstable)





local viewName='UIXianGongMainWin'
local args=
{
showBg=true,
showTopMask=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end


function UIFullXJForceControl:showYuJingMainWindow(argstable)

local viewName='UIYuJingMainWin'
local args=
{
showBg=true,
showTopMask=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end

function UIFullXJForceControl:showPengLaiMainWindow(argstable)

local viewName='UIPengLaiMainWin'
local args=
{
showBg=true,
showTopMask=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end

function UIFullXJForceControl:showJiuYuanMainWindow(argstable)

local viewName='UIJiuYuanMainWin'
local args=
{
showBg=true,
showTopMask=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end

function UIFullXJForceControl:showJingXuanMainWindow(campaignType)
if campaignType==XianGuanCampaignType.eWuXuan then
local segment=xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eNone then
UIManager.error("不在活动时间内")
return
elseif segment==XianGuanWuXuanSegment.eBlank then
UIManager.error("等待下个活动阶段到来")
return
end
if segment==XianGuanWuXuanSegment.eRegister then
UIFullXJForceControl:showWindow("UIXianGuanCampaignMainWin",{campaignType=XianGuanCampaignType.eWuXuan})
return
end

local job=xianguanModel:getWuXuanPlayerJob()
job=(job~=nil and job>0)and job or nil
UIFullXJForceControl:showJingXuanWindow(XianGuanCampaignType.eWuXuan,job)
elseif campaignType==XianGuanCampaignType.eWenXuan then
local segment=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()











if segment==XianGuanWenXuanSegment.eRegister then
UIFullXJForceControl:showWindow("UIXianGuanCampaignMainWin",{campaignType=XianGuanCampaignType.eWenXuan})
return
end

local job=xianguanModel:getWenXuanPlayerJob()
job=(job~=nil and job>0)and job or nil
UIFullXJForceControl:showJingXuanWindow(XianGuanCampaignType.eWenXuan,job)
end
end

function UIFullXJForceControl:jumpJingXuanMainWindow(campaignType,jobId)
if campaignType==XianGuanCampaignType.eWuXuan then
local segment=xianguanController:getActivitySegment_Enter_WuXuan_Compatible()
if segment==XianGuanWuXuanSegment.eNone then
UIManager.error("不在活动时间内")
return
elseif segment==XianGuanWuXuanSegment.eBlank then
UIManager.error("等待下个活动阶段到来")
return
end
if segment==XianGuanWuXuanSegment.eRegister then
local args=
{
showBg=true,
showTopMask=true,
viewNames={"UIXianGuanCampaignMainWin","UIXianGuanMainWin","UIXianGongMainWin"},
viewArgs={
["UIXianGuanCampaignMainWin"]={campaignType=XianGuanCampaignType.eWuXuan},
["UIXianGuanMainWin"]={},
["UIXianGongMainWin"]={},
},
}
self:showUI(args)
return
end

local job=jobId or xianguanModel:getWuXuanPlayerJob()
job=(job~=nil and job>0)and job or nil
local args=
{
showBg=true,
showTopMask=true,
viewNames={"UIXianGuanJingXuanJobListWin","UIXianGuanMainWin","UIXianGongMainWin"},
viewArgs={
["UIXianGuanJingXuanJobListWin"]={campaignType=XianGuanCampaignType.eWuXuan,jobId=job},
["UIXianGuanMainWin"]={},
["UIXianGongMainWin"]={},
},
}
self:showUI(args)
elseif campaignType==XianGuanCampaignType.eWenXuan then
local segment=xianguanController:getActivitySegment_Enter_WenXuan_Compatible()










if segment==XianGuanWenXuanSegment.eRegister then
local args=
{
showBg=true,
showTopMask=true,
viewNames={"UIXianGuanCampaignMainWin","UIXianGuanMainWin","UIXianGongMainWin"},
viewArgs={
["UIXianGuanCampaignMainWin"]={campaignType=XianGuanCampaignType.eWenXuan},
["UIXianGuanMainWin"]={},
["UIXianGongMainWin"]={},
},
}
self:showUI(args)
return
end

local job=jobId or xianguanModel:getWenXuanPlayerJob()
job=(job~=nil and job>0)and job or nil
local args=
{
showBg=true,
showTopMask=true,
viewNames={"UIXianGuanCampaignRegisterWin","UIXianGuanMainWin","UIXianGongMainWin"},
viewArgs={
["UIXianGuanCampaignRegisterWin"]={campaignType=XianGuanCampaignType.eWenXuan,jobId=job},
["UIXianGuanMainWin"]={},
["UIXianGongMainWin"]={},
},
}
self:showUI(args)
end
end

function UIFullXJForceControl:showJingXuanWindow(campaignType,job,callback)
if campaignType==XianGuanCampaignType.eWuXuan then
local args={
campaignType=XianGuanCampaignType.eWuXuan,
jobId=job,
callback=callback,
}
self:showWindow("UIXianGuanJingXuanJobListWin",args)
elseif campaignType==XianGuanCampaignType.eWenXuan then
local args={
campaignType=XianGuanCampaignType.eWenXuan,
jobId=job,
callback=callback,
}
self:showWindow("UIXianGuanCampaignRegisterWin",args)
end
end

function UIFullXJForceControl:showWuXuanAttendWin(job)
local check,least=xianguanModel:checkWuXuanRegisterTime()
if not check then
if least then
UIManager.error(FMT.fmt("{0}秒后方可参选",least))
end
return
end

local args={
officerId=job,
okStr="进入布阵",
okFunc=function(declaration_idx)
local winArgs=
{
enterTxt="仙官武选",
skipDiscipleStateCheck=true,
statePriorityCheck=false,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
notNeedDealOverTime=true,
cancelCallBack=function()
UIFullXJForceControl:jumpJingXuanMainWindow(XianGuanCampaignType.eWuXuan)
end,
enterCallBack=function(guidList)
local teamList={}
local sumFightValue=0
for i,v in ipairs(guidList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
sumFightValue=sumFightValue+UIDiscipleModel:getDiscipleFightValue(v[2])
table.insert(teamList,v[2])
else
table.insert(teamList,int64.zero)
end
end
local registerCallback=function()
xianguanController:send_40_23_attend(job,declaration_idx,teamList)

UIManager:invokeUIMethod('UIFightPrepareWin','onCancelFunc')
fightController:closeSelectStage()
end
local registerList=xianguanModel:getWuXuanRegisterJobData(job)
if#registerList<32 then
registerCallback()
return
end

local sumOver=0
for i,v in ipairs(registerList)do
if sumFightValue<mathHelper.int64_to_number(v.fight)then
sumOver=sumOver+1
if sumOver>=32 then
UIDialogManager.getCommonDialog(nil,"已有32位实力高于您的祖师报名，是否继续？",registerCallback)
return
end
end

end
registerCallback()
end,
}
fightController.showPrepareWin(eFightPreSelectType.xianguanwuxuan,winArgs)
end
}
self:showWindow("UIXianGuanCampaignDescWin",args)
end

function UIFullXJForceControl:showWuXuanTeamWin(job,playerIndex)
local data=xianguanModel:getWuXuanRegisterSingleData(job,playerIndex)
local teamList={}
for i,v in pairs(data.discilpe_list)do
if v and mathHelper.validInt64(v.discipleguid)then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3_noClear(v)
UIDiscipleController.changeDiscipleData2(dzData,data.actor_id)
teamList[i]=dzData
end
end
local args={
bgType=2,
teamList=teamList,
lookType=DOUFATAI_LOOK_TYPE.eXianGuanWuXuan,
canvasIndex=8,
}
self:showWindow("UICommonLookRivalWin",args)
end

function UIFullXJForceControl:jumpXGTQ_XZDS_Win(argstable)
local args=
{
showBg=true,
showTopMask=true,
viewNames={"xgTeQuan_XZDS_mainWin","UIXianGuanMainWin","UIXianGongMainWin"},
viewArgs={
["xgTeQuan_XZDS_mainWin"]=argstable,
["UIXianGuanMainWin"]={},
["UIXianGongMainWin"]={},
},
}
self:showUI(args)
end


function UIFullXJForceControl:jumpXGTQ_XYWJ_Win(argstable)
local a,id=xianguanController:checkSelfHasJobByType(5)
local state=xianguanModel:callTeQuanObjFunc(id,14,"getState")
local b
if state==XianGuanUseConditionEnum.eChongJianXianYu then
UIManager.info("完成【重建仙域】后方可使用")
return
end
UIManager:showWindow("UIXunYouWanJieWin",argstable)
end

function UIFullXJForceControl:jumpXGTQ_XSYW_Win(argstable)
local jobflag,xgid=xianguanController:checkSelfHasJobByType(10)
local tqId=10
local state=xianguanModel:callTeQuanObjFunc(xgid,tqId,"getState")
if state==XianGuanUseConditionEnum.eChongJianXianYu then
UIManager.info("完成【重建仙域】后方可使用")
return
end
UIManager:showWindow("UIXianBanTeQuanTaskWin",{jobflag=jobflag,xgid=xgid})

end
















function UIFullXJForceControl:getForceMainWinName(id)
return _winName[id]
end