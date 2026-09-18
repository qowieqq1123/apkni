systemIconConfig={}

local _posfun=
{
[1]=function(iconType)
return systemIconConfig.getMainIconPosition(iconType)
end,

[2]=function(iconType)
return systemIconConfig.getTaskIconPosition(iconType)
end,
[4]=function(iconType)
return systemIconConfig.getXJMainIconPosition(iconType)
end,
}

local _freshfun=
{
[1]=function(iconType)
systemIconConfig.showMainIcon(iconType)
end,

[2]=function(iconType)
systemIconConfig.showTaskIcon(iconType)
end,
[4]=function(iconType)
systemIconConfig.showMainIcon(iconType)
end,
}


function systemIconConfig.getMainIconPosition(iconType)
local key=iconType and mainBtnConfig.getIconKey(iconType)
local pos
if key and UIManager:isActive('UIMain')then
pos=UIManager:callWindowFunc('UIMain','getPositionByKey',key)
if pos.x==0 and pos.y==0 and pos.z==0 then
local widget=UIManager:callWindowFunc('UIMain','getWidgetByKey',key)
if widget==nil then
pos=nil
end
end
end
return pos
end

function systemIconConfig.getTaskIconPosition(iconType)
if iconType==ICON_TYPE.mainZheXianLing then
if UIManager:isActive('UITaskListWin')then
return UIManager:callWindowFunc('UITaskListWin','getZheXianLingIconPosition')
end
else

end
end


function systemIconConfig.getXJMainIconPosition(iconType)
local key=iconType and mainBtnConfig.getIconKey(iconType)
local pos
if key and UIManager:isActive('UIXianJieMainWin')then
pos=UIManager:callWindowFunc('UIXianJieMainWin','getPositionByKey',key)
if pos.x==0 and pos.y==0 and pos.z==0 then
local widget=UIManager:callWindowFunc('UIXianJieMainWin','getWidgetByKey',key)
if widget==nil then
pos=nil
end
end
end
return pos
end

function systemIconConfig.showMainIcon(iconType)
local key=iconType and mainBtnConfig.getIconKey(iconType)
if key==nil then return end
UIManager:callWindowFunc('UIMain','doFadeNomal',key)
UIManager:callWindowFunc('UIXianJieMainWin','doFadeNomal',key)
end


function systemIconConfig.showTaskIcon(iconType)
if iconType==ICON_TYPE.mainZheXianLing then
UIManager:callWindowFunc('UITaskListWin','showZheXianLingIcon')
else

end
end



function systemIconConfig.getIconPosition(iconType)
if iconType==nil or iconType<=0 then return end
local cfg=cfg_systemiconlockconfig_get(iconType)
if cfg then
if not cfg.args then
loggerUtil.logErrFMT('图标解锁配置表id={0}没有配置图标参数',iconType)
return
end
local funcType=cfg.args
if funcType then
for i,v in ipairs(funcType)do
local func=_posfun[v]
local pos=func and func(iconType)or nil
if pos then
return pos
end
end
end
end
loggerUtil.logErrFMT('图标解锁配置表没有找到id={0}的配置',iconType)
end

function systemIconConfig.freshIcon(iconType)
if iconType==nil or iconType<=0 then return end
local cfg=cfg_systemiconlockconfig_get(iconType)
if cfg then
if not cfg.args then
loggerUtil.logErrFMT('图标解锁配置表id={0}没有配置图标参数',iconType)
return
end
local funcType=cfg.args
if funcType then
for _,v in ipairs(funcType)do
local func=_freshfun[v]
if func then
func(iconType)
end
end
return
end
end
loggerUtil.logErrFMT('图标解锁配置表没有找到id={0}的配置',iconType)
end