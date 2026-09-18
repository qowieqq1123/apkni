







def_class("UISubAct_dongtianfudi_pos_win",UIWindowBase)









function UISubAct_dongtianfudi_pos_win:bindComponents()

self.front=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.posBg=UIObject.get(self,3)
self.posText=UIText.get(self,4)
self.scrollView=UIObject.get(self,5)
self.sureButton=UIButton.get(self,6)
self.progressBar=UIProgress.get(self,7)
self.condtion=UIText.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.sureButton:setButtonClick(function()self:onSureButton()end)



end


function UISubAct_dongtianfudi_pos_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.front);self.front=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.posBg);self.posBg=nil;
_UIObject_release(self.posText);self.posText=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.sureButton);self.sureButton=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.condtion);self.condtion=nil;
end


















local modelSpine={{4726,0.55,2},{4727,0.6,15},{4728,0.6,2},{4729,0.7,15},}

function UISubAct_dongtianfudi_pos_win:onLoaded(...)
self:bindComponents()
self.model:setChildUIModelShowTarget(4736,1,{},eAnimationID.enter,false,nil,0)
self.front:setChildCanvasGroupAlpha(0)
local t=self.front:setChildCanvasGroupDOFade(1,0.5)
t:SetDelay(0.3)
end


function UISubAct_dongtianfudi_pos_win:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UISubAct_dongtianfudi_Win","showInfoRoot",1)
end




function UISubAct_dongtianfudi_pos_win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable.args
self.newFuDi=argtable.newFuDi or{}
self.actid=self.activityArgs.act_id
self.subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
self.subid=self.activityArgs.sub_act_id

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self:refreshList()

UIManager:invokeUIMethod("UISubAct_dongtianfudi_Win","showInfoRoot",0)
end


function UISubAct_dongtianfudi_pos_win:onHide()

end

function UISubAct_dongtianfudi_pos_win:refreshList()
local modelList=self.config.model
local nameList=self.config.name
local lotteryList=self.config.lotteryList
local show2=self.config.show2
local num=#lotteryList
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)

local total_num=data.total_num
local lock_idx=data.lock_idx
self.selectLockIdx=lock_idx
if lock_idx>0 then
self.posText:setText(FMT.fmt("弟子只会在<color=#fd8950>{0}</color>中探索",nameList[lock_idx]))

else
self.sureButton:setActive(false)
local nList={}
local str='弟子将在'
for i,v in ipairs(lotteryList)do
if total_num>=v[1]then
nList[#nList+1]=nameList[i]
end
end
if#nList==#nameList then
str=FMT.fmt("{0}<color=#fd8950>所有福地</color>",str)
else
for i,v in ipairs(nList)do
if i<#nList then
str=FMT.fmt("{0}<color=#fd8950>{1},</color>",str,nameList[i])
else
str=FMT.fmt("{0}<color=#fd8950>{1}</color>",str,nameList[i])
end
end
end

str=FMT.fmt("{0}中探索",str)
self.posText:setText(str)


self.progressBar:setActive(false)
end


self.scrollView:setChildScrollViewCreateGrids(num,num)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local model=modelSpine[i]
local name=nameList[i]
local lottery=lotteryList[i]
local needUnlock=lottery[1]
local needUnlockPos=lottery[2]
local isLock=total_num<needUnlock
local isLockPos=total_num<needUnlockPos

grid:SetChildActive(8,self.newFuDi[i]~=nil)

grid:SetChildText(0,name)
grid:SetChildUIModelShowTarget(4,model[1],model[2],{},eAnimationID.stand,false,nil,0)
local showReward=show2[i]
local rewardNum=#showReward
rewardNum=rewardNum>4 and 4 or rewardNum
grid:SetChildLayoutGroupCreateItems(1,rewardNum)
local itemlist=grid:GetChildLayoutGroupGridList(1)
for ri=1,rewardNum do
local item=itemlist[ri-1]
local r=showReward[ri]
local rn=r[2]
local conf={itemid=r[1],itemcount=rn>1 and rn or'',showCountBG=rn>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end
grid:SetChildActive(2,isLockPos)
if isLock then
grid:SetChildText(3,"")
else











end

if isLockPos then
if self.selectLockIdx==i then
self.progressBar:setActive(true)
self.progressBar:setProgressValue(total_num,needUnlockPos)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",total_num,needUnlockPos))
self.condtion:setText(FMT.fmt("累计探索{0}次可进行定位",needUnlockPos-total_num))
end
else
self.progressBar:setActive(false)
end
if self.selectLockIdx==i then
self.sureButton:setActive(lock_idx~=i)
end
grid:SetChildActive(7,lock_idx==i)
grid:SetChildActive(5,self.selectLockIdx==i)

grid:SetChildButtonClick(-1,function()
if self.selectLockIdx==i then
grid:SetChildActive(5,false)
self.selectLockIdx=0
self.posText:setText("")
self.canPos=true
local str='弟子将在'
local nList={}
for i,v in ipairs(lotteryList)do
if total_num>=v[1]then
nList[#nList+1]=nameList[i]
end
end
if#nList==#nameList then
str=FMT.fmt("{0}<color=#fd8950>所有福地</color>",str)
else
for i,v in ipairs(nList)do
if i<#nList then
str=FMT.fmt("{0}<color=#fd8950>{1},</color>",str,nameList[i])
else
str=FMT.fmt("{0}<color=#fd8950>{1}</color>",str,nameList[i])
end
end
end

str=FMT.fmt("{0}中探索",str)
self.posText:setText(str)

self.progressBar:setActive(false)
else
if self.selectLockIdx>0 then
local oldIdx=self.selectLockIdx
local ogrid=self.scrollView:getChildScrollViewItemWidget(oldIdx-1)
if ogrid then
ogrid:SetChildActive(5,false)
end
end
grid:SetChildActive(5,true)
self.selectLockIdx=i
self.posText:setText(FMT.fmt("弟子只会在<color=#fd8950>{0}</color>中探索",nameList[i]))

end
if isLockPos then
self.progressBar:setActive(true)
self.progressBar:setProgressValue(total_num,needUnlockPos)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",total_num,needUnlockPos))
self.condtion:setText(FMT.fmt("累计探索{0}次可进行定位",needUnlockPos-total_num))

self.canPos=nil
self.sureButton:setActive(false)
else
self.progressBar:setActive(false)
self.canPos=true
if self.selectLockIdx==i then
self.sureButton:setActive(lock_idx~=i)
else
self.sureButton:setActive(true)
end
end

end)

grid:SetChildNewBieComponentId(-1,'UISubAct_dongtianfudi_pos_win.fudiItem'..i)
end

if lock_idx==4 then
self.scrollView:setChildScrollViewSelectItem(3,false,true,true)
end
end







function UISubAct_dongtianfudi_pos_win:onSureButton()
if self.canPos then
activitiesHandle_dongtianfudi.sendPos(self.actid,self.subid,self.selectLockIdx)
if self.selectLockIdx>0 then
UIManager.info("定位成功")
end
self:closeSelf()
end
end



function UISubAct_dongtianfudi_pos_win:onCloseBtn()
self:closeSelf()
end

