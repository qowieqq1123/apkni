









local subActivityInfo_guitutequan={name='guitutequan'}

function subActivityInfo_guitutequan:onInit()

end

function subActivityInfo_guitutequan:onStart()

end

function subActivityInfo_guitutequan:onUpdate()

end

function subActivityInfo_guitutequan:onDelete()

end

function subActivityInfo_guitutequan:checkReddot()
return false
end


function subActivityInfo_guitutequan:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then
end
end
end



function subActivityInfo_guitutequan:startActTime()

end

return subActivityInfo_guitutequan