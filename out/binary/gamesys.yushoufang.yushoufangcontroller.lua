











local _MODULENAME="yushoufangController"




gameState.addListener(def_table(_MODULENAME))
yushoufangController.name=_MODULENAME


yushoufangController.data={}

local _this=yushoufangController


function yushoufangController:onAppStart()

yushoufangModel:onAppStart()
socketManager:register_receiver(3,222,self.recv_3_222)
socketManager:register_receiver(3,223,self.recv_3_223)
socketManager:register_receiver(3,224,self.recv_3_224)

socketManager:register_receiver(3,226,self.recv_3_226)
socketManager:register_receiver(3,227,self.recv_3_227)

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.onLingShouStateChange,self.onLingShouStateChange)
end


function yushoufangController:onEnterState()
yushoufangModel:onEnterState()
end


function yushoufangController:onServerDataInitFinish()
yushoufangModel:onServerDataInitFinish()
end


function yushoufangController:onLeaveState()
yushoufangModel:onLeaveState()

self.data={}
end


function yushoufangController:onLostConnection()

end

function yushoufangController:onReConnection()
end

function yushoufangController.on_home_event(etype)
end



function yushoufangController:send_3_224(un_build_id,len,list,item_id)
socketManager:send_3_224(un_build_id,len,list,item_id)
end

function yushoufangController:send_3_226(un_build_id)
socketManager:send_3_226(un_build_id)
end

function yushoufangController:send_3_227()
local temp=yushoufangModel:getOneKeysLSRewardsList()
socketManager:send_3_227(#temp,temp)
end



function yushoufangController.recv_3_222(petBornData)
yushoufangModel:setYSFBuildSingleData(petBornData)
end

function yushoufangController.recv_3_223(len,petBornDatas)
yushoufangModel:setYSFBuildData(len,petBornDatas)
if len>0 and petBornDatas then
for k,v in ipairs(petBornDatas)do
yushoufangModel.freshBuildingHUD(v.sf_id,v.un_build_id)
end
end
end

function yushoufangController.recv_3_224(un_build_id,len,list,item_id)
yushoufangModel:setYSFFangYanData(un_build_id,len,list,item_id)
UIManager:invokeUIMethod("UILingShouYSFJiaoPeiWin","freshsever_FanYan")
yushoufangModel.freshBuildingHUD(mapIdType.lingshoudao,un_build_id)
end

function yushoufangController.recv_3_226(un_build_id,soothe_time,group_end_time)
yushoufangModel:freshYSFFuMoTime(un_build_id,soothe_time,group_end_time)
UIManager:invokeUIMethod("UILingShouYSFJiaoPeiWin","freshsever_FuMo")
yushoufangModel.freshBuildingHUD(mapIdType.lingshoudao,un_build_id)
local win=UIManager:findActiveWindow('UILingShouYSFJiaoPeiWin')
if not win then
UIManager.info("成功减少繁育时长")
end
end

function yushoufangController.recv_3_227(len,lsguidList)
if len>0 and lsguidList then
local oldlist={}
oldlist.lsindex=1
oldlist.lslist={}
local buildlist={}
for k,v in ipairs(lsguidList)do
buildlist[v.param_2]=true
end
for un_build_id,v in pairs(buildlist)do
local data=yushoufangModel:getLSDataByBuildID(un_build_id)
if data then
local nowTime=timeHelper.getServerShortTime()
local group_end_time=data.group_end_time
if group_end_time>0 and group_end_time<nowTime then
local new_data=yushoufangModel:getLSNewDataByBuildID(un_build_id)
for k,new_lsdata in ipairs(new_data)do
if new_lsdata.word_len and new_lsdata.word_len>0 and new_lsdata.wordList then
new_lsdata.wordList=table.deepCopy(new_lsdata.wordList)
end
new_lsdata.guid_str=tostring(new_lsdata.guid)
oldlist.lslist[#oldlist.lslist+1]=new_lsdata
lingshouModel:applyLingShouAllWord(new_lsdata)
end
end
end
end
yushoufangController:onShowLingShouInfoWin(oldlist)

yushoufangModel:setYSFRewards(len,lsguidList)
yushoufangModel:clearLSChooseData()
UIManager:invokeUIMethod("UILingShouYSFJiaoPeiWin","freshsever_LingQu")
UIManager.info('已领取')
for un_build_id,v in pairs(buildlist)do
yushoufangModel.freshBuildingHUD(mapIdType.lingshoudao,un_build_id)
end
end
end

























function yushoufangController:onShowLingShouInfoWin(args,parent)
if parent then
parent:showWindow('UILingShouYSFInfoWin',args)
else
UIManager:showWindow('UILingShouYSFInfoWin',args)
end
end

