







discipleNoteController=gameState.addListener({})

function discipleNoteController:onAppStart()
socketManager:register_receiver(12,1,discipleNoteController.do_protocol_12_1)
socketManager:register_receiver(12,2,discipleNoteController.do_protocol_12_2)
end

function discipleNoteController:onEnterState()
discipleNoteModel.InitLookup()
discipleNoteDataSet:initData()

notifySystem:listenNotify(notifyConfig.onDiscipleCreate,discipleNoteController.onDiscipleCreate)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,discipleNoteController.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.onDiscipleLTChange,discipleNoteController.onDiscipleLTChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,discipleNoteController.onDiscipleJobChange)
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,discipleNoteController.onDiscipleInjuryChange)
notifySystem:listenNotify(notifyConfig.onDiscipleShouYuanChange,discipleNoteController.onDiscipleShouYuanChange)
notifySystem:listenNotify(notifyConfig.onDiscipleSpecialityChange,discipleNoteController.onDiscipleSpecialityChange)
notifySystem:listenNotify(notifyConfig.onDiscipleNameChange,discipleNoteController.onDiscipleNameChange)
notifySystem:listenNotify(notifyConfig.onDiscipleEventCreateStrory,discipleNoteController.onDiscipleEventCreateStrory)
notifySystem:listenNotify(notifyConfig.onDiscipleLearnGongFa,discipleNoteController.onDiscipleLearnGongFa)
notifySystem:listenNotify(notifyConfig.onDisciplePosChange,discipleNoteController.onDisciplePosChange)
notifySystem:listenNotify(notifyConfig.onDiscipleMakeFaBao,discipleNoteController.onDiscipleMakeFaBao)
notifySystem:listenNotify(notifyConfig.onDiscipleMakeFuBao,discipleNoteController.onDiscipleMakeFuBao)
notifySystem:listenNotify(notifyConfig.onSystemZMExpelDiscipleHandle,discipleNoteController.onSystemZMExpelDiscipleHandle)
end

function discipleNoteController:onLeaveState()
discipleNoteModel.clear()

notifySystem:removelistener(notifyConfig.onDiscipleCreate,discipleNoteController.onDiscipleCreate)
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,discipleNoteController.onDiscipleJJChange)
notifySystem:removelistener(notifyConfig.onDiscipleLTChange,discipleNoteController.onDiscipleLTChange)
notifySystem:removelistener(notifyConfig.onDiscipleJobChange,discipleNoteController.onDiscipleJobChange)
notifySystem:removelistener(notifyConfig.onDiscipleInjuryChange,discipleNoteController.onDiscipleInjuryChange)
notifySystem:removelistener(notifyConfig.onDiscipleShouYuanChange,discipleNoteController.onDiscipleShouYuanChange)
notifySystem:removelistener(notifyConfig.onDiscipleSpecialityChange,discipleNoteController.onDiscipleSpecialityChange)
notifySystem:removelistener(notifyConfig.onDiscipleNameChange,discipleNoteController.onDiscipleNameChange)
notifySystem:removelistener(notifyConfig.onDiscipleEventCreateStrory,discipleNoteController.onDiscipleEventCreateStrory)
notifySystem:removelistener(notifyConfig.onDiscipleLearnGongFa,discipleNoteController.onDiscipleLearnGongFa)
notifySystem:removelistener(notifyConfig.onDisciplePosChange,discipleNoteController.onDisciplePosChange)
notifySystem:removelistener(notifyConfig.onDiscipleMakeFaBao,discipleNoteController.onDiscipleMakeFaBao)
notifySystem:removelistener(notifyConfig.onDiscipleMakeFuBao,discipleNoteController.onDiscipleMakeFuBao)
notifySystem:removelistener(notifyConfig.onSystemZMExpelDiscipleHandle,discipleNoteController.onSystemZMExpelDiscipleHandle)
end

function discipleNoteController:onPlayerCreate(...)
discipleNoteDataSet:initJKData()
end

function discipleNoteController:onLostConnection()

end

function discipleNoteController:onProtocolReq()
local flag=discipleNoteDataSet:initSPData()
if flag==0 then
discipleNoteController:checkAllNewDisciple()
end
end


function discipleNoteController:checkAllNewDisciple()
local alldisciple=UIDiscipleModel:getAllDiscipleData()
if alldisciple then
for k,v in pairs(alldisciple)do
local dis_guid=v.netData.net.discipleguid
if discipleNoteDataSet:checkNewDiscipleByNote(dis_guid)then
discipleNoteController.onDiscipleCreate_do(dis_guid)
end
end
end
end


function discipleNoteController.onDiscipleCreate(dis_guid)
discipleNoteController.onDiscipleCreate_do(dis_guid)
end

function discipleNoteController.onDiscipleCreate_do(dis_guid)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eRuMen
params.disguid=dis_guid
discipleNoteModel.checkNote(params)
end
end


