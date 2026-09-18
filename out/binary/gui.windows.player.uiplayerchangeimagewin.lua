







def_class("UIPlayerChangeImageWin",UIWindowBase)









function UIPlayerChangeImageWin:bindComponents()

self.imageTitle=UIText.get(self,0)
self.ScrollView=UIScrollViewSlow.get(self,1)
self.imageTitleRoot=UIObject.get(self,2)
self.unlockBtn=UIButton.get(self,3)
self.unlockCreater=UIObject.get(self,4)
self.unlockTxt=UIText.get(self,5)
self.unlockRoot=UIObject.get(self,6)
self.tabCreater=UIObject.get(self,7)
self.pageCreater=UIObject.get(self,8)
self.lefttime=UIText.get(self,9)
self.costNum=UIText.get(self,10)
self.costIcon=UIObject.get(self,11)
self.model=UIObject.get(self,12)
self.costRoot=UIObject.get(self,13)
self.desc=UIText.get(self,14)
self.btnRevert=UIButton.get(self,15)
self.btnChange=UIButton.get(self,16)
self.btnRange=UIButton.get(self,17)
self.timeRoot=UIObject.get(self,18)
self.suitbtn=UIButton.get(self,19)
self.activeTipRoot=UIObject.get(self,20)
self.liandonBtn=UIButton.get(self,21)
self.timeBg=UIObject.get(self,22)
self.timeTxt=UIText.get(self,23)
self.suitbtnReddot=UIObject.get(self,24)

self.unlockBtn:setButtonClick(function()self:onUnlockBtn()end)

self.btnRevert:setButtonClick(function()self:onBtnRevert()end)

self.btnChange:setButtonClick(function()self:onBtnChange()end)

self.btnRange:setButtonClick(function()self:onBtnRange()end)

self.suitbtn:setButtonClick(function()self:onSuitbtn()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)



end


function UIPlayerChangeImageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.imageTitle);self.imageTitle=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.imageTitleRoot);self.imageTitleRoot=nil;
_UIObject_release(self.unlockBtn);self.unlockBtn=nil;
_UIObject_release(self.unlockCreater);self.unlockCreater=nil;
_UIObject_release(self.unlockTxt);self.unlockTxt=nil;
_UIObject_release(self.unlockRoot);self.unlockRoot=nil;
_UIObject_release(self.tabCreater);self.tabCreater=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.btnRevert);self.btnRevert=nil;
_UIObject_release(self.btnChange);self.btnChange=nil;
_UIObject_release(self.btnRange);self.btnRange=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.suitbtn);self.suitbtn=nil;
_UIObject_release(self.activeTipRoot);self.activeTipRoot=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.suitbtnReddot);self.suitbtnReddot=nil;
end

















local _colomn=4

function UIPlayerChangeImageWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
self.ScrollView:setSlowClickAction(function(...)self:onScrollItemClick(...)end)
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.costItemid={}
mathHelper.randomSeed()
end

function UIPlayerChangeImageWin:__delete()
self:unbindComponents()
playerImageModel:readAllImageByTab(self.selectTab)
end

function UIPlayerChangeImageWin:onShow(argtable,afterOnloaded)
self:refreshSuitReddot()
self:showWindow("UITopMaskWin")
local tabid=argtable and argtable.tabid or PLAYER_IMAGE_TYPE.eFace

local playerImage=argtable and argtable.playerImage or playerImageModel:getPreviewPlayerImage()or
playerImageModel:getPlayerImage()or
playerImageModel:getDefaultImage()
self.playerImage=playerImage
for tabid,id in pairs(playerImage)do
playerImageModel:readImage(tabid,id)
end
self.pageid=playerImageConfig.getPageByTabId(tabid)
self.selectTab=tabid
self:freshInfo()
end

function UIPlayerChangeImageWin:onHide()

end




function UIPlayerChangeImageWin:onSuitbtn()
self:showWindow("UIPlayerChangeSuitWin")
end

