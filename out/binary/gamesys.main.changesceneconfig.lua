changeSceneConfig={}

local _changeScenePreCheckType={
eInMoGongZhengDuo=1,
}

local _sceneAttachPreCheckGroup={
[eSceneType.eXianJie]={
[eSceneType.eZongmen]={
_changeScenePreCheckType.eInMoGongZhengDuo
},
[eSceneType.eWorld]={
_changeScenePreCheckType.eInMoGongZhengDuo
},
[eSceneType.eAirGame]={
_changeScenePreCheckType.eInMoGongZhengDuo
}
}
}

local _preCheckFuncs={
[_changeScenePreCheckType.eInMoGongZhengDuo]=function(args,enterCall,returnFunc,preCheckRecord)
local sceneIdx=xianjieModel:getSceneIndex()
if sceneIdx==nil then return true end

if not xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then return true end


local num=xianjieModel:getWaiPaiTeamNum()
if num>0 then
local show_data={
type='UIDialouge',
title='提示',
content="有队伍在外，无法退出活动",
oktext='确定',
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end

local yzNum=YingXianGeModel:getWithMyYZTotal()
if yzNum>0 then
local show_data={
type='UIDialouge',
title='提示',
content="存在援助自己的队伍，无法退出活动",
oktext='确定',
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end


local show_data={
type='UIDialouge',
title='提示',
content="确定要退出活动？\n<color=#c82c2c>（积分不会清除，10分钟后可再次进入）</color>",
oktext='确定',
canceltext='取消',
okcallback=function()
preCheckRecord[_changeScenePreCheckType.eInMoGongZhengDuo]=1
moGongZhengDuoActController:reqUpdateActState(0)
returnFunc(mainControl,args,enterCall,preCheckRecord)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

return false
end
}

function changeSceneConfig.changeScenePreCheck(preCheckRecord,toSceneType,args,enterCall,returnFunc)
local isSkip=args and args.isSkipChangeSceneCheck or false
if isSkip then return true end

preCheckRecord=preCheckRecord or{}

local curSceneType=mainControl:getSceneType()
local checkGroup=_sceneAttachPreCheckGroup[curSceneType]
if checkGroup==nil then return true end
local attachCheckList=checkGroup[toSceneType]
if attachCheckList==nil or next(attachCheckList)==nil then return true end

local result=true
for index,checkType in ipairs(attachCheckList)do
local record=preCheckRecord[checkType]or 0
if record~=1 then
local checkFunc=_preCheckFuncs[checkType]
if checkFunc then
local sResult=checkFunc(args,enterCall,returnFunc,preCheckRecord)
result=result and sResult
if not result then
break
else
preCheckRecord[checkType]=1
end
end
end
end
return result
end