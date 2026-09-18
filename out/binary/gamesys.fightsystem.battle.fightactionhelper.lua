
fightActionHelper={}


function fightActionHelper.genBuffRoundInfoStr(info)
if info.cfg~=nil then
if info.cfg.duration==-1 then
return FMT.fmt("合数[无限]层数[{0}]",info.layer)
else
return FMT.fmt("回合数[{0}:{1}] 层数[{2}]",info.round,info.cfg.duration,info.layer)
end
else
return''
end
end

