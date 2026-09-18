





















local fTypeEnum={
xmFunctionZone=1,
xmHomeZone=2,
xmDecorateZone=3,
wbshZone=4,
tiandaoshuZone=5,
wbxbdZone=6,
}

local fTypeHandle={
[fTypeEnum.xmFunctionZone]="handleXMCell",
[fTypeEnum.xmHomeZone]="handleXMCell",
[fTypeEnum.xmDecorateZone]="handleXMCell",
[fTypeEnum.wbshZone]="handleWBSHCell",
[fTypeEnum.tiandaoshuZone]="handleXMCell",
[fTypeEnum.wbxbdZone]="handleWBXBDCell",
}

local cellCheckFuncND=function(ctype,ftype,args)
local ccfg=cfgHelper.get1(cfg_conditionconfig_get,args.checkId)
local mapfunc=args.ftype
local checkType=ccfg.checkType
if ftype>0 then
if mapfunc>0 then
if ftype==mapfunc then
if not isometricMapSystem:checkFuncByType(ctype,ftype,args)then
return false
end
else
return false
end
elseif mapfunc<0 then
local group=cfgHelper.get1(cfg_funcgroupconfig_get,mapfunc,'group')
local pass=false
for i,v in ipairs(group)do
if v==ftype then
if isometricMapSystem:checkFuncByType(ctype,ftype,args)then
pass=true
break
end
end
end
if not pass then
return false
end
end
elseif ftype<0 then
local fgroup=cfgHelper.get1(cfg_funcgroupconfig_get,ftype,'group')
if mapfunc>0 then
if checkType==1 then
if#fgroup>1 or fgroup[1]~=mapfunc then
return false
end
if not isometricMapSystem:checkFuncByType(ctype,ftype,args)then
return false
end
elseif checkType==2 then
local pass=false
for i,v in ipairs(fgroup)do
if v==mapfunc then
if isometricMapSystem:checkFuncByType(ctype,ftype,args)then
pass=true
break
end
end
end
if not pass then
return false
end
end
elseif mapfunc<0 then
local mgroup=cfgHelper.get1(cfg_funcgroupconfig_get,mapfunc,'group')
if checkType==1 then
for i,v in ipairs(fgroup)do
local pass=false
for ii,vv in ipairs(mgroup)do
if v==vv then
if isometricMapSystem:checkFuncByType(ctype,ftype,args)then
pass=true
break
end
end
end
if not pass then
return false
end
end
elseif checkType==2 then
local pass=false
for i,v in ipairs(fgroup)do
for ii,vv in ipairs(mgroup)do
if v==vv then
if isometricMapSystem:checkFuncByType(ctype,ftype,args)then
pass=true
break
end
end
end
if pass then
break
end
end
if not pass then
return false
end
end
end
end

return true
end

local cellCheckFunc=function(ctype,ftype,fargs)
local args=jsonHelper.decode(fargs)
return cellCheckFuncND(ctype,ftype,args)
end



local _checkCoverObject=function(args,ignoreList)
local check=args.isCoverObject
if check and ignoreList then
local count=0
local coverTypeList=args.coverTypeList
local len=#coverTypeList
for i,v in ipairs(ignoreList)do
for ii,vv in ipairs(coverTypeList)do
if v==vv then
count=count+1
break
end
end
end
if count>=len then
return false
end
end
return check
end

local _checkCellSpecialFunc=function(cfg,ctype,args)
if args.ftype~=0 then
if cfg.checkFunc==2 then
return false
end
if cfg.checkFunc==3 then
if not cellCheckFuncND(ctype,cfg.func,args)then
return false
end
end
else
if cfg.checkNotFunc==2 then
return false
end
end

return true
end

