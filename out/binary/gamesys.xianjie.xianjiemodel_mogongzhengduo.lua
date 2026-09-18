







function xianjieModel:checkJoin_mogongzhengduo()
local flag=moGongZhengDuoActModel:getActSceneEnterFlag()
return flag and flag==1
end

function xianjieModel:setJoin_mogongzhengduo()
moGongZhengDuoActModel:setActSceneEnterFlag(1)
end

function xianjieModel:checkRecvInitScenePos()
local pos=xianjieModel:getZongMenOutPos_mogongzhengduo()
return pos~=nil
end