









local xjTeamHandle={}

function xjTeamHandle:__init(teamType,data)
self.teamType=teamType
for k,v in pairs(data)do
self[k]=v
end
self:onInit()
self:refreshEnemyType(true)
self:initAreaTransferSelects()
end


function xjTeamHandle:onInit()

end


function xjTeamHandle:getTeamEnityKey()
return nil
end

function xjTeamHandle:checkIsOnMove(state,isBack)
return false
end

function xjTeamHandle:checkMyWaiPai()
return true
end

function xjTeamHandle:checkLineInScene(sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local movePath=self.getMyMovePath and self:getMyMovePath()or nil
if movePath then
for i,posData in ipairs(movePath)do
if posData.sceneidx==sceneidx then
return true
end
end
end
return false
end

function xjTeamHandle:checkTargetInScene(sceneidx)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local sceneidx_,gridX_c,gridZ_c
if self.getTargetPos then
sceneidx_,gridX_c,gridZ_c=self:getTargetPos()
end
if sceneidx_ then
return sceneidx_==sceneidx
end
return false
end


function xjTeamHandle:getTargetData()
return nil
end


function xjTeamHandle:getAtkTargetData()
if self.hasAtkTarget then
return self:getTargetData()
end
return nil
end


function xjTeamHandle:getAtkTargetParams()
local atkTargetData=self:getAtkTargetData()
local atkSize,atkOffset
if atkTargetData then
atkSize=atkTargetData:getAtkSize()
local modelset=self:getMarchTeamModelSet()
atkOffset=modelset.attackOffset
end
return atkSize,atkOffset
end


function xjTeamHandle:maskSpeeUp()
return false
end

function xjTeamHandle:checkSpeeUpOpen(isWarning)

if self:maskSpeeUp()then return false end
if not self:checkMyWaiPai()then return false end
if not self:checkIsOnMove(nil,false)then
if isWarning then
UIManager.error('当前状态无法加速')
end
return false
end
if not self:checkSpeedUpConfig()then
return false
end
return true
end

function xjTeamHandle:checkSpeedUpConfig()
local marchtype=self:getMarchtype()
if marchtype and marchtype>0 then
local conf=cfgHelper.get3(cfg_fairylandbaseconfig_get,1,"march",marchtype)
return conf and conf[3]==1 or false
end
return true
end

function xjTeamHandle:getSpeedCnt()
return 1
end


function xjTeamHandle:getSpeedMulti()
return 1
end


function xjTeamHandle:checkSpeeUp(isWarning)
if not self:checkSpeeUpOpen(isWarning)then
return false
end
return true
end


function xjTeamHandle:doSpeedUp(itemid)
return false
end


function xjTeamHandle:onSpeedUp()

end


function xjTeamHandle:getMarchtype()
return-1
end

function xjTeamHandle:getTeamType()
return self.teamType
end

function xjTeamHandle:checkTeamType(teamType)
return self.teamType==teamType
end


function xjTeamHandle:getMarchTeamModelSetID()















local teamType=self.teamType
if teamType==xjTeamHandleType.eSearchTeam or teamType==xjTeamHandleType.eMarchSpy then
return 1
elseif teamType==xjTeamHandleType.eMarchStation or teamType==xjTeamHandleType.eMarchYuanZhu
or teamType==xjTeamHandleType.eStationTeam then
return 4
elseif teamType==xjTeamHandleType.eResPointTeam or teamType==xjTeamHandleType.eResPointReract then
return 1
elseif teamType==xjTeamHandleType.eJiJieWait or teamType==xjTeamHandleType.eJiJieJoin then
return 4
elseif teamType==xjTeamHandleType.eAttackRole then
return 4
elseif teamType==xjTeamHandleType.eCarryRepair then
return 4
elseif teamType==xjTeamHandleType.eArenaZhuJun then
return 4
elseif teamType==xjTeamHandleType.eMoGongZhuJun then
return 4
elseif teamType==xjTeamHandleType.eMarchMJSLDebuffAdd then
return 13
elseif teamType==xjTeamHandleType.eMoGongBuffMarchTeam then
return 4
elseif teamType==xjTeamHandleType.eMoJingZhenJi_Origin then
return 4
elseif teamType==xjTeamHandleType.eMoJingZhenJi_Normal then
return 4
else
return 1
end
end


function xjTeamHandle:getMarchTeamModelSkinID()
local skinId=1
local sectdress=UISettingModel:getCurSettingId_Type(KUANGE_TYPE.yunzhou)
if not sectdress then
return skinId
end
local settingcfg=UISettingConfig.getCfg(KUANGE_TYPE.yunzhou,sectdress)
if settingcfg then
skinId=settingcfg.xjSkinId
end
return skinId
end

function xjTeamHandle:getMarchTeamModelSet()
local id=self:getMarchTeamModelSetID()
local skinId=self:getMarchTeamModelSkinID()or 1
id=(skinId-1)*100+id
local modelset=cfgHelper.get1(cfg_fairylandteammodelsetconfig_get,id)
return modelset
end




function xjTeamHandle:maskRetract()
return false
end

function xjTeamHandle:checkRetractOpen(isWarning)
if self:maskRetract()then return false end
if not self:checkIsCanRetract()then return false end
if not self:checkMyWaiPai()then return false end
if not self:checkIsOnMove(nil,false)then
if isWarning then
UIManager.error('当前状态无法召回')
end
return false
end
if not self:checkRetractConfig()then
return false
end
return true
end


function xjTeamHandle:checkRetract(isWarning)
if not self:checkRetractOpen(isWarning)then
return false
end
if not self:checkRetractCost(isWarning)then
return false
end
return true
end

function xjTeamHandle:checkRetractCost(isWarning)
local cost=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'recall')
for i,v in ipairs(cost)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
if isWarning then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(v[1])))
gainControl:showGainWin(v[1])
end
return false
end
end
return true
end

