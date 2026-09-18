chatEmotControl=gameState.addListener({})

function chatEmotControl:onAppStart()

end

function chatEmotControl:onEnterState()
chatEmotModel.init()
end

function chatEmotControl:onLeaveState()
chatEmotModel.init()
end

function chatEmotControl.sendDeleteDefineEmot(array)
if array==nil or#array==0 then return end
socketManager:send_252_14(#array,array)
end

function chatEmotControl.sendTopDefineEmot(emotguid)
socketManager:send_252_15(emotguid)
end

function chatEmotControl.onInitEmot(len1,packageEmotArray,len2,defineEmotArray,len3,itemEmotArray)
chatEmotModel.initPackageEmot(len1,packageEmotArray)
chatEmotModel.initDefineEmotDesc(len2,defineEmotArray)
chatEmotModel.initItemEmotEmot(len3,itemEmotArray)
end

function chatEmotControl.onUnlockPackageEmot(info)
chatEmotModel.addUnlockPackageEmot(info)
UIManager:callWindowFunc('UIChatEmotWin','onRecvUnlockPackage')
UIManager:invokeUIMethod('UIChatWin','freshEmoReddot')


local packageId=info.param_1
local packageConfig=chatConfig.getPackageEmotConfigById(packageId)
UIManager.info(FMT.fmt("{0}成功解锁",packageConfig.name))
end

function chatEmotControl.onRecvAddDefineEmot(info)
chatEmotModel.addDefineEmotInfo(info)
chatEmotModel.sortDefineEmot()
UIManager:callWindowFunc('UIChatEmotWin','onRecvDefineAdd',info)
UIManager.info('保存成功')
UIManager:closeWindow('UIChatDefineEmotDetailEditorPanel')
UIManager:closeWindow('UIChatDefineEmotEditorPanel')
end

function chatEmotControl.onRecvDeleteDefineEmot(len,array)
chatEmotModel.deleteDefineEmot(len,array)
UIManager:callWindowFunc('UIChatEmotWin','onRecvDefineChanged')
UIManager.info('删除成功')
end

function chatEmotControl.onRecvTopDefineEmot(emotguid)
chatEmotModel.topDefineEmot(emotguid)
UIManager:callWindowFunc('UIChatEmotWin','onRecvDefineChanged')
UIManager.info('置顶成功')
end


function chatEmotControl.getActivePackageEmot()
local temp={}

local leftSortTemp={}
local rightSortTemp={}
local configs=cfg_chatemotinfoconfig()

local fillTableFunc=function(obj)
if obj.fixedPos>0 then
leftSortTemp[obj.fixedPos]=obj
elseif obj.fixedPos<0 then
table.insert(rightSortTemp,obj)
else
table.insert(leftSortTemp,obj)
end
end


for _,v in pairs(configs)do
if chatEmotControl.checkShowPlatform(v)then
if v.type==1 then
fillTableFunc(v)
elseif v.type==2 then
if not chatConfig.getCommonConfig().lockdefine then
fillTableFunc(v)
end
elseif v.type==3 then
if chatEmotModel.isUnlockPackageEmot(v.idx)or v.show then
fillTableFunc(v)
else
if v.hideActive then
local emotCfg=chatConfig.getPackageEmotConfigById(v.idx)
local unlockItemId=emotCfg.unlockitem
if itemsModel.checkItemEnough(unlockItemId,1)then
fillTableFunc(v)
end
end
end
elseif v.type==4 then
if v.show or chatEmotModel.reddotUnLockItemPackageEmot(v.idx)or chatEmotModel.isShowItemEmotPackage(v.idx)then
fillTableFunc(v)
end
end
end
end

for k,v in pairs(leftSortTemp)do
table.insert(temp,v)
end

for k,v in pairs(rightSortTemp)do
table.insert(temp,v)
end

return temp
end

function chatEmotControl.checkShowPlatform(cfg)
if cfg.platformFliterShow then
local pfId=loginModel:getPfid()or 0
return table.findValue(cfg.platformFliterShow,pfId)~=nil
end
return true
end

function chatEmotControl.isUnlockPackage(cfg)
if cfg.type==1 then
return true
elseif cfg.type==2 then
return chatConfig.getCommonConfig().lockdefine
elseif cfg.type==3 then
return chatEmotModel.isUnlockPackageEmot(cfg.idx)
elseif cfg.type==4 then
return cfg.show
end
end

