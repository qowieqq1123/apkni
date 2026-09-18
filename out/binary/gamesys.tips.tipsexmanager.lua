




tipsExManager=gameState.addListener({})




function tipsExManager.showTips(argstable)

argstable=tipsExManager.handleArgs(argstable)
if argstable==nil then return end

tipsManager.handleCommonArgs(argstable,true)

tipsManager.handleSpeicalArgs(argstable)

tipsManager.handleTipsBody(argstable)

tipsExManager.handleTipsBtn(argstable)

tipsExManager.showTipsWindow(argstable)
end


function tipsExManager.handleArgs(argstable)

local itemguid=argstable.itemguid
local itemid=argstable.itemid
if itemguid and itemid==nil then
local item=itemsModel.getItem(itemguid)
itemid=item.itemid
argstable.itemid=itemid
end

if argstable.tipsType==TIPS_TYPE.eChiSeJinDiWeapon then
return
end



local tipsType=argstable.tipsExType
local isHideTipsEx=argstable.isHideTipsEx
if tipsType==nil then
tipsType=itemsConfig.getConfig(itemid,argstable.cfgType).tipsexid
end
if isHideTipsEx then
tipsType=nil
end


if tipsType==nil then return end
UIManager.PreloadCtor('UITipsWin')


argstable.showModel=false

argstable.backType=TIPS_BACK_TYPE.eNone

argstable=table.deepCopy(argstable)


argstable.backType=TIPS_BACK_TYPE.eSelfBack

argstable.tipsType=tipsType


argstable.isExtraTips=true

return argstable
end


function tipsExManager.showTipsWindow(argstable)
UIManager:showWindow('UITipsExWin',argstable)
end

function tipsExManager.closeTips()
UIManager:closeWindow('UITipsExWin')
end

function tipsExManager.handleTipsBtn(argstable)
tipsBtnManager.clearBtn(argstable)
end
