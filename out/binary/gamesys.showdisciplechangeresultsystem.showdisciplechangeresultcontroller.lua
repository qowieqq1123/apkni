






local _MODULENAME="showDiscipleChangeResultController"




gameState.addListener(def_table(_MODULENAME))
showDiscipleChangeResultController.name=_MODULENAME


showDiscipleChangeResultController.data={}

local eShowDiscipleSource={
battleFight=1,
useItem=2,
}


function showDiscipleChangeResultController:onAppStart()

showDiscipleChangeResultModel:onAppStart()


socketManager:register_receiver(2,18,self.onDiscipleChangeInsertStart)
socketManager:register_receiver(2,19,self.onDiscipleChangeInsertEnd)


notifySystem:listenNotify(notifyConfig.onDiscipleGongFaLevelUp,self.onDiscipleGongFaLevelUp)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:listenNotify(notifyConfig.onDiscipleShouYuanChange,self.onDiscipleShouYuanChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
notifySystem:listenNotify(notifyConfig.onDiscipleSpecialityChange,self.onDiscipleSpecialityChange)
notifySystem:listenNotify(notifyConfig.onDiscipleSixAttrChange,self.onDiscipleSixAttrChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJJRate,self.onDiscipleJJRate)
notifySystem:listenNotify(notifyConfig.onDiscipleJJRate2,self.onDiscipleJJRate2)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.onDiscipleLTChange,self.onDiscipleLTChange)


end


function showDiscipleChangeResultController:onEnterState()
showDiscipleChangeResultModel:onEnterState()
end


function showDiscipleChangeResultController:onServerDataInitFinish()
showDiscipleChangeResultModel:onServerDataInitFinish()
end


function showDiscipleChangeResultController:onLeaveState()
showDiscipleChangeResultModel:onLeaveState()

self.data={}
end


function showDiscipleChangeResultController:onLostConnection()

end


function showDiscipleChangeResultController.onDiscipleChangeInsertStart()
showDiscipleChangeResultModel:onInsertStart()
end

function showDiscipleChangeResultController.onDiscipleChangeInsertEnd(effectData)






showDiscipleChangeResultModel:onInsertEnd()

local effectType=effectData.effecttype

local temp=table.deepCopy(showDiscipleChangeResultModel:allData())
notifySystem:postNotify(notifyConfig.onShowDiscipleChanged,effectType,temp,effectData)
end

function showDiscipleChangeResultController.onDiscipleGongFaLevelUp(discipleguid,gongfaid,oldlv,lv)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eGongFaLvUp,{gongfaid,oldlv,lv})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eGongFaLvUp,{gongfaid,oldlv,lv})
end
end

function showDiscipleChangeResultController.onDiscipleInjuryChange(discipleguid,oldInjury,injury)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eInjuryChange,{oldInjury,injury})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eInjuryChange,{oldInjury,injury})
end
end

function showDiscipleChangeResultController.onDiscipleShouYuanChange(discipleguid,old,shouyuan)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eShouYuan,{old,shouyuan})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eShouYuan,{old,shouyuan})
end
end

function showDiscipleChangeResultController.onDiscipleJobChange(discipleguid,jobtype,oldlv,lv,oldexp,exp)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eJobExpChange,{jobtype,oldlv,lv,oldexp,exp})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eJobExpChange,{jobtype,oldlv,lv,oldexp,exp})
end
end

function showDiscipleChangeResultController.onDiscipleSpecialityChange(discipleguid,specialitytype,specialityid,updatetype)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eSpeciality,{specialitytype,specialityid,updatetype})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eSpeciality,{specialitytype,specialityid,updatetype})
end
end

function showDiscipleChangeResultController.onDiscipleSixAttrChange(discipleguid,attrid,old,cur)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eSixAttr,{attrid,old,cur})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eSixAttr,{attrid,old,cur})
end
end

function showDiscipleChangeResultController.onDiscipleJJRate(discipleguid,old,cur)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eJJRate,{old,cur})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eJJRate,{old,cur})
end
end

function showDiscipleChangeResultController.onDiscipleJJRate2(discipleguid,oldlist,curlist)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eJJRate2,{oldlist,curlist})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eJJRate2,{oldlist,curlist})
end
end

function showDiscipleChangeResultController.onDiscipleJJChange(discipleguid,old_jjlv,jingjielv,old_jjexp,jingjieexp,oldFight,newFight)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eJingJieChange,{old_jjlv,jingjielv,old_jjexp,jingjieexp})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eJingJieChange,{old_jjlv,jingjielv,old_jjexp,jingjieexp})
end
end

function showDiscipleChangeResultController.onDiscipleLTChange(discipleguid,old_lv,liantilv,old_exp,liantiexp)
if showDiscipleChangeResultModel:isState()then
showDiscipleChangeResultModel:insertData(discipleguid,eDiscipleChangeType.eLianTiChange,{old_lv,liantilv,old_exp,liantiexp})
end
if showDiscipleChangeResultModel:isStateClient()then
showDiscipleChangeResultModel:insertDataClient(discipleguid,eDiscipleChangeType.eLianTiChange,{old_lv,liantilv,old_exp,liantiexp})
end
end

















