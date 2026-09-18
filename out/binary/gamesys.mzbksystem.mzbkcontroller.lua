






local _MODULENAME="mzbkController"

gameState.addListener(def_table(_MODULENAME))
mzbkController.name=_MODULENAME
mzbkController.data={}

function mzbkController:onAppStart()

mzbkModel:onAppStart()

socketManager:register_receiver(2,204,self.recv_2_204)

socketManager:register_receiver(2,197,self.recv_2_197)
socketManager:register_receiver(2,198,self.recv_2_198)
socketManager:register_receiver(2,199,self.recv_2_199)
socketManager:register_receiver(2,200,self.recv_2_200)
socketManager:register_receiver(2,201,self.recv_2_201)
socketManager:register_receiver(2,203,self.recv_2_203)

end


function mzbkController:onEnterState(isReconnect)
mzbkModel:onEnterState()
end


function mzbkController:onProtocolReq()
mzbkModel:onProtocolReq()
end


function mzbkController:onLeaveState(isReconnect)
mzbkModel:onLeaveState(isReconnect)

self.data={}
end


function mzbkController:onLostConnection()

end


function mzbkController:onReConnection(isInitPro)

end



























function mzbkController.recv_2_204(tqOpen)
mzbkModel:updateActiveTeQuan(tqOpen)
end


function mzbkController.recv_2_197(dzGuid,len,mzItemList)
mzbkModel:setDiscipleMZBK(dzGuid,len,mzItemList)
end



function mzbkController.recv_2_198(dzGuid,opType,pos,len,mzInfoList)
mzbkModel:updateDiscipleMZ(dzGuid,pos,len,mzInfoList)
if opType==1 then
UIDiscipleModel:clearDiscipleRankHoardData(dzGuid)
notifySystem:postNotify(notifyConfig.onDisciplePushMCToBK,dzGuid)
elseif opType==2 then

end
end


function mzbkController.recv_2_199(dzGuid,pos,idx)
mzbkModel:popDiscipleMZ(dzGuid,pos,idx)
end


function mzbkController.recv_2_200(dzGuid,pos,len,mzInfoList)
UIDiscipleModel:clearDiscipleRankHoardData(dzGuid)
mzbkModel:updateDiscipleMZ(dzGuid,pos,len,mzInfoList)

UIDiscipleController.refreshDiscipleLingGenEffect(dzGuid)
end


function mzbkController.recv_2_201(dzGuid,pos,len,mzInfoList)
if mzbkController.infoDelete then
UIManager.info(FMT.fmt("{0}秘藏已删除",mzbkController.infoDeleteName))
mzbkController.infoDelete=false
mzbkController.infoDeleteName=nil
end

mzbkModel:updateDiscipleMZ(dzGuid,pos,len,mzInfoList)
end


function mzbkController.recv_2_203(dzGuid,pos,idx,len,mzInfoList)
local netData=UIDiscipleModel:getDiscipleData(dzGuid)
if netData==nil then
logErr("弟子数据缺失")
return
end

local bkInfo=mzbkModel:getDiscipleMZBKInfoByPos(tostring(dzGuid),pos)
local mzInfo=bkInfo.mzList[idx]
if mzInfo==nil then
logErr("秘藏宝库中数据缺失")
return
end

local hoardList=netData.hoardList or{}
for k,v in pairs(hoardList)do
if v.pos==pos then
v.activeList={[1]=mzInfo}
break
end
end

netData.hoardList=hoardList

mzbkModel:updateDiscipleMZ(dzGuid,pos,len,mzInfoList)

UIDiscipleModel:clearDiscipleRankHoardData(dzGuid)

UIDiscipleController.refreshDiscipleLingGenEffect(dzGuid)
end




function mzbkController.req_disciple_mzbk_list(dzGuid)
socketManager:send_2_197(dzGuid)
end



function mzbkController.req_disciple_push_mz(dzGuid,opType,pos,idx)
socketManager:send_2_198(dzGuid,opType,pos,idx)
end


function mzbkController.req_disciple_pop_mz(dzGuid,pos,idx)
socketManager:send_2_199(dzGuid,pos,idx)
end




function mzbkController.req_disciple_replace_mz(dzGuid,pos,idx,idx2)
socketManager:send_2_200(dzGuid,pos,idx,idx2)
end