function UIPlayerChangeImageWin:onLiandonBtn()
UIManager:showWindow('UITipLianDonWin',{linkageId=self.linkageId})
end

function UIPlayerChangeImageWin:onBtnRange()
local sex=playerModel:getActorSex()
local plist={}
local tablist={}
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
tablist[#tablist+1]=tabid
end
local version=pfwindowslController:getGameVersion()
if version==pfwindowslController.sdkPFVersion.game_oumei then
table.sort(tablist,function(a,b)return a<b end)
local skincolor=nil
for _,tabid in ipairs(tablist)do
local cfgs=playerImageConfig.getAllSubConfig(sex,tabid)
local weights={}
for _,v in ipairs(cfgs)do
weights[#weights+1]=v.weight
end
local Skintable=nil
if skincolor then

Skintable=playerImageModel:GetSkintable(sex,skincolor,tabid)
if Skintable then
weights={}
for k,v in pairs(Skintable)do
local cfg=playerImageConfig.getSubConfig(tabid,v)
weights[#weights+1]=cfg.weight
end
end
end
local num=0
while true do
local index=mathHelper.weightRandom(weights)
local id=nil
if not Skintable then
id=cfgs[index].id
else
id=Skintable[index]
end
if playerImageModel:isUnlockImage(tabid,id)and
(not playerImageModel:isSupportImageTab(plist,tabid)or
playerImageModel:isSupportImage(plist,tabid,id))then
plist[tabid]=id
if not Skintable then
if cfgs[index].skincolor and not skincolor then

skincolor=cfgs[index].skincolor
end
end
break
end
num=num+1
if num>50 then
local id=playerImageConfig.getDefaultImage(tabid,sex)

plist[tabid]=id
if not Skintable then
if cfgs[index].skincolor and not skincolor then

skincolor=cfgs[index].skincolor
end
end
break
end
end
end
else
table.sort(tablist,function(a,b)return a<b end)
for _,tabid in ipairs(tablist)do
local cfgs=playerImageConfig.getAllSubConfig(sex,tabid)
local weights={}
for _,v in ipairs(cfgs)do
weights[#weights+1]=v.weight
end
local num=0
while true do
local index=mathHelper.weightRandom(weights)
local id=cfgs[index].id
if playerImageModel:isUnlockImage(tabid,id)and
(not playerImageModel:isSupportImageTab(plist,tabid)or
playerImageModel:isSupportImage(plist,tabid,id))then
plist[tabid]=id
break
end
num=num+1
if num>50 then
local id=playerImageConfig.getDefaultImage(tabid,sex)

plist[tabid]=id
break
end
end
end
end
self.playerImage=plist
playerImageModel:savePreviewPlayerImage(plist)
self:freshModel()
self:freshGirds()
self:freshUnlockPanel()
end



function UIPlayerChangeImageWin:onBtnChange()
local needItemsList={}
local needItemsLookup={}
local activeList={}
local playerImage=table.deepCopy(self.playerImage)
for i,v in ipairs(playerImage)do
if not playerImageModel:isUnlockImage(i,v)then
local cfg=playerImageConfig.getSubConfig(i,v)
if cfg and cfg.cost then
local cost=cfg.cost
for _,v in ipairs(cost)do
local itemid=v[1]
local need=v[2]
local index=needItemsLookup[itemid]
if index==nil then
needItemsList[#needItemsList+1]={itemid,need}
needItemsLookup[itemid]=#needItemsList
else
needItemsList[index][2]=needItemsList[index][2]+need
end
end
end
activeList[#activeList+1]={i,v}
end
end


if#needItemsList>0 then
local args={
title='提示',
rewardTitle="",
isCost=true,
desc1='部分形象未解锁，需使用以下道具',
rewards=needItemsList,
showCancel=true,
commitName='确定',
commitCB=function()
for _,v in ipairs(needItemsList)do
local itemid=v[1]
local need=v[2]
if itemsModel.getCount(itemid)<need then
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足，祖师可重选形象',name))
gainControl:showGainWin(itemid)
return
end
end
local callback=function()
for i,v in ipairs(playerImage)do
if not playerImageModel:isUnlockImage(i,v)then return end
end
playerImageController:reqSetPlayerImage(playerImage)
end
playerImageController:reqUnlockImage(activeList,callback)
end,
}
self:showWindow('UIDialougeRewardWin',args)
return
end

local playerImage=self.playerImage
local func=function()
playerImageController:reqSetPlayerImage(playerImage)
end


local cnt=playerImageModel:getLeftCnt()
if cnt<=0 then
local cost=playerImageConfig.getPlayerImageCost()
for i,v in ipairs(cost)do
local itemid=v[1]
local need=v[2]
local has=itemsModel.getCount(itemid)
local name=itemsModel.getName(itemid)
if has<need then
UIManager.error(FMT.fmt('{0}不足,无法重塑肉身',name))
gainControl:showGainWin(itemid)
return
else
self.dialogue=UIDialogManager.getConfirmDialog(self.dialogue,'提示',FMT.fmt('确定消耗{0}{1}修改形象吗？',need,name))
self.dialogue.okcallback=func
self.dialogue:show()
return
end
end
end
func()
end



function UIPlayerChangeImageWin:onBtnRevert()
local lastPlayerImage=self.playerImage
local playerImage=playerImageModel:getPlayerImage()
if table.equals(lastPlayerImage,playerImage)then
UIManager.info('当前形象无需复原')
return
end

local tabid=self.selectTab
local lastId=self.playerImage[tabid]
local id=playerImage[tabid]
self.playerImage=playerImage
playerImageModel:savePreviewPlayerImage()
self:freshModel()
self:freshSelect(tabid,lastId)
self:freshSelect(tabid,id)
self:freshUnlockPanel()
self:freshImageTitle()
self:freshTimeTxt()
end

function UIPlayerChangeImageWin:onUnlockBtn()
local tabid=self.selectTab
local id=self.playerImage[tabid]
if playerImageModel:isUnlockImage(tabid,id)then
local tabName=playerImageConfig.getSubTabName(tabid)
UIManager.info('该{0}已解锁',tabName)
return
end
local ret,args=playerImageModel:isCanUnlockImage(tabid,id)
if not ret then
if args==nil then return end
local itemid=args[1]
local name=itemsModel.getName(itemid)
local tabName=playerImageConfig.getSubTabName(tabid)
UIManager.error(FMT.fmt('{0}不足,无法激活当前{1}',name,tabName))
gainControl:showGainWin(itemid)
return
end
playerImageController:reqUnlockImage({{tabid,id}})
end

function UIPlayerChangeImageWin:onScrollItemClick(id,index,guid,attach)
if id==-1 then return end
local tabid=self.selectTab
if self.playerImage[tabid]==id then return false end

local lastId=self.playerImage[tabid]
playerImageModel:readImage(tabid,id)
self:freshNewTag(tabid,id)
if not self:changeModel(tabid,id)then return end
self:freshUnlockPanel()
self:freshSelect(tabid,lastId)
self:freshSelect(tabid,id)
self:freshPageBtns()
self:freshSubTabBtns()
self:freshImageTitle()
self:freshTimeTxt()
UIManager:callWindowFunc('UIPlayerInfoWin','refreshImageReddot')
UIManager:callWindowFunc('UIMain','refreshActorHeadReddot')
end

function UIPlayerChangeImageWin:onChangePage(pageid)
if pageid==self.selectPage then return end
local lastPage=self.pageid
playerImageModel:readAllImageByTab(self.selectTab)
self.pageid=pageid
local tablist=playerImageConfig.getAllSubTabId(pageid)
self.selectTab=tablist[1]
self.isSetZero=nil
self:freshPageBtns()
self:freshSubTabBtns()
self:freshGirds()
self:freshUnlockPanel()
self:freshImageTitle()
self:freshTimeTxt()
end

function UIPlayerChangeImageWin:onChangeSubTab(tabid)
if tabid==self.selectTab then return end
playerImageModel:readAllImageByTab(self.selectTab)
self.selectTab=tabid
self.isSetZero=nil
self:freshPageBtns()
self:freshSubTabBtns()
self:freshGirds()
self:freshUnlockPanel()
self:freshImageTitle()
self:freshTimeTxt()
end

function UIPlayerChangeImageWin:onUnlockRet(list)
local flag=false
for i,v in ipairs(list)do
if v.param_1==self.selectTab then
flag=true
break
end
end
if flag then
self:freshGirds()
self:freshUnlockPanel()
self:freshTimeTxt()
end
end

function UIPlayerChangeImageWin:onSetPlayerImage()
self:freshCost()
end

function UIPlayerChangeImageWin:onItemListChanged(args)
local flag=false
for i,v in ipairs(args)do
if self.costItemid[v[3]]==true then
flag=true
break
end
end
if flag then
self:freshCost()
end
end


function UIPlayerChangeImageWin:freshInfo()
self:freshPageBtns()
self:freshSubTabBtns()
self:freshGirds()
self:freshUnlockPanel()
self:freshCost()
self:freshImageTitle()
self:freshSuitBtn()
self:freshActiveTip()
self:freshTimeTxt()
self:freshModel()
end

function UIPlayerChangeImageWin:freshModel()
local sex=playerModel:getActorSex()
self.linkageId=liandonModel:getLianDonLinkageIdByPlayerImage(self.playerImage,sex)
self.liandonBtn:setActive(self.linkageId>0)
playerImageController.setPlayerModel(self.winlua,self.model:getID(),self.playerImage,1,eAnimationID.idle,0,0,playerController:supportDynamic())
end

function UIPlayerChangeImageWin:changeNewModel()
local tabid=self.selectTab
local lastId=self.playerImage[tabid]
local playerImage=playerImageModel:getPlayerImage()or
playerImageModel:getDefaultImage()
self.playerImage=playerImage
local id=self.playerImage[tabid]
playerImageModel:readImage(tabid,id)
self:freshSelect(tabid,lastId)
self:freshSelect(tabid,id)
end

function UIPlayerChangeImageWin:changeModel(tabid,id)
local ret,args=playerImageModel:isSupportImage(self.playerImage,tabid,id)
if not ret then
local errcode=args[1]
local r_tabid=args[2]
local r_id=args[3]
local tabName=playerImageConfig.getSubTabName(r_tabid)
if errcode==1 or errcode==2 then
UIManager.error(FMT.fmt('当前{0}不可重塑该形象',tabName))
end
return false
end

self.playerImage[tabid]=id
playerImageModel:savePreviewPlayerImage(self.playerImage)
self:freshModel()
return true
end

function UIPlayerChangeImageWin:freshUnlockPanel()
local tabid=self.selectTab
local id=self.playerImage[tabid]
local isUnlock=playerImageModel:isUnlockImage(tabid,id)
self.unlockRoot:setActive(not isUnlock)
if isUnlock then return end

local tabName=playerImageConfig.getSubTabName(tabid)
self.unlockTxt:setText(FMT.fmt('所选{0}需解锁方能使用',tabName))
local sex=playerModel:getActorSex()
local cost=playerImageConfig.getUnlockCost(tabid,id)
local len=cost and#cost or 0
self.unlockCreater:setChildLayoutGroupCreateItems(len,function(index)
local item=self.unlockCreater:getChildLayoutGroupGridItem(index-1)
local data=cost[index]
local itemid=data[1]
local need=data[2]
local has=itemsModel.getCount(itemid)
local enough=has>=need
local countStr=enough and FMT.fmt('{0}/{1}',has,need)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',has,need)
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
end)
end

function UIPlayerChangeImageWin:freshImageTitle()
local tabid=self.selectTab
local id=self.playerImage[tabid]
local pageid=playerImageConfig.getPageByTabId(tabid)
local name=playerImageConfig.getPageCfg(pageid).name
local ret=playerImageModel:isNotSupportAllTab(tabid,id)
if ret then
local tabName=playerImageConfig.getSubTabName(tabid)
self.imageTitleRoot:setActive(true)
self.imageTitle:setText(FMT.fmt('当前{0}不可重塑{1}',tabName,name))
else

local ret,imageTab=playerImageModel:isSupportImageTab(self.playerImage,tabid)
if not ret then
local imageId=self.playerImage[imageTab]
local ret=playerImageModel:isNotSupportAllTab(imageTab,imageId)
local tabName=playerImageConfig.getSubTabName(imageTab)
if ret then
self.imageTitleRoot:setActive(true)
self.imageTitle:setText(FMT.fmt('当前{0}不可重塑{1}',tabName,name))
else
local tabName1=playerImageConfig.getSubTabName(tabid)
self.imageTitleRoot:setActive(true)
self.imageTitle:setText(FMT.fmt('当前{0}不可重塑{1}',tabName,tabName1))
end
else
self.imageTitleRoot:setActive(false)
end
end
end

function UIPlayerChangeImageWin:freshTimeTxt()
local tabid=self.selectTab
local id=self.playerImage[tabid]
local ret,imageTab=playerImageModel:isSupportImageTab(self.playerImage,tabid)
local tabName=playerImageConfig.getSubTabName(tabid)
local stamp=timeHelper.getServerShortTime()
local time=playerImageModel:getPiTime(tabid,id)
self.timeBg:setActive(time>stamp)
local timeStr=timeHelper.format_time_stamp18(time-stamp)
self.timeTxt:setText(FMT.fmt("{0}：{1}",tabName,timeStr))
end

function UIPlayerChangeImageWin:freshGirds()
local sex=playerModel:getActorSex()
local tabid=self.selectTab
local cfgs=playerImageConfig.getAllSubConfig(sex,tabid)
local temp={}
local selectId=self.playerImage[tabid]
local has=false
for i,v in ipairs(cfgs)do
if self:showImage(tabid,v.id)then
temp[#temp+1]=v
has=has or v.id==selectId
end
end

if not has then
self.playerImage[tabid]=cfgs[1].id
end
self.itemCfgs=self:sortCfgs(temp)
local tNum=#self.itemCfgs
local row=math.ceil(tNum/_colomn)
self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(tNum,row,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIPlayerChangeImageWin:sortCfgs(cfgs)
local sortTag={}
local tabid=self.selectTab
local temp={}
for i,v in ipairs(cfgs)do
local id=v.id
local isUnlock=playerImageModel:isUnlockImage(tabid,id)
local isSupportImage=playerImageModel:isSupportImage(self.playerImage,tabid,id)
local unlockflag=isUnlock and isSupportImage and 1 or 0
local newflag=playerImageModel:isNewImage(tabid,id)and 1 or 0
sortTag[id]=newflag*100000+unlockflag*1000+i
temp[#temp+1]=v
end
table.sort(temp,function(a,b)
return sortTag[a.id]>sortTag[b.id]
end)
return temp
end

function UIPlayerChangeImageWin:bindGrid(index,item)
local itemCfg=self.itemCfgs[index]
local tabid=self.selectTab
local id=itemCfg.id
local bgspine=itemCfg.bgspine
local spineid=itemCfg.spineid
local sex=playerModel:getActorSex()

local isLD=liandonModel:getLianDonLinkageIdByPlayerImageItem(tabid,id)>0
local imageCfg=playerImageConfig.getSubConfig(tabid,id)
local isUnlock=playerImageModel:isUnlockImage(tabid,id)
local isSupportImage=playerImageModel:isSupportImage(self.playerImage,tabid,id)
local isSelect=id==self.playerImage[tabid]
local isNew=playerImageModel:isNewImage(tabid,id)
local isDynamic=imageCfg and imageCfg.dynamicSpineID~=nil or
imageCfg and imageCfg.skeletonID~=nil
local scale=bgspine and bgspine[2]or 1
local offsetX=bgspine and bgspine[3]or 0
local offsetY=bgspine and bgspine[4]or 0
local components={}
if tabid==PLAYER_IMAGE_TYPE.eFace or bgspine==nil then
components={spineid}
else
components={bgspine[1],spineid}
end

item:SetChildActive(0,not isUnlock)
item:SetChildActive(1,true)
item:SetChildActive(2,isSelect)
item:SetChildText(3,index)
item:SetChildActive(4,isNew)
self:setChildPlayerPreviewIcon(item,5,sex,components,scale,offsetX,offsetY)
item:SetChildActive(7,not isSupportImage)
item:SetChildActive(8,not isNew and isDynamic)
item:SetChildActive(9,isLD)
item:SetBaseItemChildID(-1,id)




end

function UIPlayerChangeImageWin:setChildPlayerPreviewIcon(item,index,sex,components,scale,offsetX,offsetY,bodyID)
local body=playerImageConfig.getPlayerImageBody(sex)


item:SetChildUIModelShowTarget(index,
body,
scale,
components,
eAnimationID.idle,
true,
false,
0)
if offsetX~=0 or offsetY~=0 then
item:SetChildUIModelShowTargetOffset(index,offsetX,offsetY)
end
end

function UIPlayerChangeImageWin:getIndex(id)
for i,v in ipairs(self.itemCfgs)do
if v.id==id then
return i
end
end
end

function UIPlayerChangeImageWin:freshSelect(tabid,id)
if id==nil then return end
if self.selectTab~=tabid then return end
local index=self:getIndex(id)
if index==nil then return end

local isSelect=id==self.playerImage[tabid]
local item=self.ScrollView:getSlowItemByIndex(index-1)
if item then
item:SetChildActive(2,isSelect)
end
end

function UIPlayerChangeImageWin:freshNewTag(tabid,id)
if id==nil then return end
if self.selectTab~=tabid then return end
local index=self:getIndex(id)
if index==nil then return end
local item=self.ScrollView:getSlowItemByIndex(index-1)
if item then
local isNew=playerImageModel:isNewImage(tabid,id)
local imageCfg=playerImageConfig.getSubConfig(tabid,id)
local isDynamic=imageCfg and imageCfg.dynamicSpineID~=nil or
imageCfg and imageCfg.skeletonID~=nil
item:SetChildActive(4,isNew)
item:SetChildActive(8,not isNew and isDynamic)
end
end

function UIPlayerChangeImageWin:freshPageBtns()
local cfgs=playerImageConfig.getAllPageCfgs()
local len=#cfgs
self.pageCreater:setChildLayoutGroupCreateItems(len,function(index)
local item=self.pageCreater:getChildLayoutGroupGridItem(index-1)
local cfg=cfgs[index]
local name=cfg.name
local pageid=cfg.id

item:SetChildButtonClick(0,function()
self:onChangePage(pageid)
end)
local isSelect=pageid==self.pageid
local reddot=playerImageModel:hasAnyNewImageInPage(pageid)
item:SetChildActive(1,isSelect)
item:SetChildText(2,isSelect and name or FMT.cfmt2('#F5AF6C',name))
item:SetChildActive(3,reddot)
end)
end

function UIPlayerChangeImageWin:freshSubTabBtns()
local pageid=self.pageid
local tablist=playerImageConfig.getAllSubTabId(pageid)
local len=#tablist
self.tabCreater:setChildLayoutGroupCreateItems(len,function(index)
local item=self.tabCreater:getChildLayoutGroupGridItem(index-1)
local tabid=tablist[index]
local tabCfg=playerImageConfig.getSubTabCommonCfg(tabid)
local name=tabCfg.name
local hasNew=playerImageModel:hasAnyNewImage(tabid)

item:SetChildButtonClick(0,function()
self:onChangeSubTab(tabid)
end)
local isSelect=tabid==self.selectTab
item:SetChildActive(1,not isSelect)
item:SetChildActive(2,isSelect)
item:SetChildText(3,not isSelect and name or FMT.cfmt2('#46180c',name))
item:SetChildActive(4,hasNew)
item:SetChildActive(5,not playerImageModel:isSupportImageTab(self.playerImage,tabid))
end)
end

function UIPlayerChangeImageWin:freshCost()
local cost=playerImageConfig.getPlayerImageCost()
local itemid=cost[1][1]
self.costItemid[itemid]=true
local need=cost[1][2]

local cnt,use,max=playerImageModel:getLeftCnt()

local desc=cnt>0 and FMT.fmt('每周次数：{0}/{1}',cnt,max)or''
self.desc:setText(desc)
self.costRoot:setActive(cnt<=0)
self.timeRoot:setActive(cnt<=0)
if cnt<=0 then
local has=itemsModel.getCount(itemid)
local iconName=iconHelper.getIconName(itemid)
local enough=need<=has
self.costIcon:setIcon(iconName,false)
self.costNum:setText(enough and FMT.fmt('{0}/{1}',has,need)or
FMT.cfmt(FONT_COLOR.eRedColor,'{0}/{1}',has,need))
self.lefttime:setText('每周一5点重置免费次数')
end
end

function UIPlayerChangeImageWin:showImage(tabid,id)
local isHideInPage=playerImageConfig.isHideInPage(tabid,id)
if isHideInPage then return false end

local isUnlock=playerImageModel:isUnlockImage(tabid,id)
if isUnlock then return true end

local cost=playerImageConfig.getUnlockCost(tabid,id)
local len=cost and#cost or 0
if len==0 then return isUnlock end
local enough=true
for i,v in ipairs(cost or{})do
local data=v
local itemid=data[1]
local need=data[2]
local has=itemsModel.getCount(itemid)
enough=enough and has>=need
end
return enough
end

function UIPlayerChangeImageWin:freshSuitBtn()
local activeState=playerImageModel:getSuitActiveState()
self.suitbtn:setActive(activeState)
end

function UIPlayerChangeImageWin:freshActiveTip()
if self.isStartShowActiveTip then return end
self.isStartShowActiveTip=true
local bagPlayerImageChangeItems=itemsLookup:getItemsByBag(item_funtion_type.playerimage)
self.activeTipRoot:setActive(#bagPlayerImageChangeItems>0)
if#bagPlayerImageChangeItems>0 then
self.activeShowQueue={}
local lookup={}
for k,itemCfg in pairs(bagPlayerImageChangeItems)do
if lookup[itemCfg.id]==nil then
self.activeShowQueue[#self.activeShowQueue+1]=itemCfg
lookup[itemCfg.id]=true
end
end

self:showActiveTip()
end
end

function UIPlayerChangeImageWin:showActiveTip()

local itemCfg,pos=table.remove(self.activeShowQueue,1)
local itemid=itemCfg.id
local conf={itemid=itemid,showCountBG=false,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local activeWidget=self.activeTipRoot:getChildWidgetBase()
activeWidget:SetBaseItemClickEvent(2,function(...)
itemsComponentHelper.onItemClick(...)
end)
activeWidget:SetChildText(3,itemCfg.name)
activeWidget:SetChildActive(3,true)
activeWidget:SetChildPropData(2,prop)
local closePanel=function()

if#self.activeShowQueue>0 then
activeWidget:SetChildCanvasGroupAlpha(-1,1)
activeWidget:SetChildCanvasGroupDOFade(-1,0,1,function()
self:showActiveTip()
activeWidget:SetChildCanvasGroupDOFade(-1,1,1,nil)
end)
else
activeWidget:SetChildCanvasGroupDOFade(-1,0,1,function()
self.activeTipRoot:setActive(false)
end)
end
end

activeWidget:SetChildButtonClick(0,function()
closePanel()
end)

activeWidget:SetChildButtonClick(1,function()




bagProtocolControl.req_use_item(itemid,1)
closePanel()
end)

end




























function UIPlayerChangeImageWin:refreshSuitReddot()
self.suitbtnReddot:setActive(playerImageModel:checkSuitAttrActiveReddot())
end
