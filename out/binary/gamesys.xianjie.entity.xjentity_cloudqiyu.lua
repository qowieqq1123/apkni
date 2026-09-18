









local xjEntity_cloudQiYu={}


function xjEntity_cloudQiYu:onInit()
local data=self.data
self.cloudid=data[1]
self.idx=data[2]
local qyData=xianjieModel:getCloudQiYuData(self.cloudid,self.idx)
self.pos=qyData:getWorldPos_1()
self.size=qyData:getWorldSize()
end


function xjEntity_cloudQiYu:onCreateWidget(widget)









end


function xjEntity_cloudQiYu:onRemoveWidget(widget)

end






function xjEntity_cloudQiYu:onDelete()

end

return xjEntity_cloudQiYu