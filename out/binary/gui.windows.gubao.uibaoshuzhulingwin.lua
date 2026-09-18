







def_class("UIBaoShuZhuLingWin",UIWindowBase)









function UIBaoShuZhuLingWin:bindComponents()

self.autoUpgradeBtn=UIButton.get(self,0)
self.autoUpgradeBtnReddot=UIObject.get(self,1)
self.baseAttrGrid=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.costObj=UIObject.get(self,4)
self.costTitle=UIText.get(self,5)
self.fullLevelImg=UIObject.get(self,6)
self.progressBar=UIProgressBarAni.get(self,7)
self.progressBarReverse=UIProgressBarAni.get(self,8)
self.progressCount=UIText.get(self,9)
self.progressCountMax=UIText.get(self,10)
self.progressCountReverse=UIText.get(self,11)
self.root=UIObject.get(self,12)
self.selectBtn=UIButton.get(self,13)
self.selectGrid=UIObject.get(self,14)
self.speAttrGrid=UIObject.get(self,15)
self.upgradeBtn=UIButton.get(self,16)
self.upgradeBtnReddot=UIObject.get(self,17)
self.upgradeEffect=UIObject.get(self,18)

self.autoUpgradeBtn:setButtonClick(function()self:onAutoUpgradeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.upgradeBtn:setButtonClick(function()self:onUpgradeBtn()end)



end


function UIBaoShuZhuLingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.autoUpgradeBtn);self.autoUpgradeBtn=nil;
_UIObject_release(self.autoUpgradeBtnReddot);self.autoUpgradeBtnReddot=nil;
_UIObject_release(self.baseAttrGrid);self.baseAttrGrid=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.fullLevelImg);self.fullLevelImg=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressBarReverse);self.progressBarReverse=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.progressCountMax);self.progressCountMax=nil;
_UIObject_release(self.progressCountReverse);self.progressCountReverse=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.selectGrid);self.selectGrid=nil;
_UIObject_release(self.speAttrGrid);self.speAttrGrid=nil;
_UIObject_release(self.upgradeBtn);self.upgradeBtn=nil;
_UIObject_release(self.upgradeBtnReddot);self.upgradeBtnReddot=nil;
_UIObject_release(self.upgradeEffect);self.upgradeEffect=nil;
end


















local _this=nil

function UIBaoShuZhuLingWin:onLoaded(...)
self:bindComponents()
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBSZLReddot,true)
_this=self
end


function UIBaoShuZhuLingWin:__delete()
self:unbindComponents()
_this=nil
end




function UIBaoShuZhuLingWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
self.curLevel,self.curExp=gubaoModel:getBSZLData()
self.curLevel=self.curLevel<=0 and 1 or self.curLevel
self.curLevelCfg=cfgHelper.get1(cfg_baoshuzhulinglevelconfig_get,self.curLevel)
self.maxLevel=#cfg_baoshuzhulinglevelconfig()
self.nextLevel=self.curLevel
self.addExp=0
self.maxExp=gubaoModel:getBSZLMaxLevelNeedExp()
self.goodList={}
self.goodColorList={}

self:initConsumeList()
self:refreshExpProgress()
self:refreshZhuLingAttrs()
end

function UIBaoShuZhuLingWin:zhulingBack()
self.progressAni=true
self.progressReverseAni=true
self:onShow()
self.upgradeEffect:setChildShowEffect(22686,true)
end

