







def_class("UILianQiMGResult",UIWindowBase)









function UILianQiMGResult:bindComponents()

self.arrow=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.effect=UIObject.get(self,2)
self.rank=UIText.get(self,3)
self.rankDesc=UIText.get(self,4)
self.score=UIText.get(self,5)
self.tipsText=UIText.get(self,6)



end


function UILianQiMGResult:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.rankDesc);self.rankDesc=nil;
_UIObject_release(self.score);self.score=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end



















function UILianQiMGResult:onLoaded(...)
self:bindComponents()

self.rank:setActive(false)
self.rankDesc:setActive(false)

self.effect:setChildShowEffect(10014,true)
end


function UILianQiMGResult:__delete()
self:unbindComponents()
end




function UILianQiMGResult:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
local rankData=argtable.rankData

local data=activitiesModel:getSubActInfoData(self.actId,self.subType,self.subId)
self.data=data
local score=data.resultScore or 0

local cfg=cfgHelper.get1(cfg_artifactrefineconfig_get,self.subId)
local result_desc=cfg.result_desc
local desc=''
for i,v in ipairs(result_desc)do
if score>=v[1]then
desc=v[2]
end
end

self.desc:setText(desc)
self.score:setText(FMT.fmt('本局积分：<color=#549327>{0}</color>',score))

if rankData then
self:setRank(rankData)
end
end


function UILianQiMGResult:onHide()

end

function UILianQiMGResult:getScoreToNext(rankData,myRank)
local index
for i,v in ipairs(rankData.zsRankItemInfoLookup)do
index=i
if myRank>=v.range[1]and myRank<=v.range[2]then
break
end
end
local rd=rankData.zsRankItemInfoLookup[index-1]
local len=#rd.rankPlayerList
if len>0 then
local pd=rd.rankPlayerList[len]
local ds=pd.score-rankData.zsRankData.myScore
return ds
else
local ds=rd.upRankMinVal-rankData.zsRankData.myScore
return ds
end
end

function UILianQiMGResult:setRank(rankData)
self.rank:setActive(true)
self.rankDesc:setActive(true)
local myRank=rankData.zsRankData.myRank
self.rank:setText(FMT.fmt('当前排行：<color=#549327>{0}</color>',myRank))
self.arrow:setActive(myRank<self.data.startMyRank)
if myRank>1 then
local ds=self:getScoreToNext(rankData,myRank)
self.rankDesc:setText(FMT.fmt('距前一名：<color=#549327>{0}</color>',ds))
else
self.rankDesc:setText('')
end
end




function UILianQiMGResult:onClickClose()
self:closeSelf()
end
