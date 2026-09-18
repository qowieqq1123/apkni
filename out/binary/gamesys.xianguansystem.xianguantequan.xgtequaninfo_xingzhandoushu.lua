





local xgTeQuanInfo_XingZhanDouShu={name="xgTeQuanInfo_XingZhanDouShu"}

function xgTeQuanInfo_XingZhanDouShu:onInit()
end

function xgTeQuanInfo_XingZhanDouShu:onDelete()

end

function xgTeQuanInfo_XingZhanDouShu:onUpdate()

end

function xgTeQuanInfo_XingZhanDouShu:checkInWait()
return self.data.len>0
end

return xgTeQuanInfo_XingZhanDouShu