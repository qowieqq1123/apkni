





local xgTeQuanInfo_XianShiYaoWu={name="xgTeQuanInfo_XianShiYaoWu"}

function xgTeQuanInfo_XianShiYaoWu:onInit()
end

function xgTeQuanInfo_XianShiYaoWu:onDelete()

end

function xgTeQuanInfo_XianShiYaoWu:onUpdate()

end

function xgTeQuanInfo_XianShiYaoWu:checkInWait()
if self.data and self.data.list then
return true
end
return false
end

return xgTeQuanInfo_XianShiYaoWu