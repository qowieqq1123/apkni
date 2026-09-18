






local _MODULENAME="TeZhiTuJianController"

gameState.addListener(def_table(_MODULENAME))
TeZhiTuJianController.name=_MODULENAME
TeZhiTuJianController.data={}

function TeZhiTuJianController:onAppStart()

TeZhiTuJianModel:onAppStart()
socketManager:register_receiver(2,148,self.recv_2_148)
socketManager:register_receiver(2,149,self.recv_2_149)
socketManager:register_receiver(2,150,self.recv_2_150)
socketManager:register_receiver(2,151,self.recv_2_151)
end


function TeZhiTuJianController:onEnterState(isReconnect)
TeZhiTuJianModel:onEnterState()


notifySystem:listenNotify(notifyConfig.onDiscipleSpecialityChange,self.onDiscipleSpecialityChange)
notifySystem:listenNotify(notifyConfig.onDiscipleLingGenVary,self.onDiscipleLingGenVary)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.onTeZhiTujianReddotChange,self.freshReddot)
end


function TeZhiTuJianController:onProtocolReq()
TeZhiTuJianModel:onProtocolReq()
end


function TeZhiTuJianController:onLeaveState(isReconnect)
TeZhiTuJianModel:onLeaveState(isReconnect)

self.data={}


notifySystem:removelistener(notifyConfig.onDiscipleSpecialityChange,self.onDiscipleSpecialityChange)
notifySystem:removelistener(notifyConfig.onDiscipleLingGenVary,self.onDiscipleLingGenVary)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.onTeZhiTujianReddotChange,self.freshReddot)
end


function TeZhiTuJianController:onLostConnection()

end


function TeZhiTuJianController:onReConnection(isInitPro)

end


function TeZhiTuJianController.onDiscipleSpecialityChange(dis_guid,specialitytype,specialityid,updatetype)


if updatetype==0 then return end

local list={}
local speId=specialityid
local type=addSpeType.item
local bookId=TeZhiTuJianModel:getbookIdBySpeTypo(specialitytype,speId)
local state=TeZhiTuJianModel:getBookIdActiveState(bookId)
if state==0 then
local temp={type,dis_guid,specialitytype,speId}
table.insert(list,temp)
end

if specialitytype==7 then
for i=specialityid,1,-1 do
local speId=i
local bookId=TeZhiTuJianModel:getbookIdBySpeTypo(specialitytype,speId)
local state=TeZhiTuJianModel:getBookIdActiveState(bookId)

if state==0 then
local temp={type,dis_guid,specialitytype,speId}
table.insert(list,temp)
end
end
end

if next(list)then
local len=#list
TeZhiTuJianController.req_2_149(len,list)
end
end



function TeZhiTuJianController.onDiscipleLingGenVary(dz_guid,linggen_id,vary)
if vary==1 then
local type=addSpeType.item
local speId=linggen_id+5
local bookId=TeZhiTuJianModel:getbookIdBySpeTypo(type,speId)
local state=TeZhiTuJianModel:getBookIdActiveState(bookId)
if state==0 then
local list={}
local temp={type,dz_guid,type,speId}
table.insert(list,temp)

local len=#list
TeZhiTuJianController.req_2_149(len,list)
end
end
end


function TeZhiTuJianController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eSpecialityBook then
local allDatas=UIDiscipleModel:getAllDiscipleData()
local len=1
local type=addSpeType.item
for k,v in pairs(allDatas)do
local guid=v.netData.net.discipleguid
local datas=v.netData.net
TeZhiTuJianModel:checkIsHaveSpeCanActive(datas,type,len,nil,guid,true)
end
end
end




function TeZhiTuJianController.req_2_149(len,list)
socketManager:send_2_149(len,list)
end



function TeZhiTuJianController.req_2_151(bookId)
socketManager:send_2_151(bookId)
end


function TeZhiTuJianController.req_2_150()
socketManager:send_2_150()
end







function TeZhiTuJianController.recv_2_148(book_list_len,book_list,target_idx)
local data={}
data.book_list={}
data.target_idx=target_idx
if book_list_len>0 then
for i,v in ipairs(book_list)do
local bookId=v.param_1
local state=v.param_2
data.book_list[bookId]=state
TeZhiTuJianModel:setBookIdActiveState(bookId,state)
end
end
TeZhiTuJianModel:setData(data)
TeZhiTuJianModel:refreshLookup()
reddotControl.on_change_catch_type(CATCH_TYPE.eTeZhiTuJian)
notifySystem:postNotify(notifyConfig.onTeZhiTujianReddotChange)
end




function TeZhiTuJianController.recv_2_149(book_id_list_len,book_id_list)
local data=TeZhiTuJianModel:getData()
if not data.book_list then
data.book_list={}
end

if book_id_list_len>0 then
for i,v in ipairs(book_id_list)do
data.book_list[v]=1
TeZhiTuJianModel:setBookIdActiveState(v,1)
end

TeZhiTuJianModel:initConfig()
TeZhiTuJianModel:refreshLookup()
reddotControl.on_change_catch_type(CATCH_TYPE.eTeZhiTuJian)
notifySystem:postNotify(notifyConfig.onTeZhiTujianReddotChange)
end
end



function TeZhiTuJianController.recv_2_150(target_idx)
local data=TeZhiTuJianModel:getData()
data.target_idx=target_idx
TeZhiTuJianModel:refreshLookup()
UIManager:invokeUIMethod("UITeZhiTuJianMainWin","refreshJifenEnter")
UIManager:invokeUIMethod("UITeZhiJiFenWin","refreshList")
reddotControl.on_change_catch_type(CATCH_TYPE.eTeZhiTuJian)
notifySystem:postNotify(notifyConfig.onTeZhiTujianReddotChange)
end



function TeZhiTuJianController.recv_2_151(book_id_list_len,book_id_list)
if book_id_list_len<=0 then
return
end
local data=TeZhiTuJianModel:getData()
if not data.book_list then
data.book_list={}
end
for i,v in ipairs(book_id_list)do
data.book_list[v]=2
end
TeZhiTuJianModel:refreshLookup()
UIManager:invokeUIMethod("UITeZhiTuJianMainWin","recv_2_151")
reddotControl.on_change_catch_type(CATCH_TYPE.eTeZhiTuJian)
notifySystem:postNotify(notifyConfig.onTeZhiTujianReddotChange)
end




function TeZhiTuJianController:checkSysOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eSpecialityBook)
end

function TeZhiTuJianController:checkSysRedddot()
if not TeZhiTuJianController:checkSysOpen()then
return false
end



return TeZhiTuJianModel:checkChildReddot()or TeZhiTuJianModel:checkStageProReddot()
end

function TeZhiTuJianController:checkSysRedddot2()
if not TeZhiTuJianController:checkSysOpen()then
return false
end



return TeZhiTuJianModel:checkChildReddot()or TeZhiTuJianModel:checkStageProReddot()or TeZhiTuJianModel:checkSpecialityLoveReddot()
end

function TeZhiTuJianController.freshReddot()
local bdData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eYinXianTai)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end


end

function TeZhiTuJianController:test(flag)
self.flag=flag
reddotControl.on_change_catch_type(CATCH_TYPE.eTeZhiTuJian)
notifySystem:postNotify(notifyConfig.onTeZhiTujianReddotChange)
end

function TeZhiTuJianController.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eTeZhiTuJianReward then
for k,v in ipairs(prizelist)do
local param1=v.itemid
local param2=v.num
local iconName=iconHelper.getIconName(param1)
UIManager.rewardInfo(iconName,FMT.fmt('X{0}',param2))
end
end
end