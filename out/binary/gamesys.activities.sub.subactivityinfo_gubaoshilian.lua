









local subActivityInfo_gubaoshilian={name='subActivityInfo_gubaoshilian'}

local _rankDirty=10

function subActivityInfo_gubaoshilian:onInit()
self.data=nil
end

function subActivityInfo_gubaoshilian:onStart()

end

function subActivityInfo_gubaoshilian:onDelete()
self.data=nil
self.rankData=nil
self.rankTime=nil
end

function subActivityInfo_gubaoshilian:checkReddot()
return false
end

function subActivityInfo_gubaoshilian:setRankData(rankList,myRank)
self.rankData=rankList or{}
self.myRank=myRank
self.rankTime=timeHelper.getServerShortTime()+_rankDirty
end

function subActivityInfo_gubaoshilian:getRankList()
return self.rankData
end

function subActivityInfo_gubaoshilian:getRankData(no)
return self.rankData[no]
end

function subActivityInfo_gubaoshilian:getMyRank()
return self.myRank
end

function subActivityInfo_gubaoshilian:checkRankDirty()
return self.rankTime==nil or timeHelper.getServerShortTime()>self.rankTime
end

function subActivityInfo_gubaoshilian:setRankDirty()
self.rankTime=nil
end

return subActivityInfo_gubaoshilian