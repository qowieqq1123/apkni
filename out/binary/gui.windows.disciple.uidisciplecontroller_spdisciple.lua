







function UIDiscipleController:onAppStart_spDisciple()
socketManager:register_receiver(2,191,UIDiscipleController.do_protocol_2_191)
socketManager:register_receiver(2,192,UIDiscipleController.do_protocol_2_192)
socketManager:register_receiver(2,193,UIDiscipleController.do_protocol_2_193)
end

function UIDiscipleController:onEnterState_spDisciple()
UIDiscipleModel:initSpDiscipleData()
end

function UIDiscipleController:onLeaveState_spDisciple()
UIDiscipleModel:clearSpDiscipleData()
end



function UIDiscipleController:reqSwitch(discipleguid,switchidx)
if UIDiscipleModel:checkIsSwitchingSPDisciple()then
return UIManager.error("弟子职业切换中，请稍后再试")
end

local lastTime=UIDiscipleModel:getSPDiscipleLastSwitchTimeStamp()
local cd=cfgHelper.get(cfg_globalconfig_get,1,"spDiscipleSwitchCd")
local nowTime=timeHelper.getServerShortTime()
if nowTime<lastTime+cd then
return UIManager.error("弟子职业切换冷却中，请稍后再试")
end


local ret=UIDiscipleModel:checkIsCanSwitch(discipleguid,true)
if not ret then
return
end

local func=function()
UIDiscipleController:setSpDiscipleTakeOffEquiplist(discipleguid)
UIDiscipleModel:setIsSwitchingSPDisciple(true)
switchidx=switchidx or 1
socketManager:send_2_191(discipleguid,switchidx)
end
local contentStr="切换职业后弟子可能会战力变化，是否切换？"
UIDialogManager.getConfirmDialog3(nil,contentStr,func)
end


function UIDiscipleController:reqSwitchDataPutOn(discipleguid,switchidx,listidx,pos,itemguid)
switchidx=switchidx or 1
socketManager:send_2_192(discipleguid,switchidx,listidx,pos,itemguid)
end


function UIDiscipleController:reqSwitchDataTakeOff(discipleguid,switchidx,listidx,pos)
switchidx=switchidx or 1
socketManager:send_2_193(discipleguid,switchidx,listidx,pos)
end




function UIDiscipleController.do_protocol_2_191(discipleguid,switchidx)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

local funcList={}
funcList[1]=function(guid,switchidx)

return UIDiscipleModel:switchSPDiscipleData(guid,switchidx)
end
funcList[2]=function(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)

UIDiscipleModel.calculationDiscipleImageBase(netData)
UIDiscipleModel:setDiscipleImageDirty(netData)
UIDiscipleModel:setDiscipleSwitchImageDirty(netData)
return true
end
funcList[3]=function(guid)

equipsModel.switchEquip(guid,switchidx)

UIDiscipleController:changeVocCheckXMEquip(guid)
return true
end
funcList[4]=function(guid)

fabaoModel.switchFabao(guid,switchidx)
return true
end
funcList[5]=function(guid)

daobingModel:switchEquip(guid,switchidx)
return true
end
funcList[6]=function(guid)

UIFuLuFangModel:switchFuBaoData(guid,switchidx)
return true
end
funcList[7]=function(guid)

ClothingModel:switchEquip(guid,switchidx)
ClothingModel:refreshSpDiscipleClothingCollectAttrs(guid)
return true
end
funcList[8]=function(guid)

vocEquipModel:switchEquip(guid,switchidx)
return true
end
funcList[9]=function(guid)

UIDiscipleController.refreshDiscipleLingGenEffect(guid)
return true
end
funcList[10]=function(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)