function UIBaoShuZhuLingWin:refreshZhuLingAttrs()
self.baseAttrList={}
self.speAttrList={}
local baseAttrs=self.curLevelCfg.attrs
local nextLevelCfg=nil
if self.nextLevel and self.nextLevel>self.curLevel then
nextLevelCfg=cfgHelper.get1(cfg_baoshuzhulinglevelconfig_get,self.nextLevel)
table.insert(self.baseAttrList,{string.format("等级：%d",self.curLevel),self.nextLevel})
else
table.insert(self.baseAttrList,{string.format("等级：%d",self.curLevel)})
end
local nextBaseAttrs=nextLevelCfg and nextLevelCfg.attrs or baseAttrs
for i,v in ipairs(baseAttrs)do
local attrKey,attrVal=unpack(v)
local nextVal=nextBaseAttrs[i][2]
local attrStr=helper.getAttributeStr(attrKey,attrVal,1,"{0}：{1}")
if nextVal>attrVal then
local nextAttrStr=helper.getAttributeStrEx(attrKey,nextVal,1)
table.insert(self.baseAttrList,{attrStr,nextAttrStr})
else
table.insert(self.baseAttrList,{attrStr})
end
end

self.baseAttrGrid:setChildLayoutGroupCreateItems(#self.baseAttrList,function(index)
local item=self.baseAttrGrid:getChildLayoutGroupGridItem(index-1)
local val,nextVal=unpack(self.baseAttrList[index])
item:SetChildText(0,val)
if nextVal then
item:SetChildActive(1,true)
item:SetChildText(1,nextVal)
else
item:SetChildActive(1,false)
end
end)
local speAttrs=self.curLevelCfg.gubao_bonus
local nextSpeAttrs=nextLevelCfg and nextLevelCfg.gubao_bonus or speAttrs
for attrKey,attrVal in pairs(speAttrs)do
local nextVal=nextSpeAttrs[attrKey]
local attrName=helper.getAttributeName(attrKey)
local attrStr=string.format("所有古宝%s+%s%%",attrName,mathHelper.decimal(attrVal,2))
if nextVal>attrVal then
local nextAttrStr=string.format("+%s%%",mathHelper.decimal(nextVal,2))
table.insert(self.speAttrList,{attrStr,nextAttrStr})
else
table.insert(self.speAttrList,{attrStr})
end
end

self.speAttrGrid:setChildLayoutGroupCreateItems(#self.speAttrList,function(index)
local item=self.speAttrGrid:getChildLayoutGroupGridItem(index-1)
local val,nextVal=unpack(self.speAttrList[index])
item:SetChildText(0,val)
if nextVal then
item:SetChildActive(1,true)
item:SetChildText(1,nextVal)
else
item:SetChildActive(1,false)
end
end)
end

