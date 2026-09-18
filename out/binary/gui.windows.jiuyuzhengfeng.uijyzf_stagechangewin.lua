







def_class("UIJYZF_StageChangeWin",UIWindowBase)









function UIJYZF_StageChangeWin:bindComponents()

self.lastRoot=UIObject.get(self,0)
self.curRoot=UIObject.get(self,1)
self.rewardRoot=UIObject.get(self,2)
self.lastRewardLayout=UIObject.get(self,3)
self.curRewardLayout=UIObject.get(self,4)
self.changeflag=UIObject.get(self,5)
self.lasScrollView=UIObject.get(self,6)
self.curScrollView=UIObject.get(self,7)
self.model=UIObject.get(self,8)



end


function UIJYZF_StageChangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lastRoot);self.lastRoot=nil;
_UIObject_release(self.curRoot);self.curRoot=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.lastRewardLayout);self.lastRewardLayout=nil;
_UIObject_release(self.curRewardLayout);self.curRewardLayout=nil;
_UIObject_release(self.changeflag);self.changeflag=nil;
_UIObject_release(self.lasScrollView);self.lasScrollView=nil;
_UIObject_release(self.curScrollView);self.curScrollView=nil;
_UIObject_release(self.model);self.model=nil;
end















local abName="ui/windows/jiuyuzhengfeng/jyzf_atlas_pak.ab"



function UIJYZF_StageChangeWin:onLoaded(...)
self:bindComponents()
self.rewardLayoutList={
self.lastRewardLayout,
self.curRewardLayout
}
end


function UIJYZF_StageChangeWin:__delete()
self:unbindComponents()
end




function UIJYZF_StageChangeWin:onShow(argtable,afterOnloaded)
local lastLevel=argtable.lastLevel
local curLevel=argtable.curLevel
self:setInfo(lastLevel,curLevel)
self:playAnim(lastLevel,curLevel)
end


function UIJYZF_StageChangeWin:onHide()
end

function UIJYZF_StageChangeWin:playAnim(lastLevel,curLevel)






















local func=function(delayTime)
self:delayDo(delayTime,function()
if not self or self.isClose then
return
end

self.curRoot:setChildCanvasGroupDOFade(1,2)
self.rewardRoot:setChildCanvasGroupDOFade(1,2)
end)
end

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),true,true,true)
end
local curcfg=cfg_xianyulevelcconfig_get(curLevel)
local curModel=curcfg.model

if lastLevel==0 then
self.model:setChildUIModelShowTarget(curModel,1,nil,eAnimationID.enter)
func(2)
else
local lastcfg=cfg_xianyulevelcconfig_get(lastLevel)
local lastModel=lastcfg.model
self.model:setChildUIModelShowTarget(lastModel,1,nil,3426)
self:delayDo(2.5,function()
if not self or self.isClose then
return
end
self.model:setChildUIModelShowTarget(curModel,1,nil,eAnimationID.enter)
end)
func(4.5)
end

end

function UIJYZF_StageChangeWin:setInfo(lastLevel,curLevel)

local lastcfg=cfg_xianyulevelcconfig_get(lastLevel)


local curWidget=self.curRoot:getWidgetBase()
local curcfg=cfg_xianyulevelcconfig_get(curLevel)


curWidget:SetChildCSImageSprite(0,abName,curcfg.imgName)
local upFlag=lastLevel==0 or curLevel<lastLevel
curWidget:SetChildActive(1,upFlag)
curWidget:SetChildActive(2,not upFlag)

local rList={}
if lastLevel==0 then
self.changeflag:setActive(false)
self.curScrollView:setActive(false)
rList[1]=curcfg.level_reward
else
self.changeflag:setActive(true)
self.curScrollView:setActive(true)
rList[1]=lastcfg.level_reward
rList[2]=curcfg.level_reward
end
for i,obj in ipairs(self.rewardLayoutList)do
if rList[i]then
local itemList=rList[i]
obj:setChildLayoutGroupCreateItems(#itemList,function(index)
local item=obj:getChildLayoutGroupGridItem(index-1)
local rewardData=itemList[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
else
obj:setChildLayoutGroupClearAllItems()
end
end
end