local attrTypes={
DISCIPLE_ATTRIBUTE_TYPE.eBase,
DISCIPLE_ATTRIBUTE_TYPE.eJob,


DISCIPLE_ATTRIBUTE_TYPE.eGongFa,



DISCIPLE_ATTRIBUTE_TYPE.eSkill,
DISCIPLE_ATTRIBUTE_TYPE.eTianMing,
DISCIPLE_ATTRIBUTE_TYPE.eTianMingCiFu,
DISCIPLE_ATTRIBUTE_TYPE.eQiZhen,
DISCIPLE_ATTRIBUTE_TYPE.eTianDaoShu,
DISCIPLE_ATTRIBUTE_TYPE.eCuiTi,
DISCIPLE_ATTRIBUTE_TYPE.eYuFu,

DISCIPLE_ATTRIBUTE_TYPE.eVaryLingGen,
DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng,

}
UIDiscipleModel:setDiscipleAttrListDirty2(netData,attrTypes,true)
return true
end
funcList[11]=function(guid)

local airDzGuid=airGameEnterModel:getSelectDisciple()
if airDzGuid and mathHelper.compareInt64(airDzGuid,guid)and airGameEnterModel:checkShowChangeInfoDialouge()then

airController:reqResetAndSaveFbProcessData()
end
return true
end
funcList[12]=function(guid)

mzbkModel:clearDiscipleMZBK(guid)
return true
end


local args={
count=#funcList,
duration=0.1,
discipleguid=discipleguid,
switchidx=switchidx,
onSeg=function(index,discipleguid,switchidx)
if funcList[index]then
local func=funcList[index]
return func(discipleguid,switchidx)
end
end,
onCheckErr=function(index,guid,switchidx)
if index==1 then
local netData=UIDiscipleModel:getDiscipleData(guid)
logErr(FMT.fmt("切换弟子数据失败 找不到弟子guid为{0} switchidx为{1}的切换数据 当前弟子数据打印:{2}",tostring(guid),switchidx,serializeHelper.serialize(netData)))
end
end
}
UIManager:showWindow("UISpDiscipleSwitchLoadingWin",args)
end


function UIDiscipleController.do_protocol_2_192(discipleguid,switchidx,listidx,pos,itemguid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

end


function UIDiscipleController.do_protocol_2_193(discipleguid,switchidx,listidx,pos)
UIDiscipleModel:takeOffSwitchSPDiscipleEquip(discipleguid,switchidx,listidx,pos)
end


function UIDiscipleController:changeVocCheckXMEquip(diziguid)
local diziguidStr=tostring(diziguid)
if equipsModel.equipsLookup[diziguidStr]==nil then equipsModel.equipsLookup[diziguidStr]={}end
local _equipsLookup=table.weakCopy(equipsModel.equipsLookup[diziguidStr][0])
local jobid=UIDiscipleModel:getDiscipleJob(diziguid)
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(diziguid)
for equipType,equip in pairs(_equipsLookup)do
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(equip.itemid)
if isxmEquip and isxmEquip>0 then
local joblist=equipsModel.getEquipXMJobList(equip.itemid)
local iscanDress=false
if joblist[jobid]and joblist[jobid]==1 then
iscanDress=true
end
if iscanDress then
local xmtype=equipsHelper.getEquipXMType(equip.itemguid)
if xmtype==EQUIP_XianMo_TYPES.eXian and xmtype~=xm_voc then
equipsModel:setTakeOffEquiplist(equip.itemguid)

equipsModel.deleteEquip(diziguid,equipType)
elseif xmtype==EQUIP_XianMo_TYPES.eMo and xmtype~=xm_voc then
equipsModel:setTakeOffEquiplist(equip.itemguid)

equipsModel.deleteEquip(diziguid,equipType)
end
end
end
end
end


function UIDiscipleController:setSpDiscipleTakeOffEquiplist(diziguid)
for equipType=1,4 do
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equip then
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(equip.itemid)
if isxmEquip and isxmEquip>0 then
equipsModel:setTakeOffEquiplist(equip.itemguid)
end
end
end
end

