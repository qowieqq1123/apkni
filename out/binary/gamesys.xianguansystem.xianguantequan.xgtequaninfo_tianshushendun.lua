






local xgTeQuanInfo_TianShuShenDun={name="xgTeQuanInfo_TianShuShenDun"}

function xgTeQuanInfo_TianShuShenDun:onInit()
end

function xgTeQuanInfo_TianShuShenDun:onDelete()

end

function xgTeQuanInfo_TianShuShenDun:onUpdate()

end

function xgTeQuanInfo_TianShuShenDun:onClickUseBtn(callback)
local zmData=xianjieModel:getZongMenOutPos()

local goFunc=function()
local useJumpArgs=self:getConfig("useJump")
self:jumpUseWinEx(useJumpArgs,callback)
end

local dialougeFunc=function()
local content="祖师是否前往仙界宗门，为自己或盟友开启<color=#ca631d>【天枢神盾】</color>？"
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

return xgTeQuanInfo_TianShuShenDun