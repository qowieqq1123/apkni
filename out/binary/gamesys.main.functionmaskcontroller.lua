







local _MODULENAME="functionMaskController"
gameState.addListener(def_table(_MODULENAME))
functionMaskController.name=_MODULENAME

function functionMaskController:onAppStart()
end

function functionMaskController:onEnterState(isReconnet)
end

function functionMaskController:onLeaveState(isReconnet)
end

function functionMaskController:onPlayerCreate(...)
end

function functionMaskController:onProtocolReq(isReconnet)
end

function functionMaskController:onLostConnection()
end

function functionMaskController:checkFuncMask_pt(typo)
local cfg=cfgHelper.get1(cfg_functionmaskconfig_get,typo)
local flag=false
if cfg then
local ptid=loginModel:getPfid()
if ptid~=nil then
if cfg.all_pt~=nil then
flag=cfg.all_pt
elseif cfg.pt_yes~=nil then
flag=false
if cfg.pt_yes[ptid]~=nil then
flag=true
end
elseif cfg.pt_no~=nil then
flag=true
if cfg.pt_no[ptid]~=nil then
flag=false
end
end
end
end
return flag
end

function functionMaskController:getFuncMaskArgs(typo)
return cfgHelper.get2(cfg_functionmaskconfig_get,typo,'args')
end