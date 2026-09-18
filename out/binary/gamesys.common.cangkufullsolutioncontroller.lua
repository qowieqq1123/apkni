







local _MODULENAME="cangkuFullSolutionController"
gameState.addListener(def_table(_MODULENAME))
cangkuFullSolutionController.name=_MODULENAME

local cangkuFullSolutionSpecialJumpFunc={
[2]=function()

local sfId=mapIdType.zhufeng
local targetBuildId=SLG_SYSTEM_TYPE.eCangKu
local bdDatas=zongmenModel:getBuildingDataByBdId(sfId,targetBuildId)
local targetBdData
for _,bdData in ipairs(bdDatas)do
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,targetBuildId,bdData.level+1)
if nextLvCfg then
local check=zongmenControl:checkCondition(nextLvCfg,false)
if check then
targetBdData=bdData
break
end
end
end
if targetBdData then
return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=targetBdData.build_id,args={un_build_id=targetBdData.un_build_id}}},nil,JUMP_BACK.eNoBack)
else
logErr("找不到可升级类型仓库 请前端检查跳转逻辑/显示逻辑")
end
end,
[3]=function()

local sfId=mapIdType.zhufeng
local targetBuildId=SLG_SYSTEM_TYPE.eLianDanFang
local bdDatas=zongmenModel:getBuildingDataByBdId(sfId,targetBuildId)
local bd_tybe_cfg=cfg_monijybuildconfig_get(targetBuildId)
local skill_id=bd_tybe_cfg.pro_skill_id
local targetBdData
for _,bdData in ipairs(bdDatas)do
if bdData.flag==0 then
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
local isTarget=false
if not targetBdData then
isTarget=true
elseif hasDZ then
local targetDz=targetBdData.dizi_id
local targetHasDZ=targetDz~=nil and tostring(targetDz)~='0'
if not targetHasDZ then
isTarget=true
else
local targetDzSkillLv=UIDiscipleModel:getDiscipleJobLevel(targetDz,skill_id)or 0
local nowDzSkillLv=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)or 0
if nowDzSkillLv>targetDzSkillLv then
isTarget=true
end
end
end

if isTarget then
targetBdData=bdData
end
end
end
if targetBdData then
return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=targetBdData.build_id,args={un_build_id=targetBdData.un_build_id}}},nil,JUMP_BACK.eNoBack)
else


jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=targetBuildId}},nil,JUMP_BACK.eNoBack)
end
end,
[4]=function()

local sfId=mapIdType.zhufeng
local targetBuildId=SLG_SYSTEM_TYPE.eFuLuFang
local bdDatas=zongmenModel:getBuildingDataByBdId(sfId,targetBuildId)
local bd_tybe_cfg=cfg_monijybuildconfig_get(targetBuildId)
local skill_id=bd_tybe_cfg.pro_skill_id
local targetBdData
for _,bdData in ipairs(bdDatas)do
if bdData.flag==0 then
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
local isTarget=false
if not targetBdData then
isTarget=true
elseif hasDZ then
local targetDz=targetBdData.dizi_id
local targetHasDZ=targetDz~=nil and tostring(targetDz)~='0'
if not targetHasDZ then
isTarget=true
else
local targetDzSkillLv=UIDiscipleModel:getDiscipleJobLevel(targetDz,skill_id)or 0
local nowDzSkillLv=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)or 0
if nowDzSkillLv>targetDzSkillLv then
isTarget=true
end
end
end

if isTarget then
targetBdData=bdData
end
end
end
if targetBdData then
return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=targetBdData.build_id,args={un_build_id=targetBdData.un_build_id}}},nil,JUMP_BACK.eNoBack)
else


jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=targetBuildId}},nil,JUMP_BACK.eNoBack)
end
end,
[7]=function()

if xianmengModel:hasXM()then

jumpManager:jump({id=JUMP_TYPE.eTianDaoShu},nil,JUMP_BACK.eNoBack)
else

jumpManager:jump({id=JUMP_TYPE.eXianMengJoin},nil,JUMP_BACK.eNoBack)
end
end,
}

function cangkuFullSolutionController:clearData()
self.cangkuFullSolutionData=nil
end

function cangkuFullSolutionController:onAppStart()

end

function cangkuFullSolutionController:onEnterState()

end

function cangkuFullSolutionController:onLeaveState()
cangkuFullSolutionController:clearData()
end

function cangkuFullSolutionController:onPlayerCreate(...)

end

function cangkuFullSolutionController:onLostConnection()

end


function cangkuFullSolutionController:checkSolutionShowCondition(solutionType)
local solutionTypeCfg=cfgHelper.get1(cfg_cangkufullsolutiontypeconfig_get,solutionType)
if not solutionTypeCfg then
return false
end
local conditionList=solutionTypeCfg.condition
if not conditionList or not next(conditionList)then

return true
end

for _,v in ipairs(conditionList)do
local conditionType=v[1]
local conditionParam=v[2]
if conditionType==1 then

local zmLevel=zongmenModel:getLevel()
local targetLevel=conditionParam
if zmLevel<targetLevel then
return false
end
elseif conditionType==2 then

local openDay=timeHelper.getServerOpenDay()
local targetDay=conditionParam
if openDay<targetDay then
return false
end
elseif conditionType==3 then

local targetSysId=conditionParam
if not systemModel.isOpen(targetSysId)then
return false
end
elseif conditionType==4 then

