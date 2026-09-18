







def_class("UIXianTuChengJiuWin",UIWindowBase)









function UIXianTuChengJiuWin:bindComponents()

self.webBackGround=UIImage.get(self,0)
self.shield=UIButton.get(self,1)
self.dzModel=UIObject.get(self,2)
self.gbLvUpReddot=UIObject.get(self,3)
self.gbExpProgress=UIProgress.get(self,4)
self.gbMaxLv=UIText.get(self,5)
self.gbLvUpBtn=UIButton.get(self,6)
self.gbLevelTx=UIText.get(self,7)
self.gbSkillDesc=UIText.get(self,8)
self.gbNameImage=UIImage.get(self,9)
self.gbIcon=UIImage.get(self,10)
self.gbEffect=UIObject.get(self,11)
self.gbAttrList=UIObject.get(self,12)
self.cjdNum=UIText.get(self,13)
self.root=UIObject.get(self,14)
self.gbRoot=UIObject.get(self,15)
self.gbBackground=UIObject.get(self,16)
self.allBtn=UIButton.get(self,17)
self.cjdIcon=UIImage.get(self,18)
self.helpBtn=UIButton.get(self,19)
self.taskList=UIObject.get(self,20)
self.tabList=UIObject.get(self,21)
self.taskScrollView=UIObject.get(self,22)

self.shield:setButtonClick(function()self:onShield()end)

self.gbLvUpBtn:setButtonClick(function()self:onGbLvUpBtn()end)

self.allBtn:setButtonClick(function()self:onAllBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIXianTuChengJiuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.webBackGround);self.webBackGround=nil;
_UIObject_release(self.shield);self.shield=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.gbLvUpReddot);self.gbLvUpReddot=nil;
_UIObject_release(self.gbExpProgress);self.gbExpProgress=nil;
_UIObject_release(self.gbMaxLv);self.gbMaxLv=nil;
_UIObject_release(self.gbLvUpBtn);self.gbLvUpBtn=nil;
_UIObject_release(self.gbLevelTx);self.gbLevelTx=nil;
_UIObject_release(self.gbSkillDesc);self.gbSkillDesc=nil;
_UIObject_release(self.gbNameImage);self.gbNameImage=nil;
_UIObject_release(self.gbIcon);self.gbIcon=nil;
_UIObject_release(self.gbEffect);self.gbEffect=nil;
_UIObject_release(self.gbAttrList);self.gbAttrList=nil;
_UIObject_release(self.cjdNum);self.cjdNum=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gbRoot);self.gbRoot=nil;
_UIObject_release(self.gbBackground);self.gbBackground=nil;
_UIObject_release(self.allBtn);self.allBtn=nil;
_UIObject_release(self.cjdIcon);self.cjdIcon=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.taskList);self.taskList=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.taskScrollView);self.taskScrollView=nil;
end
















local _this=nil
local _money=eMoneyType.mtXianTuAchieve
local _tabCmp={
owner=-1,
background=0,
selected=1,
reddot=2,
name1=3,
name2=4,
lock=5,
}
local _itemCmp={
name=0,
progress=1,
desc=2,
rewardList=3,
jumpBtn=4,
rewardBtn=5,
getted=6,
moneyIcon=7,
moneyNum=8,
effect1=9,
effect2=10,
}
local _ab="ui/windows/xiantuchengjiu/xiantuchengjiu_atlas_pak.ab"
local _changeProgress={
[taskTypeClientCheckType.eWorldLeadMaxHurt]=true
}



function UIXianTuChengJiuWin:onLoaded(...)
self:bindComponents()
_this=self


self.allBtn:setButtonClick(function()self:onAllBtn()end,nil,0)

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskProgress,self.onXianTuChengJiuTaskProgress)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskComplete)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskReward)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskOpen)
notifySystem:listenNotify(notifyConfig.onXianTuChengJiuSubOpen,self.onXianTuChengJiuSubOpen)
notifySystem:listenNotify(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoSkillLevelChange)
notifySystem:listenNotify(notifyConfig.onGuBaoActive,self.onGuBaoActive)

self.gbBackground:setChildUIModelShowTarget(4234,1,{},eAnimationID.stand,false,false,0)