function discipleNoteController.onDiscipleJJChange(dis_guid,oldlv,lv,oldexp,exp)
if lv>oldlv then
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
for i=oldlv+1,lv do
local params={}
params.noteType=discipleNoteType.eJingJieLevel
params.disguid=dis_guid
params.jjlv=i
discipleNoteModel.checkNote(params)
end
end
end
end




function discipleNoteController.onDiscipleLTChange(dis_guid,oldlv,lv,oldexp,exp)
if lv>oldlv then
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
for i=oldlv+1,lv do
local params={}
params.noteType=discipleNoteType.eLianTiLevel
params.disguid=dis_guid
params.ltlv=i
discipleNoteModel.checkNote(params)
end
end
end
end



function discipleNoteController.onDiscipleJobChange(dis_guid,jobtype,oldlv,lv,oldexp,exp)
if lv>oldlv then
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
for i=oldlv+1,lv do
local params={}
params.noteType=discipleNoteType.eJobLevel
params.disguid=dis_guid
params.jobid=jobtype
params.joblv=i
discipleNoteModel.checkNote(params)
end
end
end
end



function discipleNoteController.onDiscipleInjuryChange(dis_guid,old,cur)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eInjury
params.disguid=dis_guid
params.old_injury=old
params.cur_injury=cur
discipleNoteModel.checkNote(params)
end
end



function discipleNoteController.onDiscipleShouYuanChange(dis_guid,old,cur)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eShouYuan
params.disguid=dis_guid
params.old_shouyuan=old
params.cur_shouyuan=cur
discipleNoteModel.checkNote(params)
end
end



function discipleNoteController.onDiscipleSpecialityChange(dis_guid,specialitytype,specialityid,updatetype)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eSpeciality
params.disguid=dis_guid
params.specialityType=specialitytype
params.specialityID=specialityid
params.flag=updatetype
discipleNoteModel.checkNote(params)
end
end



function discipleNoteController.onDiscipleNameChange(dis_guid,old,cur)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eNameChange
params.disguid=dis_guid
params.oldName=old
params.curName=cur
discipleNoteModel.checkNote(params)
end
end




function discipleNoteController.onDiscipleEventCreateStrory(dis_guid,txt,timeStamp)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eEventInfo
params.disguid=dis_guid
params.txt=txt
params.time=timeHelper.convertShortStamp(timeStamp)
discipleNoteModel.checkNote(params)
end
end


function discipleNoteController.onDiscipleLearnGongFa(dis_guid,gfid)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eLearnGongFa
params.disguid=dis_guid
params.gfid=gfid
discipleNoteModel.checkNote(params)
end
end


function discipleNoteController.onDisciplePosChange(dis_guid,oldpost,post)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.ePostChange
params.disguid=dis_guid
params.oldpostid=oldpost
params.newpostid=post
discipleNoteModel.checkNote(params)
end
end


function discipleNoteController.onDiscipleMakeFaBao(dis_guid,itemguidList)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local params={}
params.noteType=discipleNoteType.eMakeFaBao
params.disguid=dis_guid
if itemguidList and next(itemguidList)then
for _,itemguid in ipairs(itemguidList)do
local item=bagModel.getItem(itemguid)

local itemid=item.itemid
params.fabaoid=itemid
params.fabaoname=fabaoHelper.getFabaoName(item)
discipleNoteModel.checkNote(params)
end
end
end
end


function discipleNoteController.onDiscipleMakeFuBao(dis_guid,itemguid,itemid)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local fubaocfg=itemsConfig.getConfig(itemid)
local params={}
params.noteType=discipleNoteType.eMakeFuBao
params.disguid=dis_guid
params.fubaoid=itemid
params.fubaoname=fubaocfg.name
discipleNoteModel.checkNote(params)
end
end

function discipleNoteController.onSystemZMExpelDiscipleHandle(serial,discipleguid,deal_type)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
local infoData=systemZongMenModel:getInfoData(serial)
if netData~=nil and infoData~=nil then
local params={}
params.noteType=discipleNoteType.eSystemZongMenExpelJoin
params.disguid=discipleguid
params.zmName=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
discipleNoteModel.checkNote(params)
end
end



function discipleNoteController:reqSPData(guidlistlen,guidlist,timelistlen,timelist)





socketManager:send_12_1(guidlistlen,guidlist,timelistlen,timelist)
end


function discipleNoteController:reqSPStorage(discipleguid,time,descid,intlistlen,intlist,stringlistlen,stringlist,indexlistlen,indexlist)










socketManager:send_12_2(discipleguid,time,descid,intlistlen,intlist,stringlistlen,stringlist,indexlistlen,indexlist)
end






function discipleNoteController.do_protocol_12_1(datalistlen,datalist)














if datalist~=nil then
discipleNoteDataSet:rec_SPDataList(datalist)
end
discipleNoteController:checkAllNewDisciple()
end


function discipleNoteController.do_protocol_12_2(discipleguid,time)




end