function mzbkController.req_disciple_delete_mz(dzGuid,pos,idx,name)
mzbkController.infoDelete=name~=nil
mzbkController.infoDeleteName=name
socketManager:send_2_201(dzGuid,pos,idx)
end


function mzbkController.req_disciple_switching_mz(dzGuid,pos,idx)
socketManager:send_2_203(dzGuid,pos,idx)
end

function mzbkController.check_req_disciple_mzbk_list(dzGuid)
local mzbk=mzbkModel:getDiscipleMZBK(tostring(dzGuid))
if mzbk==nil then
mzbkController.req_disciple_mzbk_list(dzGuid)
end
end



function mzbkController.checkDiscipleMCPosSaveFull(dzGuid,pos)
local curCount=mzbkModel:getDiscipleMZBKPosSaveCount(tostring(dzGuid),pos)
local maxCount=mzbkModel:getMZBKPosMaxSaveCount(pos)
return curCount>=maxCount
end

function mzbkController.checkMutexGroupMC(dzGuid,pos,idx)
local randlist,randpos,randlistlen=UIDiscipleModel:getDiscipleRandomHoard(dzGuid)
local mcData=randlist[idx]

local dzMZBKInfoList=mzbkModel:getDiscipleMZBK(tostring(dzGuid))

if dzMZBKInfoList==nil then return false end

local hoardid=mcData.hoardid

for cpos,dzMZBKInfo in pairs(dzMZBKInfoList)do
if dzMZBKInfo.len>0 then
for index,mcbkinfo in pairs(dzMZBKInfo.mzList)do
local groupA=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,mcbkinfo.hoardid,'group')
local groupB=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,hoardid,'group')
if groupA==groupB then
return true,cpos,index,mcbkinfo,mcData
end
end
end
end

return false
end


local _saveConditionResultEnum={
eComfireSave=1,
eGiveUpOther=2,
eMutexOtherSlot=3,
eMutexMCBK=4,
}


local function createConfirmDialog(title,content,dzGuid,cwin,pos,idx,resultList,resultKey,remindType)
local show_data={
type='UIDialouge',
title=title,
content=content,
showclosebtn=true,
oktext='确定',
okcallback=function()
resultList[resultKey]=1
mzbkController.checkSaveRankMC(dzGuid,cwin,pos,idx,resultList)
end,
cancelcallback=function()end,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,remindType,flag)
end,
}
return UIDialogManager.newDialog(show_data)
end


local function checkStorageFull(dzGuid,pos)
local isFull=mzbkController.checkDiscipleMCPosSaveFull(dzGuid,pos)
if isFull then
UIManager.info("当前秘藏宝库已装不下啦，还请祖师先清理")
return true
end
return false
end


local function handleMutexGroupCheck(dzGuid,cwin,pos,idx,resultList)
if resultList[_saveConditionResultEnum.eMutexMCBK]==nil then
local isMutex,dpos,mcIndex,destData,sourceData=mzbkController.checkMutexGroupMC(dzGuid,pos,idx)
if isMutex then
local posName=UIDiscipleModel:getPosSlotName_linggen(dpos)
local tip=FMT.fmt('已存储同类秘藏，是否替换{0}栏的秘藏？',posName)
cwin:showWindow('UIDiscipleLinggen_MCBKChangeHoardWin',{
disciple_guid=dzGuid,
sourceData=sourceData,
destData=destData,
replaceIdx=mcIndex,
pos=pos,
dpos=dpos,
randIdx=idx,
tip=tip,
okCallBack=function()
mzbkController.req_disciple_replace_mz(dzGuid,dpos,mcIndex,idx)
end,
})
return true
else
resultList[_saveConditionResultEnum.eMutexMCBK]=1
end
end
return false
end