local sfId=mapIdType.zhufeng
local targetBuildId=conditionParam
if targetBuildId~=-1 then

local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,targetBuildId)
local needSys=bdCfg.build_system
if needSys and not systemModel.isOpen(needSys)then
return false
end

local showLevel=bdCfg.show_level
if showLevel then
local zmLevel=zongmenModel:getLevel()
if zmLevel<showLevel then
return false
end
end

local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,targetBuildId,1)
local check=zongmenControl:checkCondition(levelCfg,false)
if not check then
return false
end

local count=zongmenModel:getBuildingCount(targetBuildId,sfId)
local max=zongmenModel:getBuildingMaxNum(targetBuildId,sfId)
if count>=max then
return false
end
else

local cfgs=cfg_monijybuildconfig()
local isShowSolution=false
for _,cfg in pairs(cfgs)do
if cfg.buildTab and cfg.buildTab~=BUILD_TAB_TYPE.eOther
and cfg.buildTab~=BUILD_TAB_TYPE.eHoldJingGuan
and cfg.buildTab~=BUILD_TAB_TYPE.eJingGuan
and not cfg.cnd_show then
local needSys=cfg.build_system
local showLevel=cfg.show_level
local canShow=true
if showLevel then
local zmLevel=zongmenModel:getLevel()
if zmLevel<showLevel then
canShow=false
end
end
if canShow and(not needSys or systemModel.isOpen(needSys))then
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
local check=zongmenControl:checkCondition(levelCfg,false)
if check then
local count=zongmenModel:getBuildingCount(cfg.id,sfId)
local max=zongmenModel:getBuildingMaxNum(cfg.id,sfId)
if count<max then
isShowSolution=true
break
end
end
end
end
end
if not isShowSolution then
return false
end
end
elseif conditionType==5 then

local sfId=mapIdType.zhufeng
local targetBuildId=conditionParam
if targetBuildId~=-1 then

local bdDatas=zongmenModel:getBuildingDataByBdId(sfId,targetBuildId)
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,targetBuildId)
local needSys=bdCfg.build_system
if needSys and not systemModel.isOpen(needSys)then
return false
end
local isShowSolution=false
for _,bdData in ipairs(bdDatas)do
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,targetBuildId,bdData.level+1)
if nextLvCfg then
local check=zongmenControl:checkCondition(nextLvCfg,false)
if check then
isShowSolution=true
break
end
end
end
if not isShowSolution then
return false
end
else

local bdDatas=zongmenModel:getAllBuildingData(sfId)
local isShowSolution=false
for _,bdData in pairs(bdDatas)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local needSys=cfg.build_system
if not needSys or systemModel.isOpen(needSys)then
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if nextLvCfg then

local check=zongmenControl:checkLevelUp(nextLvCfg,false)
if check then
isShowSolution=true
break
end
end
end
end
if not isShowSolution then
return false
end
end
end
end
return true
end


function cangkuFullSolutionController:JumpToSolutionShow(solutionType)
local solutionTypeCfg=cfgHelper.get1(cfg_cangkufullsolutiontypeconfig_get,solutionType)
if not solutionTypeCfg then
return
end

local isSpecialJump=solutionTypeCfg.isSpecialJump
if isSpecialJump then
if cangkuFullSolutionSpecialJumpFunc[solutionType]then
return cangkuFullSolutionSpecialJumpFunc[solutionType]()
else
logErr(FMT.fmt("找不到途径类型为{0} 所对应的特殊跳转方法",solutionType))
end
else
local jumpParam=solutionTypeCfg.jump
if jumpParam then
jumpManager:jump(jumpParam,nil,JUMP_BACK.eNoBack)
else
logErr(FMT.fmt("找不到途径类型为{0} 所对应的跳转参数配置",solutionType))
end
end
end


function cangkuFullSolutionController:showCangKuFullSolutionByItemList(itemList,notSolutionCallback,desc)
if itemList and next(itemList)then
local notHasSolutionItemList={}
for i,v in ipairs(itemList)do
local itemId=v[1]
local itemCount=v[2]
local solutionListCfg=cfgHelper.get(cfg_cangkufullitemconfig_get,itemId)
local solutionTypeList=solutionListCfg.solutionList
local showSolutionList={}
if solutionTypeList and next(solutionTypeList)then
for _,solutionType in ipairs(solutionTypeList)do
local isShow=cangkuFullSolutionController:checkSolutionShowCondition(solutionType)
if isShow then
table.insert(showSolutionList,solutionType)
end
end

if showSolutionList and next(showSolutionList)then

return cangkuFullSolutionController:showCangKuFullSolutionWin(itemId,showSolutionList,desc)
end
end

table.insert(notHasSolutionItemList,v)
end
if notHasSolutionItemList and next(notHasSolutionItemList)then

return cangkuFullSolutionController:showCangKuFullNotHasSolutionWin(notHasSolutionItemList,notSolutionCallback)
end
end
end


function cangkuFullSolutionController:showCangKuFullSolutionWin(itemId,solutionTypeList,desc)
UIManager:showWindow("UICangKuFullSolutionWin",{itemId=itemId,solutionTypeList=solutionTypeList,desc=desc})
end


function cangkuFullSolutionController:showCangKuFullNotHasSolutionWin(itemList,notSolutionCallback)
UIManager:showWindow("UICangKuFullNotSolutionDialouge",{itemList=itemList,okCallback=notSolutionCallback})
end