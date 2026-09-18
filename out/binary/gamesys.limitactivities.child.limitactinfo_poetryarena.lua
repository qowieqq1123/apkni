









local limitActInfo_poetryarena={name='poetryarena'}


function limitActInfo_poetryarena:onInit()

end


function limitActInfo_poetryarena:onStart()

end


function limitActInfo_poetryarena:onUpdate()

end


function limitActInfo_poetryarena:onDelete()

end


function limitActInfo_poetryarena:checkReddot()

end


function limitActInfo_poetryarena:jump()
jumpManager:jump({id=JUMP_TYPE.ePeotryArena},nil,JUMP_BACK.eNoBack)
end

function limitActInfo_poetryarena:checkJump_data(isWarning)
local baseCfg=cfgHelper.get1(cfg_wendouleitaibaseconfig_get,1)
if not worldBlockModel:checkBlockState(baseCfg.world,1,eWorldBlockState.OPEN)then
if isWarning then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,baseCfg.world,1)
UIManager.error(FMT.fmt('探索{0}后可参与',blockCfg.name))
end
return false
end

return true
end

return limitActInfo_poetryarena