function xjTeamHandle:checkRetractConfig()
local marchtype=self:getMarchtype()
if marchtype and marchtype>0 then
local conf=cfgHelper.get3(cfg_fairylandbaseconfig_get,1,"march",marchtype)
return conf and conf[4]==1 or false
end
return true
end


function xjTeamHandle:doRetract()
return false
end


function xjTeamHandle:checkIsCanRetract()
return true
end



function xjTeamHandle:checkDetailOpen(isWarning)
local waiPaiData=xianjieModel:getWaiPaiData(xjWaiPiaBaseType.eMarckTeam,self.marchguid)
if self:checkMyWaiPai()and waiPaiData~=nil and waiPaiData.guidlistlen>0 then
return true
end
if isWarning then
UIManager.error('暂无详情')
end

return false
end

function xjTeamHandle:checkDetail(isWarning)
if not self:checkDetailOpen(isWarning)then
return false
end

return true
end

function xjTeamHandle:onDetailShow(canvas)
local attrType
local teamData=self.teamData
local teamSceneIdx=self.teamData and(self.teamData.sceneidx or self.teamData.tarsceneidx)or xianjienSceneIndexType.eXianJie
local teamLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(teamSceneIdx)
local nowSceneIdx=xianjieModel:getSceneIndex()
local nowLogicSceneType=xianjieController:transSceneIdxToLogicSceneType(nowSceneIdx)
if teamLogicSceneType~=nowLogicSceneType then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
return self:onDetailShow()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end

local monsterData=xianjieModel:getMonsterData(teamData.infoguid)
if monsterData then
local entityType=monsterData.entitytype
if entityType==xjServerEnityType.eMoJieMoJunYaoMo or entityType==xjServerEnityType.eMoJieMoJunFenShen then
attrType=xjBuffEffectType.eYunZhouAttrJiaChengMoJun
else
attrType=xjBuffEffectType.eEntityAttrTypeHead+entityType
end
end
xianjieController:showMarchTeamDetailWin(xjWaiPiaBaseType.eMarckTeam,self.marchguid,attrType,canvas)













































return true
end





function xjTeamHandle:refreshEnemyType(isInit)
local cur=self:checkMyEnemyType()
local old=self.enemyType
self.enemyType=cur
if not isInit and cur~=old then
self:onEnemyTypeChange()
end
end


function xjTeamHandle:checkMyEnemyType()
return xjEnemyType.eSelf
end


function xjTeamHandle:onEnemyTypeChange()




end


function xjTeamHandle:getLineColor()
local typo=self.enemyType
if typo==xjEnemyType.eSelf then
return sceneLineType.eGreenArrow
elseif typo==xjEnemyType.eAllies then
return sceneLineType.eBlueArrow
elseif typo==xjEnemyType.eEnemy then
return sceneLineType.eRedArrow
elseif typo==xjEnemyType.eStranger then
return sceneLineType.eGrayArrow
end
end

function xjTeamHandle:checkMyTeam()
return self.enemyType==xjEnemyType.eSelf
end




function xjTeamHandle:initAreaTransferSelects()
local lp
local gateList=self:getAreaTransferSelectData()
if gateList~=nil then
lp={}
for i,transferID in ipairs(gateList)do
lp[transferID]=true
end
end
self.areaTransferSelects=lp
end


function xjTeamHandle:getAreaTransferSelectData()
local teamData=self.teamData
if teamData then
return teamData.gateList
end
return nil
end


function xjTeamHandle:__delete()
self:onDelete()
end


function xjTeamHandle:onDelete()

end



local objID=0
local get_objID=function()
objID=objID+1
return objID
end
local num=50
local pool={}
local fileLookup={}
local objLookup={}

function check_xjTeamHandleLookup()
if next(objLookup)then



return false
end
return true
end

function clear_xjTeamHandleLookup()
check_xjTeamHandleLookup()
objLookup={}
end

function new_xjTeamHandle(teamType,data)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={




__index=xjTeamHandle,
}
setmetatable(newT,mT)







end
local childname=xjTeamHandleConfig[teamType]
if childname then
local child=fileLookup[teamType]
if child==nil then
local filename=FMT.fmt('lua.gamesys.xianjie.team.{0}',childname)
child=xianjieHelper.require(filename,fileLookup,teamType)
if child==nil then



return
end
end
for k,v in pairs(child)do
newT[k]=v
end
end
local m_ID=get_objID()
newT.m_ID=m_ID
objLookup[m_ID]=newT
newT:__init(teamType,data)
return newT
end

function release_xjTeamHandle(obj)
if obj==nil then return end
local m_ID=obj.m_ID
obj:__delete()
objLookup[m_ID]=nil
local temp={}

for k,v in pairs(obj)do
temp[k]=true
end
for k,v in pairs(temp)do
obj[k]=nil
end
if#pool>=num then
return
end
table.insert(pool,obj)
end
