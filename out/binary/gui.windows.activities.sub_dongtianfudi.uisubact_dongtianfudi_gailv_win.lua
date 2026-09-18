







def_class("UISubAct_dongtianfudi_gailv_Win",UIWindowBase)









function UISubAct_dongtianfudi_gailv_Win:bindComponents()

self.animRoot=UIObject.get(self,0)
self.ListPanel=UIObject.get(self,1)
self.leftRoot=UIObject.get(self,2)
self.progressBar=UIProgress.get(self,3)
self.name=UIText.get(self,4)
self.model=UIImage.get(self,5)
self.unlockText=UIText.get(self,6)



end


function UISubAct_dongtianfudi_gailv_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
end



















local modelSpine={{4726,0.55,2},{4727,0.6,15},{4728,0.6,2},{4729,0.7,15},}

function UISubAct_dongtianfudi_gailv_Win:onLoaded(...)
self:bindComponents()
end


function UISubAct_dongtianfudi_gailv_Win:__delete()
self:unbindComponents()
end




function UISubAct_dongtianfudi_gailv_Win:onShow(argtable,afterOnloaded)
local fudiIndex=argtable.fudiIndex
local args=argtable.args
self.fudiIndex=fudiIndex

if not self.config then
self.actid=args.act_id
self.subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
self.subid=args.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
end

if args.initWin then
self.animRoot:setLocalPosY(-638)
local tween=self.animRoot:setChildDOLocalMoveY(0,0.325)
tween:SetDelay(0.12)
self.animRoot:setChildCanvasGroupAlpha(0)
local tween=self.animRoot:setChildCanvasGroupDOFade(1,0.325)
tween:SetDelay(0.12)
end

self:setInfo()
self:setReward()
end

function UISubAct_dongtianfudi_gailv_Win:setInfo()
local modelList=modelSpine
local fudiIndex=self.fudiIndex
local model=modelList[fudiIndex]
self.model:setChildUIModelShowTarget(model[1],0.7,{},eAnimationID.stand,false,nil,0)

local nameList=self.config.name
local name=nameList[fudiIndex]
self.name:setText(name)

local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local total_num=data.total_num
local lotteryList=self.config.lotteryList
local lottery=lotteryList[fudiIndex]
local needLo=lottery[1]
local isUnlock=total_num>=needLo
self.progressBar:setActive(not isUnlock)
self.progressBar:setProgress(total_num,needLo)
self.progressBar:setChildProgressText(FMT.fmt("{0}/{1}",total_num,needLo))
self.unlockText:setText(FMT.fmt("累计探索{0}次解锁",needLo))
end

function UISubAct_dongtianfudi_gailv_Win:setReward()
local showList=self.config.show2[self.fudiIndex]
self.ListPanel:setChildScrollViewCreateGrids(#showList,4)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=showList[i]
local itemId=data[1]
local num=data[2]
local gailv=data[3]
local rare=data[4]

local conf={itemid=itemId,itemcount=num>1 and num or'',showCountBG=num>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)

item:SetChildText(1,FMT.fmt("{0}%",gailv))
item:SetChildActive(2,rare==1)
end
end



function UISubAct_dongtianfudi_gailv_Win:onHide()

end



