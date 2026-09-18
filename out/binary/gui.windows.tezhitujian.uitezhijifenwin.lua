







def_class("UITeZhiJiFenWin",UIWindowBase)









function UITeZhiJiFenWin:bindComponents()

self.root=UIObject.get(self,0)
self.verProScrollView=UIObject.get(self,1)
self.ProgressBarEx=UIObject.get(self,2)
self.ProgressEx=UIObject.get(self,3)
self.verProContent=UIObject.get(self,4)
self.ProgressBar=UIObject.get(self,5)
self.Progress=UIObject.get(self,6)
self.pro=UIText.get(self,7)



end


function UITeZhiJiFenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.verProScrollView);self.verProScrollView=nil;
_UIObject_release(self.ProgressBarEx);self.ProgressBarEx=nil;
_UIObject_release(self.ProgressEx);self.ProgressEx=nil;
_UIObject_release(self.verProContent);self.verProContent=nil;
_UIObject_release(self.ProgressBar);self.ProgressBar=nil;
_UIObject_release(self.Progress);self.Progress=nil;
_UIObject_release(self.pro);self.pro=nil;
end



















local itemHight=130
local itemSpace=12
local bottomOffset=0
local topOffset=20

local firstStepHeight=itemHight/2+bottomOffset
local stepHeight=itemHight+itemSpace

local verProItemCmp={
itemList={0,1,2},
hasFlag=3,
gotBg=4,
bg=5,
num=6,
gotFlag=7,
desc=8,
click=9,
}

function UITeZhiJiFenWin:onLoaded(...)
self:bindComponents()
end


function UITeZhiJiFenWin:__delete()
self:unbindComponents()
end




function UITeZhiJiFenWin:onShow(argtable,afterOnloaded)
self:initList()
self:refreshList()
end


function UITeZhiJiFenWin:onHide()

end


function UITeZhiJiFenWin:initList()
local cfg=cfg_disciplespebookrewardconfig()
self.rewardsList={}
for i,v in ipairs(cfg)do
local temp={}
temp[1]=v.point
temp[2]=v.rewards
temp[3]=v.desc
table.insert(self.rewardsList,temp)
end
local listCount=#self.rewardsList
self.verProContent:setChildLayoutGroupCreateItems(listCount)
self.grids=self.verProContent:getChildLayoutGroupGridList()
for i=1,listCount do
local item=self.grids[listCount-i]
local temp=self.rewardsList[i]
local num=temp[1]
local rewards=temp[2]
local desc=temp[3]




for ii,v in ipairs(verProItemCmp.itemList)do
local itemCfg=rewards[ii]
if itemCfg then
local itemid=itemCfg[1]
local count=itemCfg[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(v,prop)
item:SetBaseItemClickEvent(v,function(...)
self:onClickItem(i,itemid)
end)
else
item:SetChildActive(v,false)
end
end

item:SetChildText(verProItemCmp.num,num)
item:SetChildText(verProItemCmp.desc,desc)
item:SetChildButtonClick(verProItemCmp.click,function(...)
self:onClickItemEx(i)
end)
end

local max_height=firstStepHeight+(listCount-1)*stepHeight+10
self.ProgressBar:setChildSizeDelta(28,max_height)
local content_height=listCount*itemHight+bottomOffset+topOffset+(listCount-1)*itemSpace
self.verProContent:setChildSizeDelta(395.4378,content_height)
end

function UITeZhiJiFenWin:refreshList()
local list=self.rewardsList
local listCount=#list
local recvIndex=TeZhiTuJianModel:getDataIdx()
local curCount=TeZhiTuJianModel:getAllActiveJiFen()
local curIndex=0
local jumpIndex=nil
local firstNotIndex=nil
for i=1,listCount do
local item=self.grids[listCount-i]
local temp=list[i]
local num=temp[1]
local canReward=curCount>=num
local recvFlag=recvIndex>=i

item:SetChildActive(verProItemCmp.gotFlag,recvFlag)

item:SetChildActive(verProItemCmp.hasFlag,canReward and not recvFlag)
curIndex=canReward and i or curIndex
if canReward and not recvFlag and not jumpIndex then
jumpIndex=i
end
if not canReward and not firstNotIndex then
firstNotIndex=i
end
end

local max_height=firstStepHeight+(listCount-1)*stepHeight

local cur_height
if curIndex>=listCount then
cur_height=max_height
jumpIndex=listCount
elseif curIndex<=0 then
cur_height=curCount/list[curIndex+1][1]*firstStepHeight
jumpIndex=1
else
if not jumpIndex then
jumpIndex=firstNotIndex and firstNotIndex-1 or 1
jumpIndex=jumpIndex<1 and 1 or jumpIndex
end
local rate=(curCount-list[curIndex][1])/(list[curIndex+1][1]-list[curIndex][1])
local rateHeight=rate*stepHeight
cur_height=firstStepHeight+(curIndex-1)*stepHeight+rateHeight
end
cur_height=cur_height>0 and cur_height+10 or 0
self.Progress:setChildSizeDelta(28,cur_height)
self.ProgressEx:setActive(curCount>0)

self:jumpTargetIndexItem_First(jumpIndex)
end


function UITeZhiJiFenWin:jumpTargetIndexItem_First(index)
index=index-1
local list=self.rewardsList
local listCount=#list
local content_height=listCount*itemHight+bottomOffset+topOffset+(listCount-1)*itemSpace
local showHeight=self.verProScrollView:getChildRectHeight()
local moveHeight=index==0 and bottomOffset or firstStepHeight+(index-1)*stepHeight+itemHight/2
local moveMax_Height_=content_height-showHeight
if moveHeight>moveMax_Height_ then
moveHeight=moveMax_Height_
end

local moveY=moveHeight

self.verProContent:setChildAnchoredPos(0,-moveY)

end

function UITeZhiJiFenWin:onClickItem(index,itemId)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,backType=TIPS_BACK_TYPE.eSelfBack})
end

function UITeZhiJiFenWin:onClickItemEx(index)
local recvIndex=TeZhiTuJianModel:getDataIdx()
local curCount=TeZhiTuJianModel:getAllActiveJiFen()
local temp=self.rewardsList[index]
local num=temp[1]
local canReward=curCount>=num
local recvFlag=recvIndex>=index
if canReward and not recvFlag then
TeZhiTuJianController.req_2_150()
UIManager:closeWindow("UICommonPageWin")
return
end

end