local _replace_funcs=
{
[1]=function(cfg,args)
if cfg.checkLock then
if not args.isUnlock then
return false
end
end
if cfg.checkPlace then
if not args.allowPlace then
return false
end
end
if cfg.checkCover then
if _checkCoverObject(args,cfg.ignoreCover)then
return false
end
end
if cfg.checkObstacle then
if args.coverObstacle then
return false
end
end
if cfg.checkRoad and not args.isObjAisle then
if args.coverRoad then
return false
end
end
if cfg.checkWall then
if args.coverWall then
return false
end
end
if cfg.checkBDArea then
if args.coverBDArea then
return false
end
end
if cfg.checkSPA then
if args.spA then
return false
end
end

return _checkCellSpecialFunc(cfg,1,args)
end,
[2]=function(cfg,args)
if cfg.checkLock then
if not args.isUnlock then
return false
end
end
if cfg.checkPass then
if not args.allowPass then
return false
end
end
if cfg.checkCover then
if _checkCoverObject(args,cfg.ignoreCover)then
if cfg.checkAisle then
return false
end
if not args.isAisle then
return false
end
end
end
if cfg.checkAllowRoad then
if not args.allowRoad then
return false
end
end
if cfg.checkObstacle then
if args.coverObstacle then
return false
end
end
if cfg.checkRoad then
if args.coverRoad then
return false
end
end
if cfg.checkWall then
if args.coverWall then
return false
end
end
if cfg.checkBDArea then
if args.coverBDArea then
return false
end
end
if cfg.checkSPA then
if args.spA then
return false
end
end

return _checkCellSpecialFunc(cfg,2,args)
end,
[3]=function(cfg,args)
if cfg.checkLock then
if not args.isUnlock then
return false
end
end
if cfg.checkPass then
if not args.allowPass then
return false
end
end
if cfg.checkPlace then
if not args.allowPlace then
return false
end
end
if cfg.checkCover then
if _checkCoverObject(args,cfg.ignoreCover)then
return false
end
end
if cfg.checkAllowRoad then
if not args.allowRoad then
return false
end
end
if cfg.checkObstacle then
if args.coverObstacle then
return false
end
end
if cfg.checkRoad then
if args.coverRoad then
return false
end
end
if cfg.checkWall then
if args.coverWall then
return false
end
end
if cfg.checkBDArea then
if args.coverBDArea then
return false
end
end
if cfg.checkSPA then
if args.spA then
return false
end
end

return _checkCellSpecialFunc(cfg,3,args)
end,
}

local mapCellCheckFunc=function(ctype,fargs)
local args=jsonHelper.decode(fargs)
local cfg=cfgHelper.get1(cfg_conditionconfig_get,args.checkId)
local func=_replace_funcs[ctype]
return func(cfg,args)
end



function isometricMapSystem:checkFuncByType(ctype,ftype,args)
local handle=fTypeHandle[ftype]
if handle and isometricMapSystem[handle]then
return isometricMapSystem[handle](isometricMapSystem,ctype,ftype,args)
end
return true
end

function isometricMapSystem:initCellCheck()



_MapManager.SetCellCheckFunction(cellCheckFunc)

end


function isometricMapSystem:checkFuncTest(bActive)
if bActive then
_MapManager.ReplaceCellCheckFunction(mapCellCheckFunc)
else
_MapManager.ReplaceCellCheckFunction(nil)
_MapManager.SetCellCheckFunction(cellCheckFunc)
end
end

function isometricMapSystem:handleXMCell(ctype,ftype,args)
local cfg=cfg_monijyposfuncconfig()
if cfg and cfg[args.mapId]and cfg[args.mapId][args.x]and cfg[args.mapId][args.x][args.y]then
local cfg=cfg[args.mapId][args.x][args.y]
local param=cfg.func
local dType=param[1]
local checkName=FMT.fmt("doXMCellCheckFunc{0}",dType)
local checkMethod=isometricMapSystem[checkName]
if checkMethod then
local r=checkMethod(isometricMapSystem,args,param[2])
return r
end
end
return false
end

function isometricMapSystem:doXMCellCheckFunc1(fargs,param)
local preview=self:getPreviewBuilding()
if preview and preview.guid==fargs.guid then
return param[fargs.cfgId]or false
end
return true
end

function isometricMapSystem:handleWBSHCell(ctype,ftype,args)
if ctype==2 and wanBaoShangHuiController:checkWBSHFinishBuild()then

return true
end

return false
end

function isometricMapSystem:handleWBXBDCell(ctype,ftype,args)
if ctype==2 and wanBaoXunBaoDuiController:checkWBXBDFinishBuild()then

return true
end

return false
end