self.loopListView=self.winlua:GetChildUILoopListView(self.taskScrollView:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.taskScrollView:getID())
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)

if webGLHelper:isRunWebGL()then
local abName=webGLHelper:getReplaceResourceAB('xianTuChengJiuBg')
self.webBackGround:setSprite(abName[1],abName[2])
else
self.root:setChildUIModelShowTarget(4221,1,{},eAnimationID.stand,false,false,0)
end

self.cjdIcon:setImageIcon(iconHelper.getIconName(_money),false)
self.cjdNum:setText(itemsModel.getCount(_money))
self:refreshDzModel()
self:initTabList()

end


function UIXianTuChengJiuWin:__delete()
self.loopListView:SetAction(nil,nil)
self.loopListView=nil
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuSystemInit,self.onXianTuChengJiuSystemInit)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskProgress,self.onXianTuChengJiuTaskProgress)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskComplete,self.onXianTuChengJiuTaskComplete)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskReward,self.onXianTuChengJiuTaskReward)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuTaskOpen,self.onXianTuChengJiuTaskOpen)
notifySystem:removelistener(notifyConfig.onXianTuChengJiuSubOpen,self.onXianTuChengJiuSubOpen)
notifySystem:removelistener(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoSkillLevelChange)
notifySystem:removelistener(notifyConfig.onGuBaoActive,self.onGuBaoActive)
end




function UIXianTuChengJiuWin:onShow(argtable,afterOnloaded)
self:doDzEnterAnimation()
if afterOnloaded then
if argtable and argtable.tab then
self:onClickTab(argtable.tab)
else
local cfg=cfg_xiantuachieveconfig()
for i,v in ipairs(cfg)do
if xiantuchengjiuModel:getXTCJReddot_Single(v.id)then
self:onClickTab(v.id)
return
end
end
self:onClickTab(1)
end
end
end


function UIXianTuChengJiuWin:onHide()

end

function UIXianTuChengJiuWin:onShowArgRecv(argtable)
self:doDzEnterAnimation()

local cfg=cfg_xiantuachieveconfig()
for i,v in ipairs(cfg)do
if xiantuchengjiuModel:getXTCJReddot_Single(v.id)then
self:onClickTab(v.id)
break
end
end
end


function UIXianTuChengJiuWin:onShield()
if self.rewardkeys==nil then return end

self:jumpAllTaskReward()
self.rewardkeys=nil

if next(self.refreshTabAfterReward)then
self:refreshTabListReddot(self.refreshTabAfterReward)
end
if self.refreshTaskAfterReward then
self:refreshAllTask()
end
self.shield:setActive(false)
end


function UIXianTuChengJiuWin:onGbLvUpBtn()
local config=cfgHelper.get1(cfg_xiantuachieveconfig_get,self.selected)
if xiantuchengjiuModel:getXTCJReddot_GuBao(self.selected)then
gubaoController:req_16_7(config.gubao)
else
UIManager.info(FMT.fmt("完成{0}的成就收集古宝经验即可升级",config.name))


AudioManager.playBtnClick()
end
end


function UIXianTuChengJiuWin:onAllBtn()
if self.rewardkeys then return end

local list={}
for i,v in ipairs(self.taskSortList)do
local key=v.key
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.XianTuChengJiu,self.selected,key)
if xiantuchengjiuModel:getTaskReddotEx(data)then
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local info={{eXianTuChengJiuTabType.XianTuChengJiu,self.selected,key},aimIdx}
table.insert(list,info)
end
end
xiantuchengjiuController.send_30_2(list)

if not next(list)then

AudioManager.playBtnClick()
end
end

function UIXianTuChengJiuWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='xiantuchengjiu_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIXianTuChengJiuWin.sortTabList(a,b)
if a.sort~=b.sort then
return a.sort<b.sort
else
return a.id<b.id
end
end

function UIXianTuChengJiuWin.sortTaskList(a,b)
if a.reddot~=b.reddot then
return a.reddot
elseif a.over~=b.over then
return b.over
elseif a.sort~=b.sort then
return a.sort<b.sort
else
return a.key<b.key
end
end

function UIXianTuChengJiuWin:jumpAllTaskReward()
for i,v in pairs(self.rewardkeys)do
if v then
local index=self:findTaskIndexByKey(i)
if index then

