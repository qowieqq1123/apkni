














local markOpenXWL=nil

function xianmengController:setMarkOpenXWL(flag)
markOpenXWL=flag
end

function xianmengController:onAppStart_xianwulou()
socketManager:register_receiver(20,100,xianmengController.do_protocol_20_100)
socketManager:register_receiver(20,101,xianmengController.do_protocol_20_101)
socketManager:register_receiver(20,102,xianmengController.do_protocol_20_102)
socketManager:register_receiver(20,103,xianmengController.do_protocol_20_103)
socketManager:register_receiver(20,104,xianmengController.do_protocol_20_104)
socketManager:register_receiver(20,130,xianmengController.do_protocol_20_130)
end

function xianmengController:onEnterState_xianwulou()
xianmengModel:initData_xianwulou()

end

function xianmengController:onLeaveState_xianwulou()
xianmengModel:clearData_xianwulou()
xianmengController:setMarkOpenXWL(nil)

end

function xianmengController:onProtocolReq_xianwulou(isReconnet)
if xianmengModel:hasXM()then
xianmengController:initXWL()
end
end

function xianmengController:initXWL()
local bdData=xianmengController:getXianWuLouBuild()
if bdData then
if not xianmengModel:checkXWLInit()then
xianmengController:reqXWLInfo()
end
end
end







function xianmengController:openXWLNotes()
xianmengController:reqXWRewardNotes()
end

function xianmengController:openXianWuLouWin(tabType,args)
tabType=tabType or FULL_TAB_TYPE.eXianWuLou
if xianmengModel:checkXWLInit()then
UIFullXianMengXianWuLouControl:showMyWindow(tabType,args)
else
xianmengController:reqXWLInfo()
xianmengController:setMarkOpenXWL(tabType)
end
end

function xianmengController:getXianWuLouBuild()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianWuLou)
return bdDatas[1]
end

function xianmengController:refreshXianWuLouHud()
local bdData=xianmengController:getXianWuLouBuild()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end




function xianmengController:reqXWLInfo()
socketManager:send_20_100()
end


function xianmengController:reqXWLSubmit(tjItemConfId,cnt,assistant)


socketManager:send_20_101(tjItemConfId,cnt or 1,assistant or 0)
end


function xianmengController:reqXWLReward(lunshuId,assistant)


socketManager:send_20_102(lunshuId,assistant or 0)
end


function xianmengController:reqXWRewardNotes()
socketManager:send_20_103()
end


function xianmengController:reqXWLSubmit2(tjId,cnt,assistant)


socketManager:send_20_130(tjId,cnt or 1,assistant or 0)
end






function xianmengController.do_protocol_20_100(args)














local data={}
data.lunshuId=args[1]
data.taskId=args[2]
data.boxId=args[3]
data.tjListLen=args[4]
data.tjList=args[5]
data.tjNum=args[6]
data.tjNumTime=gameUtilityModel.getServerLongTime()
data.jinduVal=args[7]
data.lunshuId2=args[8]
data.boxId2=args[9]
data.tjList2=args[11]or{}
local serverTime=args[12]
if serverTime~=nil then
serverTime=gameUtilityModel.serverShortTimeToLong(serverTime)
else
serverTime=gameUtilityModel.getServerLongTime()
end
data.initTime=serverTime
xianmengModel:initXWLData(data)

if markOpenXWL~=nil then
xianmengController:setMarkOpenXWL(nil)
xianmengController:openXianWuLouWin(markOpenXWL)
else
UIManager:callWindowFunc('UIXMXianWuLouWin','rec_lun')
end

xianmengController:refreshXianWuLouHud()

reddotControl.on_change_catch_type(CATCH_TYPE.eXianWuLouProgressChange)
notifySystem:postNotify(notifyConfig.onXianWuLouInit)
end


function xianmengController.do_protocol_20_101(tjItemConfId,cnt,assistant)



local data=xianmengModel:getXWLData()
if data==nil then return end

local num=xianmengModel:getXWL_tjNum()
num=num-cnt
if num<0 then num=0 end
data.tjNum=num
data.tjNumTime=gameUtilityModel.getServerLongTime()


UIManager:callWindowFunc('UIXMXianWuLouWin','rec_submit')
notifySystem:postNotify(notifyConfig.onXianWuLouSubmit,tjItemConfId,cnt,assistant)
end


function xianmengController.do_protocol_20_130(tjId,cnt,assistant)

xianmengController.do_protocol_20_101(tjId,cnt,assistant)
end


function xianmengController.do_protocol_20_102(lunshuId,lunshuId2,boxId2,assistant)





local data=xianmengModel:getXWLData()
if data==nil then return end

data.lunshuId2=lunshuId2
data.boxId2=boxId2

UIManager:callWindowFunc('UIXMXianWuLouWin','rec_boxReward')
xianmengController:refreshXianWuLouHud()
reddotControl.on_change_catch_type(CATCH_TYPE.eXianWuLouRewardChange)
notifySystem:postNotify(notifyConfig.onXianWuLouReward,assistant)
end


function xianmengController.do_protocol_20_103(recordLen,recordList)






xianmengModel:initXWLNotes(recordList or{})

if UIManager:isActive('UIXMXianWuLouNoteWin')then
UIManager:invokeUIMethod('UIXMXianWuLouNoteWin','refreshView')
else
UIManager:showWindow('UIXMXianWuLouNoteWin')
end

reddotControl.on_change_catch_type(CATCH_TYPE.eXianWuLouRewardChange)
end


function xianmengController.do_protocol_20_104(lunshuId,jinduVal,lunshuId2,boxId2)





local data=xianmengModel:getXWLData()
if data==nil then return end

local old_lunshuId=data.lunshuId
local old_lunshuId2=data.lunshuId2
data.lunshuId=lunshuId
data.jinduVal=jinduVal
data.lunshuId2=lunshuId2
data.boxId2=boxId2
local hasTask=xianmengModel:checkXWLHasTask()
if old_lunshuId~=lunshuId or not hasTask then
UIManager:callWindowFunc('UIXMXianWuLouWin','rec_lun')
else
UIManager:callWindowFunc('UIXMXianWuLouWin','rec_progress')
if old_lunshuId2~=lunshuId2 then
UIManager:callWindowFunc('UIXMXianWuLouWin','rec_boxReward')
end
end

xianmengController:refreshXianWuLouHud()

reddotControl.on_change_catch_type(CATCH_TYPE.eXianWuLouProgressChange)
end

