reconnectConfig={}

local _CloseUICheck=
{
{
ignoreCheck=function()
return storyAIManager:isPlayingStory()
end,
},
{
ignoreCheck=function()
return worldStoryAIManager:isPlayingStory()
end
}

}


local _ignoreReconnectWindow=
{
['UIHUDWin']=true,
['UIXianJieHudWin']=true,
}

function reconnectConfig.needCloseUI()
for i,v in ipairs(_CloseUICheck)do
if v.ignoreCheck()then
return false
end
end
return true
end

function reconnectConfig.ignoreNotFresh(name)
return _ignoreReconnectWindow[name]==true
end