local item_loopData=self.loopListViewCmp:GetShownItemByItemIndex(index-1)
local taskItem=item_loopData and item_loopData.Widget or nil
if taskItem then
taskItem:SetChildAnimationStatus(_itemCmp.effect1,4)
taskItem:SetChildAnimationStatus(_itemCmp.effect2,4)
end
end
end
end
end

function UIXianTuChengJiuWin:initTabList()
self.tabSortList={}
local cfg=cfg_xiantuachieveconfig()
for i,v in pairs(cfg)do
table.insert(self.tabSortList,{id=v.id,sort=v.sort})
end
table.sort(self.tabSortList,self.sortTabList)
self.tabList:setChildLayoutGroupCreateItems(#self.tabSortList,function(index)
local tabItem=self.tabList:getChildLayoutGroupGridItem(index-1)
local id=self.tabSortList[index].id
local cfg=cfgHelper.get1(cfg_xiantuachieveconfig_get,id)
tabItem:SetChildButtonClick(_tabCmp.owner,function()
self:onClickTab(id)
end)
tabItem:SetChildText(_tabCmp.name1,cfg.name)
tabItem:SetChildText(_tabCmp.name2,cfg.name)
tabItem:SetChildActive(_tabCmp.selected,self.selected==id)
tabItem:SetChildActive(_tabCmp.background,self.selected~=id)
tabItem:SetChildActive(_tabCmp.reddot,xiantuchengjiuModel:getXTCJReddot_Single(id))
tabItem:SetChildActive(_tabCmp.lock,not xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.XianTuChengJiu,id))
end)
end

function UIXianTuChengJiuWin:refreshTabListReddot(idLookUp)
for i,v in ipairs(self.tabSortList)do
if not idLookUp or idLookUp[v.id]then
local tabItem=self.tabList:getChildLayoutGroupGridItem(i-1)
local id=v.id
tabItem:SetChildActive(_tabCmp.reddot,xiantuchengjiuModel:getXTCJReddot_Single(id))
end
end
end

function UIXianTuChengJiuWin:refreshTabSelect(index,active)
local tabItem=self.tabList:getChildLayoutGroupGridItem(index-1)
tabItem:SetChildActive(_tabCmp.selected,active)
tabItem:SetChildActive(_tabCmp.background,not active)
end

function UIXianTuChengJiuWin:onClickTab(id)
if self.rewardkeys then return end
if self.selected~=id then

if not xiantuchengjiuModel:checkOpen(eXianTuChengJiuTabType.XianTuChengJiu,id)then
local cfg=cfgHelper.get1(cfg_xiantuachieveconfig_get,id)
local warningStr=xiantuchengjiuModel:getConditionWarning(cfg.unlock,", ","","后解锁")
if warningStr then
return UIManager.error(warningStr)
end
return
end

if self.selected then
local oldIdx=self:findTabIndexById(self.selected)
self:refreshTabSelect(oldIdx,false)
end
self.selected=id
if self.selected then
local newIdx=self:findTabIndexById(self.selected)
self:refreshTabSelect(newIdx,true)
end

self:refreshGuBao(true)
self:refreshTaskList()
end
end

function UIXianTuChengJiuWin:refreshGuBao(isInit)
local config=cfgHelper.get1(cfg_xiantuachieveconfig_get,self.selected)
local gbid=config.gubao
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData==nil then
self.gbCost=nil
self.gbRoot:setActive(false)
return
end
self.gbRoot:setActive(true)
local level=gbData and gbData.gubaoskilllv or 0
local skilllv=gubaoModel:getSkillLv(gbid)
local skilldesc1,skilldesc2,skilldesc3=gubaoModel:getSkillDesc(gbid,skilllv)
if isInit then

local param=gbCfg.relevantPram.pram
self.gbIcon:setImageIcon(param.icon,true)
self.gbIcon:setChildAnchoredPos(config.gbPos[1],config.gbPos[2])
self.gbIcon:setScale(Vector3.one*config.gbScale)
self.gbEffect:setChildAnchoredPos(config.gbEffectPos[1],config.gbEffectPos[2])
self.gbEffect:setChildShowEffect(param.effectid,true)
self.gbNameImage:setSprite(_ab,config.gbNameImage)
self.gbNameImage:setChildAnchoredPos(config.gbNameImagePos[1],config.gbNameImagePos[2])
end

