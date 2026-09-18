







def_class("UISubAct_JiuCengYaoLouSelectWin",UIWindowBase)









function UISubAct_JiuCengYaoLouSelectWin:bindComponents()

self.bgClick=UIButton.get(self,0)
self.itemPanel=UIObject.get(self,1)
self.jixian=UIObject.get(self,2)
self.ctText=UIText.get(self,3)
self.upRoot=UIObject.get(self,4)
self.help=UIToggleButton.get(self,5)
self.EffectGridList=UIObject.get(self,6)
self.citiaoScroller=UIObject.get(self,7)
self.effectItem=UIObject.get(self,8)
self.fightButton=UIButton.get(self,9)
self.selectNum=UIText.get(self,10)
self.helpText=UIText.get(self,11)
self.Content=UIObject.get(self,12)
self.upText=UIText.get(self,13)
self.jxFightButton=UIButton.get(self,14)

self.bgClick:setButtonClick(function()self:onBgClick()end)

self.fightButton:setButtonClick(function()self:onFightButton()end)

self.jxFightButton:setButtonClick(function()self:onJxFightButton()end)



end


function UISubAct_JiuCengYaoLouSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgClick);self.bgClick=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jixian);self.jixian=nil;
_UIObject_release(self.ctText);self.ctText=nil;
_UIObject_release(self.upRoot);self.upRoot=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.EffectGridList);self.EffectGridList=nil;
_UIObject_release(self.citiaoScroller);self.citiaoScroller=nil;
_UIObject_release(self.effectItem);self.effectItem=nil;
_UIObject_release(self.fightButton);self.fightButton=nil;
_UIObject_release(self.selectNum);self.selectNum=nil;
_UIObject_release(self.helpText);self.helpText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.upText);self.upText=nil;
_UIObject_release(self.jxFightButton);self.jxFightButton=nil;
end



















function UISubAct_JiuCengYaoLouSelectWin:onLoaded(...)
self:bindComponents()


self.helpText:setText(cfgHelper.get1(cfg_lang_get,'ui_jiucengyaolou_help'))



end

function UISubAct_JiuCengYaoLouSelectWin:onHelp()





end


function UISubAct_JiuCengYaoLouSelectWin:__delete()
self:unbindComponents()
end




function UISubAct_JiuCengYaoLouSelectWin:onShow(argtable,afterOnloaded)

self.actid=argtable.actid
self.subType=argtable.subType
self.subid=argtable.subid
self.floor=argtable.floor
self.fightCallback=argtable.fightCallback

self.citiaoList=argtable.floorData.citiaoList
self.effect=argtable.floorData.effect
self.itemData=argtable.floorData.floorCfg[6]or{}
self.selectNumData=argtable.floorData.floorCfg[2]
self.isLast=self.selectNumData==0
self.allEffect=argtable.floorData.allEffect
self.startTime=argtable.startTime
self.ruleData=argtable.floorData.ruleData

self.enterSelect=argtable.enterSelect

local num=activitiesHandle_jiucengyaolou:get_jixianCiTiaoNum(self.subid,self.floor)
self.jixianNum=num

self:initSelectCiTiaoList()

self.passCount=activitiesHandle_jiucengyaolou:getPassData(self.actid,self.subid,self.floor)or 0

self:sortItemList()


if self.isLast then
self:showPanel2()
else
self:showPanel1()
end

if self.enterSelect then
self:onFightButton()
end
end


function UISubAct_JiuCengYaoLouSelectWin:showPanel1()
self.panelType=1
self:showEffect()
self.itemPanel:setActive(false)

self:refreshNum()
self:refreshButton()
self:showCiTiao()
end


function UISubAct_JiuCengYaoLouSelectWin:showPanel2()
self.panelType=2
self.selectNumData=#self.citiaoList
self:showEffect()
self.itemPanel:setActive(true)
self.selectNum:setText("")
self:showCiTiao()

self:showItemPanel()
end

function UISubAct_JiuCengYaoLouSelectWin:refreshNum()
local length=self.selectCiTiaoList.length
if length>=self.selectNumData then
self.selectNum:setText(FMT.fmt("需要选择至少{0}种魔化效果才可挑战（<color=#549327>{1}/{2}</color>）",self.selectNumData,length,self.selectNumData))
else
self.selectNum:setText(FMT.fmt("需要选择至少{0}种魔化效果才可挑战（<color=#c82c2c>{1}/{2}</color>）",self.selectNumData,length,self.selectNumData))
end
end

