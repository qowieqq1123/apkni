local cndType={
eZMLevel=1,
}

local cndChecker={
[cndType.eZMLevel]=function(data,param)
local limitLevel=param[2]
local zmLevel=zongmenModel:getZongMenLimitLv()
return zmLevel>=limitLevel
end,
}

function xianjieHelper.checkMonsterLimitCND(monsterData)
if not monsterData then
return false
end
local cfg=monsterData:getCfg()
if not cfg then
return false
end
if cfg.limitCND==nil or#cfg.limitCND==0 then
return true
end
for _,cnds in ipairs(cfg.limitCND)do
local cndType=cnds[1]
local checker=cndChecker[cndType]
if checker then
local isPass=checker(monsterData,cnds)
if not isPass then
return false
end
else

logErr(FMT.fmt('仙界实体--未知的条件类型,cnd={0}',serializeHelper.serialize(cnds)))

end
end
return true
end