self.gbSkillDesc:setText(skilldesc1)

local attrLookup={}
gubaoModel:calculationAttrLookup(attrLookup,gbid,gbData.gubaolhlv,gbData.gubaostar,gbData.gubaojxlv,gbData.gubaoskilllv)
local attrs=attrListHelper.sortByLookup(attrLookup)
self.gbAttrList:setChildLayoutGroupCreateItems(#attrs+1,function(index)
local attrItem=self.gbAttrList:getChildLayoutGroupGridItem(index-1)
if index==1 then
attrItem:SetChildText(0,"等级：")
attrItem:SetChildText(1,tostring(level))
else
local attrData=attrs[index-1]
attrItem:SetChildText(0,FMT.fmt("{0}：",helper.getAttributeName(attrData[1])))
attrItem:SetChildText(1,helper.getAttributeStrEx(attrData[1],attrData[2],2))
end
end)

local maxLv=#gbCfg.level
local isMax=level>=maxLv
self.gbLvUpBtn:setActive(not isMax)
self.gbExpProgress:setActive(not isMax)
self.gbMaxLv:setActive(isMax)
if not isMax then
self.gbLvUpReddot:setActive(xiantuchengjiuModel:getXTCJReddot_GuBao(self.selected))
local cost=gbCfg.level[level][1]
self.gbCost=cost
local need=cost[2]
local have=itemsModel.getCount(cost[1])
self.gbExpProgress:setProgressValue(math.floor(math.min(have,need)/need*10000),10000)
self.gbExpProgress:setChildProgressText(FMT.fmt("{0}/{1}",mathHelper.formatNumber(have,true),mathHelper.formatNumber(need,true)))
end
end

function UIXianTuChengJiuWin:refreshGuBaoProgress()
if not self.gbCost then return end
local need=self.gbCost[2]
local have=itemsModel.getCount(self.gbCost[1])
self.gbLvUpReddot:setActive(xiantuchengjiuModel:getXTCJReddot_GuBao(self.selected))
self.gbExpProgress:setProgressValue(math.floor(math.min(have,need)/need*10000),10000)
self.gbExpProgress:setChildProgressText(FMT.fmt("{0}/{1}",mathHelper.formatNumber(have,true),mathHelper.formatNumber(need,true)))
end

function UIXianTuChengJiuWin:refreshTaskList()
local haveReddot=false
self.taskSortList={}
local datas=xiantuchengjiuModel:getTasksByTypeKey(eXianTuChengJiuTabType.XianTuChengJiu,self.selected)
for i,v in pairs(datas)do
if v.show then
local taskCfg=xiantuchengjiuModel:getTaskConfig(v.type,v.key1,v.key2)
local data=xiantuchengjiuModel:getTaskData(v.type,v.key1,v.key2)
local reddot=xiantuchengjiuModel:getTaskReddotEx(data)
local over=xiantuchengjiuModel:isTaskOverEx(data)
table.insert(self.taskSortList,{key=i,sort=taskCfg.order,reddot=reddot,over=over})
haveReddot=haveReddot or reddot
end
end
table.sort(self.taskSortList,self.sortTaskList)





local count=#self.taskSortList
local prefabNameList={}
local itemIdList={}
for i=1,count do
prefabNameList[i]="task"
itemIdList[i]=i
end
self.loopListView:InitDataList(count,prefabNameList,itemIdList,nil,nil)

self.winlua:SetChildGraphicGray(self.allBtn:getID(),not haveReddot)
end

function UIXianTuChengJiuWin:onStartView()

end

function UIXianTuChengJiuWin:onFreshListView(index,widget)
index=index+1
self:refreshTaskItem(widget,index,true)
end

function UIXianTuChengJiuWin:refreshAllTask()
local haveReddot=false
for i,v in ipairs(self.taskSortList)do
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.XianTuChengJiu,self.selected,v.key)
v.reddot=xiantuchengjiuModel:getTaskReddotEx(data)
v.over=xiantuchengjiuModel:isTaskOverEx(data)
haveReddot=haveReddot or v.reddot
end
table.sort(self.taskSortList,self.sortTaskList)
for i,v in ipairs(self.taskSortList)do
self:refreshTaskItem(nil,i,true)
end
self.winlua:SetChildGraphicGray(self.allBtn:getID(),not haveReddot)
end

