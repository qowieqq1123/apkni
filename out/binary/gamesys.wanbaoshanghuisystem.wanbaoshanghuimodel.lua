









wanBaoShangHuiModel={}


wanBaoShangHuiModel.data={}

function wanBaoShangHuiModel:onAppStart()

end


function wanBaoShangHuiModel:onEnterState(isReconnect)

end


function wanBaoShangHuiModel:onLeaveState(isReconnect)

self.data={}
end





function wanBaoShangHuiModel:setWBSHAnsweredQuestionIndex(qid)
self.data.wbsh_answeredQid=qid
end


function wanBaoShangHuiModel:getWBSHAnsweredQuestionIndex()
if self.data and self.data.wbsh_answeredQid then
return self.data.wbsh_answeredQid
end

return 0
end


function wanBaoShangHuiModel:setWBSHGetQuestionRewardFlag(flagNum)
self.data.wbsh_getRewardFlag=flagNum==1
end


function wanBaoShangHuiModel:getWBSHGetQuestionRewardFlag()
if self.data and self.data.wbsh_getRewardFlag then
return self.data.wbsh_getRewardFlag
end

return false
end


function wanBaoShangHuiModel:getWBSHQuestionMaxDay()
if self.data and self.data.wbsh_questionMaxDay then
return self.data.wbsh_questionMaxDay
end

local allDayCfg=cfg_wanbaoshanghuiconfig()
local maxDay=0
for _,v in ipairs(allDayCfg)do
for _,cfg in ipairs(v)do
if cfg.did and cfg.did>maxDay then
maxDay=cfg.did
end
end
end
self.data.wbsh_questionMaxDay=maxDay
return self.data.wbsh_questionMaxDay
end


function wanBaoShangHuiModel:setWBSHIsBuild(flag)
self.data.wbsh_isBuild=flag
end


function wanBaoShangHuiModel:getWBSHIsBuild()
if self.data and self.data.wbsh_isBuild~=nil then
return self.data.wbsh_isBuild
end

return nil
end


function wanBaoShangHuiModel:setWBSHIsFinishBuild(flag)
self.data.wbsh_isFinishBuild=flag
end


function wanBaoShangHuiModel:getWBSHIsFinishBuild()
if self.data and self.data.wbsh_isFinishBuild~=nil then
return self.data.wbsh_isFinishBuild
end

return nil
end


function wanBaoShangHuiModel:setWBSHIsNotNeedHide(flag)
self.data.wbsh_isNotNeedHide=flag
end


function wanBaoShangHuiModel:getWBSHIsNotNeedHide()
if self.data and self.data.wbsh_isNotNeedHide~=nil then
return self.data.wbsh_isNotNeedHide
end

return false
end


