









local limitActInfo_xianjiefumo={name='xianjiefumo'}


function limitActInfo_xianjiefumo:onInit()

end


function limitActInfo_xianjiefumo:onStart()
if self:checkOpen()then
XianJieFuMoController.req_248_103()
end
end


function limitActInfo_xianjiefumo:onUpdate()

end


function limitActInfo_xianjiefumo:onDelete()

end


function limitActInfo_xianjiefumo:checkReddot()
if self:checkDoing()then
return XianJieFuMoController:getReddot()
end
return false
end


function limitActInfo_xianjiefumo:jump(args)
XianJieFuMoController:reqRankInfo(args)
end

return limitActInfo_xianjiefumo