function UIBaoShuZhuLingWin:initConsumeList()
if self.curLevel>=self.maxLevel then
self.costObj:setActive(false)
self.fullLevelImg:setActive(true)
else
self.costObj:setActive(true)
self.fullLevelImg:setActive(false)
local consume=self.curLevelCfg.consume or defaultT
self.selectGrid:setChildLayoutGroupCreateItems(#consume,function(index)
local item=self.selectGrid:getChildLayoutGroupGridItem(index-1)
local itemid,neednum=unpack(consume[index])
local hascnt=itemsModel.getCount(itemid)
local num_str=string.format('%d/%d',hascnt,neednum)
local conf={itemid=itemid,itemcount=num_str,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end)
self.gridIdx=#consume
end





end


function UIBaoShuZhuLingWin:refreshExpProgress()
local cfgs=cfg_baoshuzhulinglevelconfig()
local curLevel=self.curLevel
local curExp=self.curExp
local addTotalExp=self.addExp+curExp
local addTotalExpFixed=addTotalExp
local addLevel=0
for i=curLevel,#cfgs-1 do
local cfg=cfgs[i]
if addTotalExp>=cfg.exp then
addLevel=addLevel+1
addTotalExp=addTotalExp-cfg.exp
else
break
end
end
local oldLevel=self.nextLevel
self.nextLevel=curLevel+addLevel
if self.nextLevel~=oldLevel then
self:refreshZhuLingAttrs()
end

local nextLevelNeedMaxExp=gubaoModel:getBSZLNextLevelNeedExp(curLevel)
local duration=self.progressAni and 0.5 or 0
local durationReverse=self.progressReverseAni and 0.5 or 0

if nextLevelNeedMaxExp==0 then
local fullExp=gubaoModel:getBSZLNextLevelNeedExp(curLevel-1)
self.progressBar:animateThreeParams(0,fullExp+1,durationReverse)
self.progressCount:setText(0)
self.progressCountMax:setText(0)
else
self.progressCount:setText(addTotalExpFixed)
self.progressCountMax:setText(nextLevelNeedMaxExp)
self.progressBar:animateThreeParams(addTotalExpFixed>nextLevelNeedMaxExp and nextLevelNeedMaxExp or addTotalExpFixed,nextLevelNeedMaxExp,durationReverse)
end

self.progressAni=false
self.progressReverseAni=false
end

function UIBaoShuZhuLingWin:refreshItemView(item,itemIndex)
local selectItem=self.goodList[itemIndex]
local itemData=selectItem.item
local cnt=selectItem.cnt
local itemid=itemData.itemid
local conf={itemid=itemid,itemcount=cnt,showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end

function UIBaoShuZhuLingWin:refreshGubaoColorItemList(remove)
if remove then
for i=1,#self.goodColorList do
self.selectGrid:setChildLayoutGroupRemoveItem()
end
else
for itemIndex,_ in ipairs(self.goodColorList)do
local gridIdx=self.gridIdx+itemIndex
self.selectGrid:setChildLayoutGroupAddItem()
local itemWidget=self.selectGrid:getChildLayoutGroupGridItem(gridIdx-1)
self:refreshGubaoColorItemView(itemWidget,itemIndex)
end
end
end

function UIBaoShuZhuLingWin:refreshGubaoColorItemView(item,itemIndex)
local selectItem=self.goodColorList[itemIndex]
local cnt=selectItem.cnt
local itemid=0
local iconColor=selectItem.color
local commonPieces=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'commonPieces')
local iconName=iconHelper.getGuBaoIconName(commonPieces[iconColor])
local conf={itemid=itemid,itemcount=cnt,showCountBG=true,iconColor=iconColor,iconName=iconName,
showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
end

function UIBaoShuZhuLingWin:onItemClick(itemid,index,guid,attach)
local gbid=gubaoLookup:good2GuBao(itemid)
if gbid then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eGubaoCheck,tipsType=TIPS_TYPE.eCommonGubaoMetrial,itemid=itemid,itemguid=guid})
else
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end
end

function UIBaoShuZhuLingWin:addGubaoColorList(itemid,cnt)
local color=itemsConfig.getItemColor(itemid)
local itemIndex
local has=false
local removeIdx
for i,v in ipairs(self.goodColorList)do
if v.color==color then
has=true
v.cnt=v.cnt+cnt
if v.cnt<=0 then
removeIdx=i
end
itemIndex=i
break
end
end
if not has then
table.insert(self.goodColorList,{color=color,cnt=cnt})
itemIndex=#self.goodColorList
elseif removeIdx then
table.remove(self.goodColorList,removeIdx)
itemIndex=-removeIdx
end
return itemIndex
end

function UIBaoShuZhuLingWin.onNewBack(itemIndex,itemData,newnum)
if _this==nil then return nil end
if _this.addExp>=_this.maxExp then
return false,0
end

local itemid=itemData.itemid
local unit_exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local lerp_exp=_this.maxExp-_this.addExp
local lerp_full=math.ceil(lerp_exp/unit_exp)

local newnum_=math.min(lerp_full,newnum)
local flag=newnum_>0
if flag then
_this.addExp=_this.addExp+unit_exp*newnum_
itemIndex=itemIndex+1
_this.goodList[itemIndex]={item=itemData,cnt=newnum_}

local oldLen=#_this.goodColorList
local itemColorIndex=_this:addGubaoColorList(itemid,newnum_)
if itemColorIndex>oldLen then
_this.selectGrid:setChildLayoutGroupAddItem()
end
local gridIdx=_this.gridIdx+itemColorIndex
local itemWidget=_this.selectGrid:getChildLayoutGroupGridItem(gridIdx-1)
_this:refreshGubaoColorItemView(itemWidget,itemColorIndex)


