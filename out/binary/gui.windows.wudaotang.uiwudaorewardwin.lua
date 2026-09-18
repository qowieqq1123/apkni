







def_class("UIWuDaoRewardWin",UIWindowBase)









function UIWuDaoRewardWin:bindComponents()

self.xwRewardGrid=UIObject.get(self,0)
self.goodRewardGrid=UIObject.get(self,1)



end


function UIWuDaoRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.xwRewardGrid);self.xwRewardGrid=nil;
_UIObject_release(self.goodRewardGrid);self.goodRewardGrid=nil;
end
















local maxMan=3


function UIWuDaoRewardWin:onLoaded(...)
self:bindComponents()
end


function UIWuDaoRewardWin:__delete()
self:unbindComponents()
end


function UIWuDaoRewardWin:onHide()

end




function UIWuDaoRewardWin:onShow(argtable,afterOnloaded)
self.planid=argtable.planid
self.dislist=argtable.dislist
self.rewardlist=argtable.rewardlist

self:refreshXWReward()
self:refreshGoodReward()



end

function UIWuDaoRewardWin:doRewardAnim(delay)
self.playing=true
for i,v in ipairs(self.dislist)do
delay=self:delayPlayReward(i,delay)
end
local func=function()
self.playing=nil
end
self:delayDo(delay,func)
end

function UIWuDaoRewardWin:delayPlayReward(idx,delay)
local data=self.rewardlist[idx]
if data and#data.reward>0 then

local func=function()

end
local dt=self:delayDo(delay,func)
table.insert(self.delayPlayList,dt)

delay=self:delayPlayRewardList(idx,delay+0.2)

delay=delay+0.2
end
return delay
end

function UIWuDaoRewardWin:delayPlayRewardList(idx,delay)
local grid=self.goodRewardGrid:getChildLayoutGroupGridList()
local lp=self.goodIdxLookup[idx]
for i=lp[1],lp[2]do
local item=grid[i-1]
local func=function()
item:SetChildCanvasGroupDOFade(1,1,0.2)
end
local dt=self:delayDo(delay,func)
table.insert(self.delayPlayList,dt)
delay=delay+0.1
end
return delay
end

function UIWuDaoRewardWin:clearDelyPlayList()
if self.delayPlayList~=nil then
for i,v in ipairs(self.delayPlayList)do
self:stopTimerByID(v)
end
self.delayPlayList=nil
end
end

function UIWuDaoRewardWin:refreshXWReward()
local grid=self.xwRewardGrid:getChildCommonLayoutGroupWidgetList()
local c=grid.Count
for i=1,maxMan do
local item=grid[i-1]
local guid=self.dislist[i]
local isshow=guid~=nil
item:SetChildActive(-1,isshow)
if isshow then
local data=self.rewardlist[i]or{}


local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(0,globalABLookup.diciplecolorframe,discipleColorToFrame2[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(4,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(6,isSpDz)

item:SetChildText(1,UIDiscipleModel:getDiscipleName(guid))

comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead)


local jjlv=UIDiscipleModel:getDiscipleJJLevel(guid)
local curjjexp=UIDiscipleModel:calculationJJExp(guid)
local nxjjexp=cfgHelper.get2(cfg_disciplejingjieconfig_get,jjlv,'exp')
local isfull=nxjjexp<=0
local needBroke=false
if not isfull then
if curjjexp>=nxjjexp then
curjjexp=nxjjexp
needBroke=true
end
else
curjjexp=1
nxjjexp=1
end
item:SetChildProgressValue(5,0,nxjjexp)
item:SetChildProgress(5,curjjexp,nxjjexp)
local jj_p_str=''
if not isfull then
if not needBroke then
jj_p_str=FMT.fmt('修为+{0}',data.exp or 0)
end
else
jj_p_str='已满级'
end
item:SetChildProgressText(5,jj_p_str)
end
end
end

function UIWuDaoRewardWin:refreshGoodReward()
local goodlist={}
local lookup={}

for idx,data in pairsBySortKey(self.rewardlist)do
if data.reward and#data.reward>0 then




for i2,v2 in ipairs(data.reward)do
local itemid=v2.itemid
if lookup[itemid]==nil then
lookup[itemid]=v2
else
lookup[itemid].num=lookup[itemid].num+v2.num
end
end
end
end
for k,v in pairs(lookup)do
local itemConfig=itemsConfig.getConfig(v.itemid)
v.color=itemConfig.color
table.insert(goodlist,v)
end
if#goodlist>1 then
table.sort(goodlist,function(a,b)
return a.color<b.color
end)
end
self.goodRewardGrid:setChildLayoutGroupCreateItems(#goodlist)
local grid=self.goodRewardGrid:getChildLayoutGroupGridList()
local c=grid.Count
for i=1,c do
local data=goodlist[i]
local item=grid[i-1]
local show=data~=nil
item:SetChildActive(1,show)
if show then
local itemID=data.itemid
local num=data.num
local str=tostring(num)
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(TIPS_MOVE_POS.eRight,...)end)

end
end
end

function UIWuDaoRewardWin:onGoodItemClick(pos,itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=pos})
end
end

function UIWuDaoRewardWin:onCloseClick(...)
if self.playing==true then
self:clearDelyPlayList()
self.playing=nil
local grid=self.goodRewardGrid:getChildLayoutGroupGridList()
local c=grid.Count
for i=1,c do
local item=grid[i-1]
item:SetChildCanvasGroupAlpha(1,1)
end
else
self:closeSelf()
end
end