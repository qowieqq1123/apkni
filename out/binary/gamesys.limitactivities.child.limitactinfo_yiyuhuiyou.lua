









local limitActInfo_yiyuhuiyou={name='yiyuhuiyou'}


function limitActInfo_yiyuhuiyou:onInit()

end


function limitActInfo_yiyuhuiyou:initTimeOffset()

local time_offset=cfg_yiyuhuiyoubaseconfig_get(1).time_offset or 5
self.end_time_offset=-(time_offset*60)
end


function limitActInfo_yiyuhuiyou:onStart()

end


function limitActInfo_yiyuhuiyou:onUpdate()

end


function limitActInfo_yiyuhuiyou:onDelete()

end


function limitActInfo_yiyuhuiyou:checkReddot()
if limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eYiYuHuiYou)then
return YiYuHuiYouController:tiaozhanNumReddot()
end
return false
end


function limitActInfo_yiyuhuiyou:jump()
local panelparams={}
panelparams.isFull=true


UIFullYiYuHuiYouController:jumpWorldYYHYWindow()

end

return limitActInfo_yiyuhuiyou