_this.progressReverseAni=true
_this:refreshExpProgress()
end
return flag,newnum_
end

function UIBaoShuZhuLingWin.onAddBack(itemIndex,itemData,newnum)
if _this==nil then return nil end

local itemid=itemData.itemid
local unit_exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local selectItem=_this.goodList[itemIndex]
local oldnum=selectItem.cnt
local lerp_exp=_this.maxExp-(_this.addExp-oldnum*unit_exp)
local lerp_full=math.ceil(lerp_exp/unit_exp)


local newnum_=math.min(lerp_full,newnum)
local flag=newnum_~=newnum
if oldnum~=newnum_ then
selectItem.cnt=newnum_
local diffNum=newnum_-oldnum
_this.addExp=_this.addExp+unit_exp*diffNum

local oldLen=#_this.goodColorList
local itemColorIndex=_this:addGubaoColorList(itemid,diffNum)
if itemColorIndex>oldLen then
_this.selectGrid:setChildLayoutGroupAddItem()
end
local gridIdx=_this.gridIdx+itemColorIndex
local itemWidget=_this.selectGrid:getChildLayoutGroupGridItem(gridIdx-1)
_this:refreshGubaoColorItemView(itemWidget,itemColorIndex)


_this.progressReverseAni=true
_this:refreshExpProgress()
end
return flag,newnum_
end

function UIBaoShuZhuLingWin.onSubtractBack(itemIndex,itemData,newnum)
if _this==nil then return nil end

local itemid=itemData.itemid
local unit_exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local selectItem=_this.goodList[itemIndex]
local oldnum=selectItem.cnt
selectItem.cnt=newnum
local diffNum=newnum-oldnum
_this.addExp=_this.addExp+unit_exp*diffNum

local itemColorIndex=_this:addGubaoColorList(itemid,diffNum)
local flag=newnum>0
if not flag then
table.remove(_this.goodList,itemIndex)
end
if itemColorIndex<0 then
itemColorIndex=math.abs(itemColorIndex)
_this.selectGrid:setChildLayoutGroupRemoveItem()
for idx=itemColorIndex,#_this.goodColorList do
local gridIdx=_this.gridIdx+idx
local itemWidget=_this.selectGrid:getChildLayoutGroupGridItem(gridIdx-1)
_this:refreshGubaoColorItemView(itemWidget,idx)
end
else
local gridIdx=_this.gridIdx+itemColorIndex
local itemWidget=_this.selectGrid:getChildLayoutGroupGridItem(gridIdx-1)
_this:refreshGubaoColorItemView(itemWidget,itemColorIndex)
end


_this.progressReverseAni=true
_this:refreshExpProgress()
return flag
end

function UIBaoShuZhuLingWin.onOneKeyBack(selectlist_)
if _this==nil then return nil end
local oldGridNum=#_this.goodList
_this.goodList=selectlist_
local newGridNum=#selectlist_























_this:refreshGubaoColorItemList(true)
_this.goodColorList={}
local addExp=0
for i,v in ipairs(_this.goodList)do
local itemData=v.item
local itemid=itemData.itemid
local unit_exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local num=v.cnt
addExp=addExp+unit_exp*num

_this:addGubaoColorList(itemid,num)
end
_this:refreshGubaoColorItemList()
_this.addExp=addExp


_this.progressReverseAni=true
_this:refreshExpProgress()
return true
end

