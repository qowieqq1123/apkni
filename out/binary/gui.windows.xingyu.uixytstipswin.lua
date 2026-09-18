







def_class("UIXYTSTipsWin",UIWindowBase)









function UIXYTSTipsWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.rewardList=UIObject.get(self,1)
self.rewardView=UIObject.get(self,2)
self.desc=UIText.get(self,3)
self.chakanBtn=UIButton.get(self,4)
self.root=UIObject.get(self,5)
self.bgModel=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.chakanBtn:setButtonClick(function()self:onChakanBtn()end)



end


function UIXYTSTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.chakanBtn);self.chakanBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end



















function UIXYTSTipsWin:onLoaded(...)
self:bindComponents()
self.bgModel:setChildUIModelShowTarget(5653,1,nil,eAnimationID.enter,false,false,0,function()
self:delayDo(0.5,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end)
end


function UIXYTSTipsWin:__delete()
self:unbindComponents()
end




function UIXYTSTipsWin:onShow(argtable,afterOnloaded)

local xyId=argtable.xyId


self.xyId=xyId

local allRewardList={}













local tsrwList=argtable.tsrwList
local lookUp={}
for _,v in ipairs(tsrwList)do
local rwId=v.param_1
local teamIndex=v.param_2
local addValue=XingYuController.getXingYuTeamAdd_TeamIndex(xyId,teamIndex)

local items=cfgHelper.get(cfg_xingyutansuorewardconfig_get,rwId,"items")
for __,v2 in ipairs(items)do
local itemId=v2[1]
local num=v2[2]
if lookUp[itemId]then
lookUp[itemId]=lookUp[itemId]+num
else
lookUp[itemId]=num
end
end

local items2=cfgHelper.get(cfg_xingyutansuorewardconfig_get,rwId,"items2")
for __,v2 in ipairs(items2)do
local itemId=v2[1]
local num=math.ceil(v2[2]*(1+addValue))
if lookUp[itemId]then
lookUp[itemId]=lookUp[itemId]+num
else
lookUp[itemId]=num
end
end

end

for k,v in pairs(lookUp)do
local color=itemsConfig.getItemColor(k)
table.insert(allRewardList,{k,v,showStage=true,color=color})
end
table.sort(allRewardList,function(a,b)
return a.color>b.color
end)


self.rewardList:setChildLayoutGroupCreateItems(#allRewardList,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=allRewardList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)


local xingyuLog=argtable.xingyuLog
local args=jsonHelper.decode(xingyuLog.jsonStr)
local lastEventId=args[1]
local evncfg=cfg_xingyueventconfig_get(lastEventId)
local logType=xingyuLog.logType
if evncfg and evncfg.few==1 then
logType=LOGTYPE.eFewReward
end
local desc=evncfg.desc
local descStr
if logType==LOGTYPE.eFewReward then
descStr=string.replace(string.replace(desc,"[{0}]",""),"{1}","")
descStr=string.replace(descStr,"{2}","{0}")
local fewItemId=evncfg.fewShowItem
local item_config=itemsConfig.getConfig(fewItemId)

local itemName=FMT.cfmt(item_config.color,"[{0}]",item_config.name)
descStr=FMT.fmt(descStr,itemName)
else
descStr=desc
end
self.desc:setText(descStr)
end


function UIXYTSTipsWin:onHide()

end





function UIXYTSTipsWin:onCloseBtn()
self:closeSelf()
end



function UIXYTSTipsWin:onChakanBtn()
local xyId=self.xyId
XingYuController.req_35_104(xyId)
self:onCloseBtn()
end