function UISubAct_JiuCengYaoLouSelectWin:showEffect()
local list={}
local allEffectLookup={}
if self.allEffect then
for i,v in ipairs(self.allEffect)do
table.insert(list,v)
allEffectLookup[v]=true
end
end
if self.effect then
for i,v in ipairs(self.effect)do
table.insert(list,v)
end
end
self.EffectGridList:setChildLayoutGroupCreateItems(#list,function(index)
local item=self.EffectGridList:getChildLayoutGroupGridItem(index-1)
if item then
local effect=list[index]

local ruleCfg=cfgHelper.getSSlawRule(effect)

local icon=ruleCfg.image
local name=ruleCfg.name
local desc=ruleCfg.desc


item:SetChildActive(3,allEffectLookup[effect]~=nil)
item:SetChildIcon(0,icon,false)
item:SetChildText(1,FMT.fmt("{0}：{1}",name,desc))
end
end)
self.EffectGridList:setChildSizeDelta(1066,80*#self.citiaoList)
end

function UISubAct_JiuCengYaoLouSelectWin:showCiTiao()
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eJiuCengYaoLou,table.concat({self.actid,self.subid,self.startTime,self.floor},"_"),nil)
if saveData then
self:initSelectCiTiaoList()
local max=#self.citiaoList
for i,v in ipairs(saveData)do
if v[2]<=max and self.citiaoList[v[2]]==v[1]then
self:addSelectCiTiaoList(self.citiaoList[v[2]],v[2])
end
end
end
self:refreshRule()

