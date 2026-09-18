






local xgTeQuanInfo_YiTianYiRi={name="xgTeQuanInfo_YiTianYiRi"}

function xgTeQuanInfo_YiTianYiRi:onInit()
end

function xgTeQuanInfo_YiTianYiRi:onDelete()

end

function xgTeQuanInfo_YiTianYiRi:onUpdate()

end

function xgTeQuanInfo_YiTianYiRi:onClickUseBtn(callback)
local zmData=xianjieModel:getZongMenOutPos()

local goFunc=function()
local useJumpArgs=self:getConfig("useJump")
self:jumpUseWinEx(useJumpArgs,callback)
end

local dialougeFunc=function()
local sceneName=xianjieController:getCrossServerNamebySCidx(zmData[1])
local content=FMT.fmt("神将是否前往{0}迁移宗门堡垒",sceneName)
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
goFunc()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

if zmData~=nil then
if mainControl:isSceneType(eSceneType.eXianJie)then
if xianjieModel:checkSceneIndex(zmData[1])then
goFunc()
else
dialougeFunc()
end
else
dialougeFunc()
end
end
end

return xgTeQuanInfo_YiTianYiRi