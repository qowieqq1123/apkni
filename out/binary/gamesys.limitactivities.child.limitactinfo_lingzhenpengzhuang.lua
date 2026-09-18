
local limitActInfo_lingzhenpengzhuang={name='lingzhenpengzhuang'}


function limitActInfo_lingzhenpengzhuang:onInit()

end


function limitActInfo_lingzhenpengzhuang:onStart()
if self:checkOpen()and not self:checkIdle()then
lingZhenPengZhuangController:reqDatas()
end
end


function limitActInfo_lingzhenpengzhuang:onUpdate()

end


function limitActInfo_lingzhenpengzhuang:onDelete()

end


function limitActInfo_lingzhenpengzhuang:checkReddot()
return false
end


function limitActInfo_lingzhenpengzhuang:jump()

return UILZPZControl:showMainWin()
end

return limitActInfo_lingzhenpengzhuang