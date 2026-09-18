






local _MODULENAME="fightUpRemindController"




gameState.addListener(def_table(_MODULENAME))
fightUpRemindController.name=_MODULENAME
fightUpRemindController.data={}

local _winName='UIFightDialogueWin'
local _aniTypeLookup={}
local _canShowDzFightChangeWins={
'UIDiscipleMainWin',
'UITianDaoShuWin',
'UIDaoBingBagWin',
}

function fightUpRemindController:onAppStart()

fightUpRemindModel:onAppStart()










notifySystem:listenNotify(notifyConfig.onDiscipleFightChanged,self.onDiscipleFightChanged)
notifySystem:listenNotify(notifyConfig.onDiscipleDuJieFinish,self.onDiscipleDujieFinish)
notifySystem:listenNotify(notifyConfig.onLingShouFightChanged,self.onLingShouFightChanged)
notifySystem:listenNotify(notifyConfig.onShowUI,self.onShowUI)
local aniTypeList={
DISCIPLE_ATTRIBUTE_TYPE.eJingJie,
}
for _,v in ipairs(aniTypeList)do
_aniTypeLookup[v]=true
end
end


function fightUpRemindController:onEnterState()
fightUpRemindModel:onEnterState()

fightUpRemindController:stopUptimer()
self.stoptimer=timer.new()
self.stoptimer:start(20,function()
self.timeUnLockflag=true
fightUpRemindController:stopUptimer()
end,1)
end


function fightUpRemindController:onLeaveState()
fightUpRemindModel:onLeaveState()

self.data={}
self.timeUnLockflag=nil
fightUpRemindController:stopUptimer()
end


function fightUpRemindController:onLostConnection()

end

function fightUpRemindController.onZongmenFightChanged(oldVal,newVal)
if not fightUpRemindController:enoughOpen()then return end
if oldVal==0 or oldVal==nil or newVal==nil or newVal<=oldVal then return end
fightUpRemindModel:setZongmenFightVal(oldVal,newVal)
UIManager:showWindow(_winName)
end

function fightUpRemindController.onZongmenTop15FightChanged(oldVal,newVal)
if oldVal==0 or oldVal==nil or newVal==nil or newVal<=oldVal then return end
fightUpRemindModel:setZongmenTop15FightVal(oldVal,newVal)
local activeMain=UIManager:isActive('UIMain')
local systemOpen=systemModel.isOpen(SYSTEM_DEFINE.eTopThreeTeams)
local isChanged=fightUpRemindModel:checkZongmenTop15FightValChanged()
if activeMain and systemOpen and isChanged then
UIManager:showWindow('UITop15FightDialogueWin')
end
end

function fightUpRemindController.onShowUI(name)
if name=='UIMain'then
local systemOpen=systemModel.isOpen(SYSTEM_DEFINE.eTopThreeTeams)
local isChanged=fightUpRemindModel:checkZongmenTop15FightValChanged()
if systemOpen and isChanged then
UIManager:showWindow('UITop15FightDialogueWin')
end
end
end

function fightUpRemindController.onDiscipleFightChanged(diziguid,oldVal,newVal,optype)

if _aniTypeLookup[optype]then
fightUpRemindController.onDiscipleFightAnimatorStart(diziguid,oldVal,newVal,optype)
return
end

for i,v in ipairs(_canShowDzFightChangeWins)do
if UIManager:isActive(v)then
fightUpRemindController:postDiZiFight(diziguid,oldVal,newVal)
break
end
end
end



function fightUpRemindController.onDiscipleDujieFinish(diziguid,ret)
local optype=DISCIPLE_ATTRIBUTE_TYPE.eJingJie
if ret then
local oldVal,newVal=fightUpRemindModel:getAniVal(diziguid,optype,true)
fightUpRemindController:postDiZiFight(diziguid,oldVal,newVal)
end
end

function fightUpRemindController.onDiscipleFightAnimatorStart(diziguid,oldVal,newVal,optype)

if oldVal==nil or newVal==nil or newVal<=oldVal then return end
fightUpRemindModel:setAniVal(diziguid,optype,oldVal,newVal)
end



function fightUpRemindController:postDiZiFight(diziguid,oldVal,newVal)
if oldVal==nil or oldVal==0 or newVal==nil or newVal<=oldVal then return end
if not fightUpRemindController:enoughOpen()then return end
local name=UIDiscipleModel:getDiscipleName(diziguid)

fightUpRemindModel:setDiziFight(diziguid,oldVal,newVal)
UIManager:showWindow(_winName)
end

function fightUpRemindController.onLingShouFightChanged(guid,oldVal,newVal)
if oldVal==nil or oldVal==0 or newVal==nil or newVal<=oldVal then return end
if not fightUpRemindController:enoughOpen()then return end
if UIManager:findActiveWindow("UIEquipWin")then return end
fightUpRemindModel:setLingShouFight(guid,oldVal,newVal)
UIManager:showWindow(_winName)
end


function fightUpRemindController.onFrdFightChanged(oldVal,newVal)
if oldVal==nil or oldVal==0 or newVal==nil or newVal<=oldVal then return end
fightUpRemindModel:setFrdFight(oldVal,newVal)
UIManager:showWindow(_winName)
end



function fightUpRemindController:stopUptimer()
if self.stoptimer then
self.stoptimer:cancel()
self.stoptimer=nil
end
end

function fightUpRemindController:enoughOpen()
local flag=self.timeUnLockflag
if not flag then return false end
local activeMain=not UIManager:isActive('UIMain')
local finishGameplot=worldController:checkNoticiateBlockOpen()
local systemZMOugoerFlag=not systemZongMenController:isOutgoerSceneDoing()

return flag and activeMain and finishGameplot and systemZMOugoerFlag
end
