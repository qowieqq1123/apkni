







def_class("UIXYJiShiSubWin_XingYu",UIWindowBase)









function UIXYJiShiSubWin_XingYu:bindComponents()

self.noItemTips=UIText.get(self,0)
self.root=UIObject.get(self,1)
self.Scroller=UILoopListView.new(self,2)

self.Scroller:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXYJiShiSubWin_XingYu:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.root);self.root=nil;
self.Scroller:deleteSelf();self.Scroller=nil;
end
















local prefabNames={
[LOGTYPE.eFewReward]="scrollerItem_reward",
[LOGTYPE.eTanSuoBigReward]="scrollerItem_reward",
}

local refreshFuncName={
[LOGTYPE.eFewReward]="refreshFunc_FewReward",
[LOGTYPE.eTanSuoBigReward]="refreshFunc_TanSuoBigReward",
}



function UIXYJiShiSubWin_XingYu:onLoaded(...)
self:bindComponents()
end


function UIXYJiShiSubWin_XingYu:__delete()
self:unbindComponents()
end




function UIXYJiShiSubWin_XingYu:onShow(argtable,afterOnloaded)
local xyId=argtable.xyId
if self.xyId==xyId then
return
end
self.xyId=xyId
self.lastOpenTime=XingYuController.getOpenXYLogTime(xyId)
XingYuController.setOpenXYLogTime(self.xyId)




local list=XingYuModel:getXingYuData_xyLogList(xyId)
if list and#list>0 then
self.noItemTips:setActive(false)
local tempList={}
local prefabnameList={}
for i,temp in ipairs(list)do
local name=prefabNames[temp.logType]
if not name then
logErr("prefabNames 为 nil",temp.logType)
return
end
table.insert(prefabnameList,name)
end
self.Scroller:initDataEx(prefabnameList,list)
else
self.Scroller:initData(nil,nil,0)
self.noItemTips:setActive(true)
end
end


function UIXYJiShiSubWin_XingYu:onHide()

end

function UIXYJiShiSubWin_XingYu:refreshFunc_FewReward(item,data)

local args=data.args
local evnid=args[1]
local evncfg=cfg_xingyueventconfig_get(evnid)
local result=evncfg.result
local desc=evncfg.desc
local sNmae=loginModel:getServerName(args[2])
local fewItemId=evncfg.fewShowItem
local item_config=itemsConfig.getConfig(fewItemId)

local itemName=FMT.cfmt(item_config.color,"[{0}]",item_config.name)
local descStr=FMT.fmt(desc,sNmae,args[3],itemName)
descStr=FMT.fmt("<size=22>{0}</size>",descStr)
if evncfg.triCondition then
local _cndStr=XingYuController.getTriConditionStr(evncfg.triCondition)
descStr=FMT.fmt("{0}\n \n<size=22><color=#7D3B17>（{1}）</color></size>",descStr,_cndStr)
end
item:SetChildText(2,descStr)

local itemList={}
for i,v in ipairs(result[2])do
local color=itemsConfig.getItemColor(v[1])
table.insert(itemList,{v[1],v[2],showStage=true,color=color})
end
table.sort(itemList,function(a,b)
return a.color>b.color
end)

item:SetChildLayoutGroupCreateItems(4,#itemList,function(index)
local rewardItem=item:GetChildLayoutGroupGridItem(4,index-1)
local rewardData=itemList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)

local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2
end

function UIXYJiShiSubWin_XingYu:refreshFunc_TanSuoBigReward(item,data)

local args=data.args
local tsRId=args[3]
local tsRCfg=cfg_xingyutansuorewardconfig_get(tsRId)
local desc=tsRCfg.zxDesc
local sNmae=loginModel:getServerName(args[1])
local fewItemId=tsRCfg.zxItemId
local item_config=itemsConfig.getConfig(fewItemId)

local itemName=FMT.cfmt(item_config.color,"[{0}]",item_config.name)
local descStr=FMT.fmt(desc,sNmae,args[2],itemName)
descStr=FMT.fmt("<size=22>{0}</size>",descStr)




item:SetChildText(2,descStr)

local itemList={}
for i,v in ipairs(tsRCfg.items)do
local color=itemsConfig.getItemColor(v[1])
table.insert(itemList,{v[1],v[2],showStage=true,color=color})
end
table.sort(itemList,function(a,b)
return a.color>b.color
end)

item:SetChildLayoutGroupCreateItems(4,#itemList,function(index)
local rewardItem=item:GetChildLayoutGroupGridItem(4,index-1)
local rewardData=itemList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)

local logTime=data.logTime
local lastTime=self.lastOpenTime
if lastTime and logTime and logTime>lastTime then
item:SetChildActive(5,true)
else
item:SetChildActive(5,false)
end

return 0,1,2
end

function UIXYJiShiSubWin_XingYu:onFreshAction(index,widget,data)
local item=widget

local funcName=refreshFuncName[data.logType]
local itemCmpIndex,bgCmpIndex,contentCmpIndex
if funcName and self[funcName]then
itemCmpIndex,bgCmpIndex,contentCmpIndex=self[funcName](self,item,data)
else
logErr("UIXYJiShiSubWin_XingYu refreshFuncName 没有刷新方法",data.logType)
end

if bgCmpIndex and itemCmpIndex then
item:ForceLayoutVertical(contentCmpIndex)
local bgY=item:GetChildRectHeight(bgCmpIndex)
local itemHiget=bgY+4
item:SetChildSizeDelta(itemCmpIndex,1053,itemHiget)
item:FreshChildLayoutRectThree(contentCmpIndex)
else
logErr("UIXYJiShiSubWin_XingYu bgCmpIndex or itemCmpIndex")
end
end


function UIXYJiShiSubWin_XingYu:onStartAction()
end



