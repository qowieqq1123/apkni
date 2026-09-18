







def_class("UIHunYuanDanHuiResultWin",UIWindowBase)









function UIHunYuanDanHuiResultWin:bindComponents()

self.bg=UIObject.get(self,0)
self.descTxt=UIText.get(self,1)
self.effect=UIObject.get(self,2)
self.FullScreenClose=UIButton.get(self,3)
self.rankTxt=UIText.get(self,4)
self.rankUp=UIObject.get(self,5)
self.scoreTxt=UIText.get(self,6)
self.upScoreTxt=UIText.get(self,7)

self.FullScreenClose:setButtonClick(function()self:onFullScreenClose()end)



end


function UIHunYuanDanHuiResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.FullScreenClose);self.FullScreenClose=nil;
_UIObject_release(self.rankTxt);self.rankTxt=nil;
_UIObject_release(self.rankUp);self.rankUp=nil;
_UIObject_release(self.scoreTxt);self.scoreTxt=nil;
_UIObject_release(self.upScoreTxt);self.upScoreTxt=nil;
end
















local _this




function UIHunYuanDanHuiResultWin:onLoaded(...)
self:bindComponents()
_this=self

local _recv_247_3=function()

_this:refresh()
end
self:addProNotify(247,3,_recv_247_3)








end


function UIHunYuanDanHuiResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UIHunYuanDanHuiResultWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
local score=argtable.score
self.score=score

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)



self.scoreTxt:setText(FMT.fmt("本局积分：<color=#549327>{0}</color>",score))


self.rankTxt:setActive(false)
self.upScoreTxt:setActive(false)

local list=self.info:getSubRankAct()
if#list>0 then
local sub_actInfo=list[1]
local data=activitiesModel:getSubActInfoData(sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)or{}
local zsRankData=data.zsRankData
local rank=zsRankData.myRank or 0
self.oldRank=rank

activitiesController:sendProtocol(actSendType.eComonReqInfo,sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)
end
end

function UIHunYuanDanHuiResultWin:refresh()
local list=self.info:getSubRankAct()
if#list>0 then
local sub_actInfo=list[1]
local data=activitiesModel:getSubActInfoData(sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)or{}

local zsRankData=data.zsRankData
local rank=zsRankData.myRank or 0
local rank_str=FMT.fmt('我的排名：<color=#549327>{0}</color>',rank==0 and"未上榜"or rank)
self.rankTxt:setText(rank_str)

local hasUp=false


if rank==0 then





elseif rank==1 then

hasUp=self.oldRank==0 or self.oldRank>rank
else








hasUp=self.oldRank==0 or self.oldRank>rank
end


self.rankTxt:setActive(true)

self.rankUp:setActive(hasUp)

activitiesController:sendProtocol(actSendType.eComonReqInfo,sub_actInfo.act_id,sub_actInfo.sub_act_type,sub_actInfo.sub_act_id)
else
self.rankTxt:setActive(false)

end
end


function UIHunYuanDanHuiResultWin:onHide()

end

function UIHunYuanDanHuiResultWin:getDesc(score)
for i,v in ipairs(self.sub_actcfg.scoreDesc)do
if score>=v[1]and(score<=v[2]or v[2]==-1)then
local range=math.random(1,#v[3])
return v[3][range]
end
end
return""
end




function UIHunYuanDanHuiResultWin:onFullScreenClose()
end

function UIHunYuanDanHuiResultWin:onCloseWin()
self:closeSelf()
end