local function handleOtherSlotMutex(dzGuid,cwin,pos,idx,resultList)
if resultList[_saveConditionResultEnum.eMutexOtherSlot]==nil then
local otherSlotSameGroupResult,sameSlotData,rankData=UIDiscipleModel:checkRankBoardMutexOtherSlot(dzGuid,idx)
if otherSlotSameGroupResult then
if UIDiscipleModel:checkHiddenSkillSlotUnlock(dzGuid,sameSlotData.pos)then
cwin:showWindow('UIDiscipleLinggen_ChangeSelectHoardWin',{
disciple_guid=dzGuid,
sourceData=rankData,
destData=sameSlotData,
idx=idx,
})
else
local show_data={
type='UIDialouge',
title='提示',
content="被锁的秘藏栏中有相同的秘藏，是否放弃被锁秘藏？",
oktext='确定',
canceltext='取消',
okcallback=function()
UIDiscipleController:do_send_2_136(dzGuid,pos,idx,sameSlotData.pos)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
return true
else
resultList[_saveConditionResultEnum.eMutexOtherSlot]=1
end
end
return false
end

local function handleGiveUpOtherRank(dzGuid,cwin,pos,idx,resultList)
if resultList[_saveConditionResultEnum.eGiveUpOther]==nil then
local pushRuleTipsVis=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMCBK_Push_Rule_Tips)
if pushRuleTipsVis~=true then
local randlist,randpos,randlistlen=UIDiscipleModel:getDiscipleRandomHoard(dzGuid)
local boardData=randlist[idx]
local cfg=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,boardData.hoardid)
local name=toColorString(cfg.color,cfg.name)

local oidx=idx==1 and 2 or 1
local oboardData=randlist[oidx]
local ocfg=cfgHelper.get2(cfg_disciplespiritroothoardconfig_get,oboardData.hoardid)
local oname=toColorString(ocfg.color,ocfg.name)

local dialog=createConfirmDialog(
'提示',
FMT.fmt("选择秘藏{0}存入宝库，即会放弃{1}",name,oname),
dzGuid,cwin,pos,idx,resultList,
_saveConditionResultEnum.eGiveUpOther,
REPEAT_TYPE.eMCBK_Push_Rule_Tips
)
dialog:show()
return true
end
end
return false
end

local function handleChangeMZBKSlot(dzGuid,cwin,pos,idx,didx,resultList)

local dzGuidStr=tostring(dzGuid)

local randlist,randpos,randlistlen=UIDiscipleModel:getDiscipleRandomHoard(dzGuid)
local sourceData=randlist[idx]

local mzbkInfo=mzbkModel:getDiscipleMZBKInfoByPos(dzGuidStr,pos)
local mzbklist=mzbkInfo.mzList
local destData=mzbklist[didx]


cwin:showWindow('UIDiscipleLinggen_MCBKChangeHoardWin',{
disciple_guid=dzGuid,
sourceData=sourceData,
destData=destData,
replaceIdx=didx,
pos=pos,
dpos=pos,
randIdx=idx,
tip="是否替换当前秘藏宝库中的秘藏",
okCallBack=function()
mzbkController.req_disciple_delete_mz(dzGuid,pos,didx)
mzbkController.req_disciple_push_mz(dzGuid,1,pos,idx)
end,
})
return true
end

function mzbkController.checkSaveRankMC(dzGuid,cwin,pos,idx,resultList)


resultList=resultList or{}


if handleOtherSlotMutex(dzGuid,cwin,pos,idx,resultList)then return end


if handleMutexGroupCheck(dzGuid,cwin,pos,idx,resultList)then return end

local limitLen=mzbkModel:getMZBKPosMaxSaveCount(pos)
if limitLen==1 then
if mzbkController.checkDiscipleMCPosSaveFull(dzGuid,pos)then
if handleGiveUpOtherRank(dzGuid,cwin,pos,idx,resultList)then return end
if handleChangeMZBKSlot(dzGuid,cwin,pos,idx,1,resultList)then return end
end
else

if checkStorageFull(dzGuid,pos)then return end
end





















if handleGiveUpOtherRank(dzGuid,cwin,pos,idx,resultList)then return end


mzbkController.req_disciple_push_mz(dzGuid,1,pos,idx)
end

function mzbkController.checkMutexGroupEquipRankMC(dzGuid,cwin,pos,idx,resultList)
resultList=resultList or{}

if handleMutexGroupCheck(dzGuid,cwin,pos,idx,resultList)then return false end
return true
end

function mzbkController.checkSwitchMC(dzGuid,spos,idx)
local listm,rpos,len=UIDiscipleModel:getDiscipleRandomHoard(dzGuid)

local func=function()
mzbkController.req_disciple_switching_mz(dzGuid,spos,idx)
end

if len<=0 then
func()
return
end

local posName=rpos>0 and FMT.fmt("{0}号",rpos)or"变异"

local content=FMT.fmt("{0}秘藏栏有秘藏尚未选择，是否放弃秘藏？",posName)
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function()
func()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