function UIXianTuChengJiuWin:refreshTaskItem(widget,index,isInit)

if not widget then
local item_loopData=self.loopListViewCmp:GetShownItemByItemIndex(index-1)
widget=item_loopData and item_loopData.Widget or nil
end
local item=widget
if not item then return end
local key=self.taskSortList[index].key
local eType=eXianTuChengJiuTabType.XianTuChengJiu
local config=xiantuchengjiuModel:getTaskConfig(eType,self.selected,key)
local data=xiantuchengjiuModel:getTaskData(eType,self.selected,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local str=over and xiantuchengjiuModel:findTaskDescEx(config,#data.aims,true)or xiantuchengjiuModel:findTaskDescEx(config,aimIdx,true)
item:SetChildText(_itemCmp.desc,str)
local progressMax=over and data.aims[#data.aims]or aim
if _changeProgress[config.tasktype]then
progress=progress>=progressMax and 1 or 0
progressMax=1
end
item:SetChildProgressValue(_itemCmp.progress,math.floor(math.min(progress,progressMax)/progressMax*10000),10000)
item:SetChildProgressText(_itemCmp.progress,FMT.fmt("{0}/{1}",mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2)))
item:SetChildActive(_itemCmp.getted,over)
local rewardCfg=over and config.taskaims[#data.aims][2]or config.taskaims[aimIdx][2]
local speReward=nil
local norReward={}
for i,v in ipairs(rewardCfg)do
if v[1]==_money then
speReward=v
else
table.insert(norReward,v)
end
end
item:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,#norReward,function(index)
local rItem=item:GetChildLayoutGroupGridItem(_itemCmp.rewardList,index-1)
local rData=norReward[index]
local rId=rData[1]
local rNum=rData[2]
local showCountBG=rNum>1
local countStr=showCountBG and mathHelper.formatNumber(rNum)or''
local conf={itemid=rId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rItem:SetBaseItemClickEvent(-1,function(...)itemsComponentHelper.onItemClick(...)end)
rItem:SetChildPropData(-1,prop)
end)
if speReward then
item:SetChildCSImageIcon(_itemCmp.moneyIcon,iconHelper.getIconName(_money),false)
item:SetChildText(_itemCmp.moneyNum,FMT.fmt("x{0}",speReward[2]))
else
item:SetChildIcon(_itemCmp.moneyIcon,"",false)
item:SetChildText(_itemCmp.moneyNum,"")
end
local reddot=xiantuchengjiuModel:getTaskReddotEx(data)
item:SetChildActive(_itemCmp.jumpBtn,config.jump~=nil and not over and not reddot)
item:SetChildActive(_itemCmp.rewardBtn,not over and reddot)

if isInit then
item:SetChildText(_itemCmp.name,config.taskname)
item:SetChildButtonClick(_itemCmp.jumpBtn,function()
self:onClickJump(key)
end,true)
item:SetChildButtonClick(_itemCmp.rewardBtn,function()
self:onClickReward(key)
end,true,0)

item:SetChildAnimationStatus(_itemCmp.effect1,2)
item:SetChildAnimationStatus(_itemCmp.effect2,2)
end
end

function UIXianTuChengJiuWin:findTaskIndexByKey(key)
for i,v in ipairs(self.taskSortList)do
if v.key==key then
return i
end
end
end

function UIXianTuChengJiuWin:refreshTaskItemByKey(key,isInit)
local index=self:findTaskIndexByKey(key)
if index then
self:refreshTaskItem(nil,index,isInit)
end
end

function UIXianTuChengJiuWin:findTabIndexById(id)
for i,v in ipairs(self.tabSortList)do
if v.id==id then
return i
end
end
end

function UIXianTuChengJiuWin:refreshTaskProgressByKey(key)
local index=self:findTaskIndexByKey(key)
if index then
local eType=eXianTuChengJiuTabType.XianTuChengJiu

local item_loopData=self.loopListViewCmp:GetShownItemByItemIndex(index-1)
local item=item_loopData and item_loopData.Widget or nil
if not item then return end
local config=xiantuchengjiuModel:getTaskConfig(eType,self.selected,key)
local data=xiantuchengjiuModel:getTaskData(eType,self.selected,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local progressMax=over and data.aims[#data.aims]or aim
if _changeProgress[config.tasktype]then
progress=progress>=progressMax and 1 or 0
progressMax=1
end
item:SetChildProgressValue(_itemCmp.progress,math.floor(math.min(progress,progressMax)/progressMax*10000),10000)
item:SetChildProgressText(_itemCmp.progress,FMT.fmt("{0}/{1}",mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2)))
end
end

function UIXianTuChengJiuWin:refreshTaskStatusByKey(key)
local index=self:findTaskIndexByKey(key)
if index then
local eType=eXianTuChengJiuTabType.XianTuChengJiu

local item_loopData=self.loopListViewCmp:GetShownItemByItemIndex(index-1)
local item=item_loopData and item_loopData.Widget or nil
if not item then return end
local config=xiantuchengjiuModel:getTaskConfig(eType,self.selected,key)
local data=xiantuchengjiuModel:getTaskData(eType,self.selected,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local aim=data.aims[aimIdx]
local over=aim==nil
local progress=xiantuchengjiuModel:getTaskProgressShowEx(data)
local progressMax=over and data.aims[#data.aims]or aim
if _changeProgress[config.tasktype]then
progress=progress>=progressMax and 1 or 0
progressMax=1
end
item:SetChildProgressValue(_itemCmp.progress,math.floor(math.min(progress,progressMax)/progressMax*10000),10000)
item:SetChildProgressText(_itemCmp.progress,FMT.fmt("{0}/{1}",mathHelper.formatNumber5(progress,2),mathHelper.formatNumber5(progressMax,2)))
item:SetChildActive(_itemCmp.getted,over)
local reddot=xiantuchengjiuModel:getTaskReddotEx(data)
item:SetChildActive(_itemCmp.jumpBtn,config.jump~=nil and not over and not reddot)
item:SetChildActive(_itemCmp.rewardBtn,not over and reddot)
end
end

function UIXianTuChengJiuWin:onClickJump(key)
local config=xiantuchengjiuModel:getTaskConfig(eXianTuChengJiuTabType.XianTuChengJiu,self.selected,key)
if config.jump then
jumpManager:jump(config.jump)
end
end

function UIXianTuChengJiuWin:onClickReward(key)
if self.rewardkeys then return end
local data=xiantuchengjiuModel:getTaskData(eXianTuChengJiuTabType.XianTuChengJiu,self.selected,key)
local aimIdx=xiantuchengjiuModel:getTaskAimIndexEx(data)
local info={{eXianTuChengJiuTabType.XianTuChengJiu,self.selected,key},aimIdx}
xiantuchengjiuController.send_30_2({info})
end

function UIXianTuChengJiuWin.on_money_change(moneyType,lastVal,val)
if moneyType==_money then
_this.cjdNum:setText(val)
end
if _this.gbCost then
if moneyType==_this.gbCost[1]then
_this:refreshGuBaoProgress()
end
local lookup=cfg_lookupxiantuachieveconfig()
local idLookUp={}
for gbid,ids in pairs(lookup)do
local gbData=gubaoModel:getDataByID(gbid)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbid)
local level=gbData and gbData.gubaoskilllv or 1
local cost=gbCfg.level[level][1]
if cost[1]==moneyType then
for index,id in ipairs(ids)do
idLookUp[id]=true
end
end
end
_this:refreshTabListReddot(idLookUp)
end
end

function UIXianTuChengJiuWin.onXianTuChengJiuSystemInit()
_this:refreshTabListReddot()
_this:refreshAllTask()
end

function UIXianTuChengJiuWin.onXianTuChengJiuTaskProgress(list)
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.XianTuChengJiu and v[2]==_this.selected then
_this:refreshTaskProgressByKey(v[3])
end
end
end

function UIXianTuChengJiuWin.onXianTuChengJiuTaskComplete(list)
local tab={}
local refresh=false
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.XianTuChengJiu then
tab[v[2]]=true
if v[2]==_this.selected then
refresh=true
end
end
end
if next(tab)then
_this:refreshTabListReddot(tab)
end
if refresh then
_this:refreshAllTask()
end
end

function UIXianTuChengJiuWin:playTaskRewardEffect(key,callback)
local index=self:findTaskIndexByKey(key)
if index then

local item_loopData=self.loopListViewCmp:GetShownItemByItemIndex(index-1)
local item=item_loopData and item_loopData.Widget or nil
if item then
item:SetChildAnimationStringID(_itemCmp.effect1,"xiantuchengjiu_reward_effect_add",true,nil)
item:SetChildAnimationStatus(_itemCmp.effect1,1)
item:SetChildAnimationStringID(_itemCmp.effect2,"xiantuchengjiu_reward_effect_alpha",true,function()
if callback then
callback(key)
end
end)
item:SetChildAnimationStatus(_itemCmp.effect2,1)
return
end
end

if callback then
callback(key)
end
end

function UIXianTuChengJiuWin.onXianTuChengJiuTaskReward(list)
_this.rewardkeys={}
_this.refreshTabAfterReward={}
_this.refreshTaskAfterReward=false
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.XianTuChengJiu then
_this.refreshTabAfterReward[v[2]]=true
if v[2]==_this.selected then
_this.refreshTaskAfterReward=true
_this.rewardkeys[v[3]]=true
end
end
end
local func=function(key)
if _this==nil or _this.rewardkeys==nil then return end
_this.rewardkeys[key]=false

for i,v in pairs(_this.rewardkeys)do
if v then
return
end
end

_this.rewardkeys=nil

if next(_this.refreshTabAfterReward)then
_this:refreshTabListReddot(_this.refreshTabAfterReward)
end
if _this.refreshTaskAfterReward then
_this:refreshAllTask()
end
_this.shield:setActive(false)
end

local show=next(_this.rewardkeys)~=nil
if show then
_this.shield:setActive(true)
for i,v in pairs(_this.rewardkeys)do
_this:playTaskRewardEffect(i,func)
end
else
_this.rewardkeys=nil
end
end

function UIXianTuChengJiuWin.onXianTuChengJiuTaskOpen(list)
local tab={}
local check=false
for i,v in ipairs(list)do
if v[1]==eXianTuChengJiuTabType.XianTuChengJiu then
tab[v[2]]=true
if v[2]==_this.selected then
check=true
end
end
end
if check then
_this:refreshTaskList()
end
if next(tab)then
_this:refreshTabListReddot(tab)
end
end

function UIXianTuChengJiuWin.onXianTuChengJiuSubOpen(list)
_this:initTabList()
end

function UIXianTuChengJiuWin.onGuBaoSkillLevelChange(gbid,skilllv)
local config=cfgHelper.get1(cfg_xiantuachieveconfig_get,_this.selected)
if gbid==config.gubao then
_this:refreshGuBao(false)
end

local lookup=cfgHelper.get1(cfg_lookupxiantuachieveconfig_get,gbid)
if lookup then
local temp={}
for i,v in ipairs(lookup)do
temp[v]=true
end
_this:refreshTabListReddot(temp)
end
end

function UIXianTuChengJiuWin.onGuBaoActive(gbid)
local lookup=cfgHelper.get1(cfg_lookupxiantuachieveconfig_get,gbid)
if lookup and lookup[1]==_this.selected then
_this:refreshGuBao(true)
end
end

function UIXianTuChengJiuWin:refreshDzModel()
local temp=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)or{}
local firstData=temp[1]or UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(firstData.discipleguid,false,1)
self.dzModel:setChildUIModelShowTarget(modelParams.body,0.7,modelParams.componets,eAnimationID.stand,false,false,0)
self.dzModel:setChildUIModelShowFlipX(true)
end

function UIXianTuChengJiuWin:doDzEnterAnimation()
self.dzModel:setChildAnchoredPos(-50,4)
self.dzModel:setChildModelAnimationState(eAnimationID.run)
self.dzModel:setChildDOAnchorPosX(114,1,function()
if _this then
self.dzModel:setChildModelAnimationState(eAnimationID.stand)
end
end)
self.dzModel:setChildUIModelShowColor(Color.New(1,1,1,0))
self.winlua:SetChildUIModelShowFadeToColor(self.dzModel:getID(),Color.white,1,0,nil)
end