local isJiXian=self.jixianNum and self.selectCiTiaoList.length>=self.jixianNum
self.jixian:setActive(isJiXian)
self.citiaoScroller:setChildLayoutGroupCreateItems(#self.citiaoList,function(index)
local item=self.citiaoScroller:getChildLayoutGroupGridItem(index-1)
if item then
local id=self.citiaoList[index]
local ruleCfg=cfgHelper.getSSlawRule(id)

if ruleCfg then
local icon=ruleCfg.image
local name=ruleCfg.name
local desc=ruleCfg.desc

item:SetChildIcon(0,icon,false)
item:SetChildText(1,FMT.fmt("{0}： {1}",name,desc))

local selected=self:getSelectCiTiaoListData(id)
item:SetChildActive(2,selected~=nil)
item:SetChildActive(3,selected~=nil)
item:SetChildButtonClick(4,function()
self:onCitiaoClick(1,index-1)
end)
end
end
end)
self.citiaoScroller:setChildSizeDelta(1066,57*#self.citiaoList)
self.ctText:setText(FMT.fmt("已选效果：{0}/{1}",self.selectCiTiaoList.length,#self.citiaoList))
if self.panelType==1 then
self:refreshButton()
self:refreshNum()
else
self:showItemPanel()
end
end

function UISubAct_JiuCengYaoLouSelectWin:refreshButton()
local enable=self.selectCiTiaoList.length>=self.selectNumData
self.fightButton:setButtonEnable(enable,not enable)
end

function UISubAct_JiuCengYaoLouSelectWin:onCitiaoClick(clicknum,index)
local citiao=self.citiaoList[index+1]

local grid=self.citiaoScroller:getChildLayoutGroupGridItem(index)
local selected=self:getSelectCiTiaoListData(citiao)
if selected then
self:removeSelectCiTiaoList(citiao)
if grid then
grid:SetChildActive(2,false)
grid:SetChildActive(3,false)
end

self:refreshRule()
else

self:addSelectCiTiaoList(citiao,index+1)
if grid then
grid:SetChildActive(2,true)
grid:SetChildActive(3,true)
end
self:refreshRule()

end
if self.panelType==1 then
self:refreshButton()
self:refreshNum()
elseif self.panelType==2 then
self:showItemPanel()
end
self.ctText:setText(FMT.fmt("已选效果：{0}/{1}",self.selectCiTiaoList.length,#self.citiaoList))
local isJiXian=self.jixianNum and self.selectCiTiaoList.length>=self.jixianNum
self.jixian:setActive(isJiXian)
end

function UISubAct_JiuCengYaoLouSelectWin:selectCiTiaoAll(isOn)
local isNew=false
for index,citiao in pairs(self.citiaoList)do
local ruleCfg=cfgHelper.getSSlawRule(citiao)
if ruleCfg then
local grid=self.citiaoScroller:getChildLayoutGroupGridItem(index-1)
local selected=self:getSelectCiTiaoListData(citiao)
if isOn and not selected then
isNew=true
self:addSelectCiTiaoList(citiao,index)
if grid then
grid:SetChildActive(2,true)
grid:SetChildActive(3,true)
end
elseif not isOn and selected then
isNew=true
self:removeSelectCiTiaoList(citiao)
if grid then
grid:SetChildActive(2,false)
grid:SetChildActive(3,false)
end
end
end
end
if isNew then
self:refreshRule()
if self.panelType==1 then
self:refreshButton()
self:refreshNum()
elseif self.panelType==2 then
self:showItemPanel()
end
self.jixian:setActive(isOn)
self.ctText:setText(FMT.fmt("已选效果：{0}/{1}",self.selectCiTiaoList.length,#self.citiaoList))
end
end

function UISubAct_JiuCengYaoLouSelectWin:initSelectCiTiaoList()
self.selectCiTiaoList={length=0}
end

function UISubAct_JiuCengYaoLouSelectWin:addSelectCiTiaoList(key,value)
self.selectCiTiaoList[key]=value
self.selectCiTiaoList.length=self.selectCiTiaoList.length+1


end

function UISubAct_JiuCengYaoLouSelectWin:removeSelectCiTiaoList(key)
self.selectCiTiaoList[key]=nil
self.selectCiTiaoList.length=self.selectCiTiaoList.length-1


end

function UISubAct_JiuCengYaoLouSelectWin:getSelectCiTiaoListData(key)
return self.selectCiTiaoList[key]
end



function UISubAct_JiuCengYaoLouSelectWin:getSelectCiTiaoList()
local list={}
for i,v in pairs(self.selectCiTiaoList)do
if i~="length"then
table.insert(list,v)
end
end
return list
end

function UISubAct_JiuCengYaoLouSelectWin:refreshRule()
if self.ruleData then
local length=self.selectCiTiaoList.length
local rule=self.ruleData[length]
if rule then
local ruleCfg=cfgHelper.getSSlawRule(rule[1])
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[1]and next(descparm[1])then
desc=string.format(desc,unpack(descparm[1]))
end
self.upText:setText(desc)
self.upRoot:setActive(true)
else
self.upRoot:setActive(false)
end
end
end

function UISubAct_JiuCengYaoLouSelectWin:showItemPanel()
local itemList=self.itemList
if itemList then
local count=#itemList
self.itemPanel:setChildScrollViewCreateGrids(count,count)

local selectedLength=self.selectCiTiaoList.length

local grids=self.itemPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
if itemList[i+1]then
local num=itemList[i+1].num
local gou=self.passCount>=num
local reward=itemList[i+1].reward[1]
local rewardNum=reward[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1

local gray=(num>selectedLength and not gou)and 1 or 0

local conf={itemid=reward[1],showCountBG=showCountBG,itemcount=countStr,showStage=true,showname=false,itemIndex=i,gray=gray}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,self.onClickItem)
item:SetChildPropData(0,prop)
item:SetChildActive(1,gou)
end
end

end
end

function UISubAct_JiuCengYaoLouSelectWin.onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end


function UISubAct_JiuCengYaoLouSelectWin:sortItemList()
local itemList={}
for num,v in pairs(self.itemData)do
table.insert(itemList,{num=num,reward=v})
end
table.sort(itemList,function(a,b)
return a.num<b.num
end)
self.itemList=itemList
end


function UISubAct_JiuCengYaoLouSelectWin:onHide()

end





function UISubAct_JiuCengYaoLouSelectWin:onBgClick()
self:closeSelf()
end



function UISubAct_JiuCengYaoLouSelectWin:onFightButton()
local length=self.selectCiTiaoList.length
if self.panelType==1 then

if length<self.selectNumData then
UIManager.error("词条数量未满足")
else
if self.fightCallback then
local list=self:getSelectCiTiaoList()
self:onSave()
self.fightCallback(list)
end
end
elseif self.panelType==2 then
if self.fightCallback then
local list=self:getSelectCiTiaoList()
self:onSave()
self.fightCallback(list)
end
end
end

function UISubAct_JiuCengYaoLouSelectWin:onJxFightButton()
self:selectCiTiaoAll(true)
if self.fightCallback then
local list=self:getSelectCiTiaoList()
self:onSave()
self.fightCallback(list)
end
end

function UISubAct_JiuCengYaoLouSelectWin:onSave()
local saveData={}
for i,v in pairs(self.selectCiTiaoList)do
if i~="length"then
table.insert(saveData,{i,v})
end
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eJiuCengYaoLou,table.concat({self.actid,self.subid,self.startTime,self.floor},"_"),saveData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eJiuCengYaoLou)

end

function UISubAct_JiuCengYaoLouSelectWin:onHelpButton()

end