function UIBaoShuZhuLingWin:onSelectBtn()
local goodlist=self.goodList
local extraParams={goodlist=goodlist,lockcolor=-eQualityColor.eRed,maxExp=self.maxExp,
onNewBack=self.onNewBack,onAddBack=self.onAddBack,onSubtractBack=self.onSubtractBack,onOneKeyBack=self.onOneKeyBack}
local args={}
args.titleName="材料选择"
args.pos=1
args.extraWin='UIBaoShuZhuLingSelectWin'
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIBaoShuZhuLingWin:onAutoUpgradeBtn()
local fullstarPieceList=gubaoLookup:getGoodsSortList4(eQualityColor.eRed)
local bagList={}
for i,v in ipairs(fullstarPieceList)do
local itemid=v.item.itemid
local gbid=gubaoLookup:good2GuBaoPiece(itemid)
local exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
if gbid and gubaoModel:checkAwake(gbid)and exp>0 then
table.insert(bagList,v)
end
end
if#bagList<0 then
UIManager.info("当前没有可注灵的古宝碎片")
return
end


local consume=self.curLevelCfg.consume or defaultT
for i,v in ipairs(consume)do
local itemid,neednum=unpack(v)
local hascnt=itemsModel.getCount(itemid)
if hascnt<neednum then
gainControl:showGainWin(itemid)
return
end
end

local list={}
local addExp=0
local maxExp=self.maxExp
for i,v in ipairs(bagList)do
local itemData=v.item
local itemid=itemData.itemid
local itemcount=itemData.itemcount
local unit_exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local lerp_exp=maxExp-addExp
local lerp_full=math.ceil(lerp_exp/unit_exp)
if itemcount>=lerp_full then
local d={item=itemData,cnt=lerp_full}
table.insert(list,d)
addExp=addExp+(lerp_full*unit_exp)
break
else
local d={item=itemData,cnt=itemcount}
table.insert(list,d)
addExp=addExp+(itemcount*unit_exp)
end
end
local cfgs=cfg_baoshuzhulinglevelconfig()
local curLevel=self.curLevel
local curExp=self.curExp
local addTotalExp=addExp+curExp
local addLevel=0
for i=curLevel,#cfgs-1 do
local cfg=cfgs[i]
if addTotalExp>=cfg.exp then
addLevel=addLevel+1
addTotalExp=addTotalExp-cfg.exp
else
break
end
end
if addLevel<=0 then
UIManager.info("当前古宝碎片不足")
return
end
local nextLevel=curLevel+addLevel
local content=string.format("是否消耗以下碎片将宝树注灵至%d级？",nextLevel)
local itemList={}
local guid_list={}
local count_list={}
for i,v in ipairs(list)do
local itemData=v.item
local num=v.cnt
local itemguid=itemData.itemguid
local itemid=itemData.itemid
table.insert(itemList,{itemid,num})
table.insert(guid_list,itemguid)
table.insert(count_list,num)
end
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=function()
gubaoController:reqBaoShuZhuLing(#guid_list,guid_list,#count_list,count_list)
end,
itemList=itemList,
canvasIndex=8,
})
dialog:show()
end

function UIBaoShuZhuLingWin:onCloseBtn()
self:closeSelf()
end

function UIBaoShuZhuLingWin:onUpgradeBtn()
if#self.goodList<=0 then
UIManager.info("未选择古宝碎片，无法升级")
return
end
if self.curLevel>=self.nextLevel then
UIManager.info("注灵经验不足1级，无法升级")
return
end

local consume=self.curLevelCfg.consume or defaultT
for i,v in ipairs(consume)do
local itemid,neednum=unpack(v)
local hascnt=itemsModel.getCount(itemid)
if hascnt<neednum then
gainControl:showGainWin(itemid)
return
end
end
local guid_list={}
local count_list={}
for i,v in ipairs(self.goodList)do
local itemData=v.item
local num=v.cnt
local itemguid=itemData.itemguid
table.insert(guid_list,itemguid)
table.insert(count_list,num)
end



self.addExp=0
self.progressAni=false
self.progressReverseAni=false
self:refreshExpProgress()
gubaoController:reqBaoShuZhuLing(#guid_list,guid_list,#count_list,count_list)
end