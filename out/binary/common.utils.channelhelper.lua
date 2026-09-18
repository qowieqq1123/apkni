channelHelper={}
local _appConfig_GetInt=CS.AppDataModel.AppConfig_GetInt


local _CustomLogoCfg=
{
[7382]=
{
_xllogoBundle='ui/windows/login/sharedtextures/image_taptaplogo_2.ab',
_xllogoAsset='image_taptaplogo_2'
},
[9061]=
{
_xllogoBundle='ui/windows/login/sharedtextures/image_minigamelogo_1.ab',
_xllogoAsset='image_minigamelogo_1'
},
[9067]=
{
_xllogoBundle='ui/windows/login/sharedtextures/image_minigamelogo_1.ab',
_xllogoAsset='image_minigamelogo_1'
},
}

local _channelType=
{
eXianLing=7382,
}


function channelHelper.getGameId()
return gameInfo:getGameId()
end

function channelHelper.isXianLing()
return channelHelper.getGameId()==_channelType.eXianLing
end


function channelHelper.getCustomLogoCfg()
local pfid=channelHelper.getGameId()
if pfid then
pfid=tonumber(pfid)
return _CustomLogoCfg[pfid]
end
end