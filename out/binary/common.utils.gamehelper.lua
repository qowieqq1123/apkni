gameHelper={}

FRAME_LEVEL=
{
eDefault=-1,
eLow=30,
eMedium40=40,
eMedium=60,
eHigh=90,
}

QUALITY_LEVEL=
{
eFastest=0,
eFast=1,
eMedium=2,
eHigh=3,
eBeautiful=4,
}

function gameHelper.setFrame(level)
level=level or FRAME_LEVEL.eDefault
if not webGLHelper:isUseMGSetFrameFunc()then
LuaApplication.GetApplication().targetFrameRate=level
else
_WXInterface.SetPreferredFramesPerSecond(level)
end
end

function gameHelper.setQuality(level)
UnityEngine.QualitySettings.SetQualityLevel(level or QUALITY_LEVEL.eBeautiful)
end

function gameHelper:setFrameInLoginState()
if deviceHelper.isRunEditor()then
gameHelper.setFrame()
elseif webGLHelper:isRunMiniGame()then
gameHelper.setFrame(webGLHelper:getAllowMaxFrameRate())
else
gameHelper.setFrame(FRAME_LEVEL.eLow)
end
end