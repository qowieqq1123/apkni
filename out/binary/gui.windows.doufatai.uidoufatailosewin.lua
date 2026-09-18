







def_class("UIDouFaTaiLoseWin",UIWindowBase)









function UIDouFaTaiLoseWin:bindComponents()

self.rankChange=UIText.get(self,0)
self.rank=UIText.get(self,1)
self.changeImg=UIObject.get(self,2)
self.ryValueMax=UIText.get(self,3)
self.Content=UIObject.get(self,4)
self.ScrollView=UIScrollView.get(self,5)
self.wendaoIcon=UIImage.get(self,6)
self.wendaoText=UIText.get(self,7)
self.honorIcon=UIImage.get(self,8)
self.honorText=UIText.get(self,9)



end


function UIDouFaTaiLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rankChange);self.rankChange=nil;
_UIObject_release(self.rank);self.rank=nil;
_UIObject_release(self.changeImg);self.changeImg=nil;
_UIObject_release(self.ryValueMax);self.ryValueMax=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.wendaoIcon);self.wendaoIcon=nil;
_UIObject_release(self.wendaoText);self.wendaoText=nil;
_UIObject_release(self.honorIcon);self.honorIcon=nil;
_UIObject_release(self.honorText);self.honorText=nil;
end



















function UIDouFaTaiLoseWin:onLoaded(...)
self:bindComponents()
local _onClickItemCallBack=function(...)
self:onClickItemCallBack(...)
end
self.ScrollView:setClickAction(_onClickItemCallBack)
end


function UIDouFaTaiLoseWin:__delete()
self:unbindComponents()
end




function UIDouFaTaiLoseWin:onShow(argtable,afterOnloaded)
local wendao=argtable[1]
local honor=argtable[2]
local dailyHonor=argtable[3]
local newRank=argtable[4]
local rewardsLen=argtable[5]
local rewards=argtable[6]

local lastData=douFaTaiModel:getLastData()
local lastRank=lastData.rank
local lastWendao=lastData.wendao
local strRack=''
local change=math.abs(newRank-lastRank)
if newRank==0 and lastRank==0 then
strRack='排名：未入榜'
else
strRack=FMT.fmt('排名：{0}',newRank)
end
self.rank:setText(strRack)
self.changeImg:setActive(lastRank>0 and change~=0)
self.rankChange:setText(change)

local curWenDao=lastWendao+wendao
local wendaoIconName=douFaTaiModel:getWenDaoIconName()
self.wendaoIcon:setImageIcon(wendaoIconName,false)
local wendaoStr=''
if wendao<0 then
wendaoStr=FMT.fmt('{0}<color=red>（{1}）</color>',curWenDao,wendao)
else
wendaoStr=curWenDao
end
self.wendaoText:setText(wendaoStr)

local config=douFaTaiModel:getDouFaTaiBasicConfig()
local maxHonor=config.max_honor
local honorId=maxHonor[1]
local honorIconName=iconHelper.getIconName(honorId)
self.honorIcon:setImageIcon(honorIconName,false)
local honorStr=''
local tempHonor=douFaTaiModel:get_tempHonorToday()
local honorToday=douFaTaiModel:get_honorToday()
if honor>0 then
honorStr=FMT.fmt('<color=green>+{0}</color>（{1}/{2}）',honor,dailyHonor,maxHonor[2])
elseif honor<0 then
honorStr=FMT.fmt('<color=red>-{0}</color>（{1}/{2}）',honor,dailyHonor,maxHonor[2])
else
honorStr='已达获取上限'
end

self.honorText:setText(honorStr)



self.ryValueMax:setActive(honorToday>=maxHonor[2])

douFaTaiModel:set_tempHonorToday()
local list
if rewardsLen>0 then
list={}
for i,v in ipairs(rewards)do
table.insert(list,{itemid=v.itemid,itemguid=v.itemguid,itemcount=v.num})
end
end


self.items=list
if self.items then
local propData={}
for i,v in ipairs(self.items)do
table.insert(propData,itemsComponentHelper.getCommonFillData(v,{showname=false,showStageBg=true,showCountBG=true}))
end
local propDataCnt=#propData
self.ScrollView:freshGridsNum(propDataCnt,1,propDataCnt,false)
self.ScrollView:initPropData(propData)
if propDataCnt<=7 then
self.Content:setAnchors(0.5,1,0.5,1)
end
end
end

function UIDouFaTaiLoseWin:onClickItemCallBack(id,index,guid,attach)
local item=self.items[index]
tipsManager.showTips({itemid=item.itemid,itemguid=item.itemguid})
end


function UIDouFaTaiLoseWin:onHide()

end



