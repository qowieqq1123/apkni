







def_class("UIGuBaoUpStarWin",UIWindowBase)









function UIGuBaoUpStarWin:bindComponents()

self.gbIcon=UIImage.get(self,0)
self.gbName=UIText.get(self,1)
self.attrGrid=UIObject.get(self,2)
self.skillDesc=UIText.get(self,3)
self.costTitle=UIText.get(self,4)
self.selectGrid=UIObject.get(self,5)
self.commintTxt=UIText.get(self,6)
self.starGrid=UIObject.get(self,7)
self.awakeSign=UIObject.get(self,8)
self.costObj=UIObject.get(self,9)
self.awakefullSign=UIObject.get(self,10)
self.fullstarSign=UIText.get(self,11)
self.leftBtn=UIButton.get(self,12)
self.rightBtn=UIButton.get(self,13)
self.root=UIObject.get(self,14)
self.commitReddot=UIObject.get(self,15)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UIGuBaoUpStarWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gbIcon);self.gbIcon=nil;
_UIObject_release(self.gbName);self.gbName=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.selectGrid);self.selectGrid=nil;
_UIObject_release(self.commintTxt);self.commintTxt=nil;
_UIObject_release(self.starGrid);self.starGrid=nil;
_UIObject_release(self.awakeSign);self.awakeSign=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.awakefullSign);self.awakefullSign=nil;
_UIObject_release(self.fullstarSign);self.fullstarSign=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.commitReddot);self.commitReddot=nil;
end



















local _this=nil
local goodMax=5
local page_str={
'升星','觉醒'
}
local menu2page={
[2]=1,
[3]=2,
}


function UIGuBaoUpStarWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIGuBaoUpStarWin:__delete()
self:unbindComponents()
_this=nil
end


function UIGuBaoUpStarWin:onHide()

end




function UIGuBaoUpStarWin:onShow(argtable,afterOnloaded)
self.gbid=argtable.gbid
self.page=menu2page[argtable.menuPageIndex]
self.gubaoList=gubaoModel:getYetActiveList(self.page,self.gbid)
self:initCanJumpIndex()
self.gbIndex=self:getIndexByGbid(self.gbid)

if gubaoModel:getYetGubaoIndex()>0 then
self.gbIndex=gubaoModel:getYetGubaoIndex()
self.gbid=self.gubaoList[self.gbIndex]
end






if#self.gubaoList>1 then
self:refreshCliskBtns(true)
else
self:refreshCliskBtns(false)
end

self:initGoodList()

self:initView()
self:refreshView(true)
self:initItemList()
end

function UIGuBaoUpStarWin:initGoodList()
local gbid=self.gbid
if self.page==1 then
self.isfull=gubaoModel:checkFullUpStar(gbid)
else
self.isfull=gubaoModel:checkAwake(gbid)
end
if not self.isfull then
self.goodlist=gubaoModel:initUpStarGoodList(gbid,self.page)
else
self.goodlist={}
end
end

function UIGuBaoUpStarWin:initView()
local gbid=self.gbid
local cfg=cfgHelper.get(cfg_gubaoconfig_get,gbid)

self.gbIcon:setImageIcon(gubaoModel:getGuBaoIconName(cfg.icon),true)


local name_str=cfg.name
self.gbName:setText(name_str)

local cost_fmt='{0}消耗'
local cost_str=FMT.fmt(cost_fmt,page_str[self.page])
self.costTitle:setText(cost_str)

self.commintTxt:setText(page_str[self.page])

self:refreshStarView()

self:refreshCommitBtnReddot()
end

function UIGuBaoUpStarWin:refreshCommitBtnReddot()
local reddot=false
if self.page==1 then

reddot=gubaoModel:checkCanUpStar(self.gbid)
end
self.commitReddot:setActive(reddot)
end

function UIGuBaoUpStarWin:refreshStarView()

local gbid=self.gbid
local starlv=gubaoModel:getStar(gbid)
local starWidget=self.starGrid:getChildWidgetBase()
for i=1,5 do
local icon=i<=starlv and'icon_tyxingxing_1'or'icon_tyxingxing_2'
starWidget:SetChildCSImageSprite(i-1,globalABLookup.gubaomainicons,icon)
end

local awake=gubaoModel:checkAwake(gbid)
self.awakeSign:setActive(awake)

self.costObj:setActive(not self.isfull)
self.awakefullSign:setActive(awake)

local showstarsign=self.page==1 and self.isfull and not awake
self.fullstarSign:setActive(showstarsign)
end

function UIGuBaoUpStarWin:refreshView(isInit)
local gbid=self.gbid
local gbData=gubaoModel:getDataByID(gbid)



local attrlist=gubaoModel:getBaseAttrList(gbid)
local attrnum=#attrlist
if isInit==true then
self.attrGrid:setChildLayoutGroupCreateItems(attrnum)
end
local starlv=gbData.gubaostar
local awakelv=gbData.gubaojxlv
if not self.isfull then
if self.page==1 then
starlv=starlv+1
else
awakelv=awakelv+1
end

local changeAttrlist=gubaoModel:getBaseAttrListEx(gbid,gbData.gubaolhlv,starlv,awakelv)
for i,v in ipairs(attrlist)do
local lerp=changeAttrlist[i][2]-v[2]
if lerp>0 then v[3]=lerp end
end
end
local attrGridList=self.attrGrid:getChildLayoutGroupGridList()
for i=1,attrnum do
local item=attrGridList[i-1]
local attr=attrlist[i]
local str=helper.getAttributeStr(attr[1],attr[2],nil,'<color=#7D3B17>{0}</color>：{1}')
item:SetChildText(0,str)
local showAdd=attr[3]~=nil
item:SetChildActive(1,showAdd)
if showAdd then
item:SetChildText(1,helper.getAttributeStrEx(attr[1],attr[3]))
end
end

local skilllv=gubaoModel:getSkillLv(gbid)
local n_skilllv=gubaoModel:getSkillLvEx(gbid,starlv,awakelv)
local skill_str,skill_str_2,skill_str_3=gubaoModel:getSkillDesc(gbid,skilllv,n_skilllv)
if skill_str_2 then
skill_str=FMT.fmt('{0}\n{1}',skill_str,skill_str_2)
end
self.skillDesc:setText(skill_str)
end

function UIGuBaoUpStarWin:initItemList()
local isTip=false
local selectGridList=self.selectGrid:getChildCommonLayoutGroupWidgetList()
for i=1,goodMax do
local item=selectGridList[i-1]
local goodData=self.goodlist[i]
local hasGood=goodData~=nil
item:SetChildActive(3,hasGood)
if hasGood then
self:refreshItemView(item,i)


local costType=goodData.costType
if not isTip and costType~=1 then
local itemCount=0
local baglist
if goodData.itemColor>0 then
baglist=gubaoLookup:getGoodsSortList3(goodData.itemColor)
else
baglist=gubaoLookup:getGoodsSortList4(math.abs(goodData.itemColor))
end
for i1,data in ipairs(baglist)do
local itemData=data.item
itemCount=itemCount+itemData.itemcount
end
if itemCount>=goodData.needcnt then
isTip=true
self:openSelectWin(i)
end
end
end
end
end

function UIGuBaoUpStarWin:refreshItemView(item,idx)
local goodData=self.goodlist[idx]
local costType=goodData.costType
if costType==1 then

local itemid=goodData.itemid
local needcnt=goodData.needcnt
local hascnt=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local guBaoPieceItemId=gubaoLookup:gubao2GoodPiece(self.gbid)
if itemid==guBaoPieceItemId then

local glhasnum=gubaoModel:FindGLpieceNum(self.gbid)
hascnt=glhasnum+hascnt
end

local num_str=string.format('%d/%d',hascnt,needcnt)
local grayNum=0
if hascnt<needcnt then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
local conf={itemid=itemid,itemcount=num_str,showCountBG=true,showname=false,itemIndex=idx,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
else

local itemid=0
local needcnt=goodData.needcnt
local iconColor=math.abs(goodData.itemColor)
local iconName=iconHelper.getGuBaoIconName(goodData.itemIcon)
local hascnt=0
for i,v in ipairs(goodData.selectlist)do
hascnt=hascnt+v.cnt
end
local num_str=string.format('%d/%d',hascnt,needcnt)
local grayNum=0
if hascnt<needcnt then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
local conf={itemid=itemid,itemcount=num_str,showCountBG=true,iconColor=iconColor,iconName=iconName,
showname=false,itemIndex=idx,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
end
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end

function UIGuBaoUpStarWin:onItemClick(itemid,index,guid,attach)
local goodData=self.goodlist[index]
local costType=goodData.costType
if costType==1 then

local gbid=gubaoLookup:good2GuBao(itemid)
if gbid then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eGubaoCheck,tipsType=TIPS_TYPE.eCommonGubaoMetrial,itemid=itemid,itemguid=guid})
else
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end
else

self:openSelectWin(index)
end
end

function UIGuBaoUpStarWin:onGBClick()
tipsManager.showTipsGB({formType=TIPS_FORM_TYPE.eGubaoCheck,tipsType=TIPS_TYPE.eCommonGubao,itemid=self.gbid,bg=false})
end

function UIGuBaoUpStarWin:openSelectWin(goodIndex)
local goodData=self.goodlist[goodIndex]
local extraParams={goodIndex=goodIndex,goodlist=goodData.selectlist,lockcolor=goodData.itemColor,needcnt=goodData.needcnt,
onNewBack=self.onNewBack,onAddBack=self.onAddBack,onSubtractBack=self.onSubtractBack,onOneKeyBack=self.onOneKeyBack}
local args={}
args.titleName="材料选择"
args.pos=1
args.extraWin='UIGuBaoUpStarSelectWin'
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIGuBaoUpStarWin.onNewBack(goodIndex,itemIndex,itemData,newnum)
if _this==nil then return nil end
if _this.isfull then
return false,nil
end

local goodData=_this.goodlist[goodIndex]
local cnt=0
for i,v in ipairs(goodData.selectlist)do
cnt=cnt+v.cnt
end
local lerp_full=goodData.needcnt-cnt
local newnum_=math.min(lerp_full,newnum)
local flag=newnum_>0
if flag then
itemIndex=itemIndex+1
goodData.selectlist[itemIndex]={item=itemData,cnt=newnum_}

local itemWidget=_this.selectGrid:getChildCommonLayoutGroupWidgetItem(goodIndex-1)
_this:refreshItemView(itemWidget,goodIndex)
end
return flag,newnum_
end

function UIGuBaoUpStarWin.onAddBack(goodIndex,itemIndex,itemData,newnum)
if _this==nil then return nil end
if _this.isfull then
return false,nil
end

local goodData=_this.goodlist[goodIndex]
local cnt=0
for i,v in ipairs(goodData.selectlist)do
cnt=cnt+v.cnt
end
local selectItem=goodData.selectlist[itemIndex]
local oldnum=selectItem.cnt
cnt=cnt-oldnum

local lerp_full=goodData.needcnt-cnt
local newnum_=math.min(lerp_full,newnum)
local flag=newnum_~=newnum
if oldnum~=newnum_ then
selectItem.cnt=newnum_

local itemWidget=_this.selectGrid:getChildCommonLayoutGroupWidgetItem(goodIndex-1)
_this:refreshItemView(itemWidget,goodIndex)
end
return flag,newnum_
end

function UIGuBaoUpStarWin.onSubtractBack(goodIndex,itemIndex,itemData,newnum)
if _this==nil then return nil end

local goodData=_this.goodlist[goodIndex]
local selectItem=goodData.selectlist[itemIndex]
selectItem.cnt=newnum
local flag=newnum>0
if not flag then
table.remove(goodData.selectlist,itemIndex)
end
local itemWidget=_this.selectGrid:getChildCommonLayoutGroupWidgetItem(goodIndex-1)
_this:refreshItemView(itemWidget,goodIndex)

return flag
end

function UIGuBaoUpStarWin.onOneKeyBack(goodIndex,selectlist_)
if _this==nil then return nil end
local goodData=_this.goodlist[goodIndex]
goodData.selectlist=selectlist_
local itemWidget=_this.selectGrid:getChildCommonLayoutGroupWidgetItem(goodIndex-1)
_this:refreshItemView(itemWidget,goodIndex)
return true
end

function UIGuBaoUpStarWin:onCommitBtn()
if self.isfull then
return
end

local list={}
local needChangePiece=false
local changeItemList={}
local needNum=0
local notEnoughItemId
local glitemid,glpieceid=liandonModel:CheckGB_Guanlian_Item(self.gbid)
local hascnt_gl=0

local needgl=0
if glpieceid then

hascnt_gl=bagControl.invokeFuncByItemId(glpieceid,'getItemCountByItemID',glpieceid)
end

local guBaoPieceItemId=gubaoLookup:gubao2GoodPiece(self.gbid)
for i,v in ipairs(self.goodlist)do
local goodData=v
local costType=goodData.costType
if costType==1 then

local itemid=goodData.itemid
local needcnt=goodData.needcnt
local hascnt=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)

if guBaoPieceItemId==itemid then
needgl=needcnt-hascnt
hascnt=hascnt_gl+hascnt
end
if hascnt<needcnt then
if self.page==1 and guBaoPieceItemId==itemid then

local deltaNum=needcnt-hascnt
needNum=deltaNum
local color=itemsConfig.getItemColor(itemid)
local isEnough=false
local changePieceItemList=gubaoLookup:getChangePieceItemListByColor(color)or{}
for _,changePieceItemId in ipairs(changePieceItemList)do
local num=bagModel.getItemCountById(changePieceItemId)
local tmpNum=deltaNum>=num and num or deltaNum
deltaNum=deltaNum-num
local changeItem,changeItemGuid=bagControl.invokeFuncByItemId(changePieceItemId,'getItemByItemID',changePieceItemId)
changeItemList[#changeItemList+1]={item=changeItem,cnt=tmpNum}
if deltaNum<=0 then
isEnough=true
needChangePiece=true
notEnoughItemId=itemid
break
end
end

if not isEnough then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
return
end
else
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
return
end
end
else

local needcnt=goodData.needcnt
local hascnt=0
for i,v in ipairs(goodData.selectlist)do
hascnt=hascnt+v.cnt
end
if hascnt<needcnt then
UIManager.error('道具不足')
return
else
for i2,v2 in ipairs(goodData.selectlist)do
if v2.cnt>0 then
table.insert(list,v2)
else



end
end
end
end
end

if self.page==1 then
if needChangePiece then
local changeItemId=changeItemList[1].item.itemid
local itemname=itemsConfig.getItemName(notEnoughItemId)
local itemname2=itemsConfig.getItemName(changeItemId)
local desc_str=FMT.fmt('{0}不足，是否消耗{1}个{2}转换为{0}？',itemname,needNum,itemname2)
local func=function()
for _,v in ipairs(changeItemList)do
table.insert(list,v)
end

if needgl>0 then
local gllist={}
if glpieceid and guBaoPieceItemId then
gllist[#gllist+1]={liandongZY.gubao,glpieceid,guBaoPieceItemId,needgl}
end
liandonController:send_254_96(#gllist,gllist)
end
gubaoController:reqUpStar(self.gbid,list)
end
local args={
desc=desc_str,
itemid=changeItemId,
itemnum=needNum,
itemid2=notEnoughItemId,
itemnum2=needNum,
showCancel=true,
cancelCB=nil,
commitCB=function()
func()
end,
}
UIManager:showWindow('UICommonUseItem_goodChangeWin',args)
else

if needgl>0 then
local gllist={}
if glpieceid and guBaoPieceItemId then
gllist[#gllist+1]={liandongZY.gubao,glpieceid,guBaoPieceItemId,needgl}
end
liandonController:send_254_96(#gllist,gllist)
end
gubaoController:reqUpStar(self.gbid,list)
end
else
gubaoController:reqAwake(self.gbid,list)
end
end

function UIGuBaoUpStarWin:rec_upStar(gbid)
if self.gbid~=gbid then return end

self:initGoodList()
self:refreshStarView()
self:refreshCommitBtnReddot()
self:refreshView(true)
self:initItemList()
end

function UIGuBaoUpStarWin:rec_awake(gbid)
self:rec_upStar(gbid)
end

function UIGuBaoUpStarWin:refreshCliskBtns(flag)
self.winlua:SetChildActive(self.leftBtn:getID(),flag)
self.winlua:SetChildActive(self.rightBtn:getID(),flag)
end

function UIGuBaoUpStarWin:refreshData()
self.gubaoList=gubaoModel:getYetActiveList(self.page)
self.gbIndex=self:getIndexByGbid(self.gbid)
end

function UIGuBaoUpStarWin:getIndexByGbid(gbid)
for k,v in ipairs(self.gubaoList)do
if v==gbid then
local str=tostring(k)
return self.getIndexList[str]
end
end
return 0
end


function UIGuBaoUpStarWin:judgeGbState(gbid)



if gubaoModel:checkFullUpStar(gbid)then
if gubaoModel:checkOpenAwake(gbid)and not gubaoModel:checkAwake(gbid)then
return 2
end
else
return 1
end

return 0
end

function UIGuBaoUpStarWin:initCanJumpIndex()
self.indexList={}
self.getIndexList={}

for k,v in ipairs(self.gubaoList)do
if self:judgeGbState(v)>0 then
local str=tostring(k)
table.insert(self.indexList,k)
self.getIndexList[str]=#self.indexList
end
end
end

function UIGuBaoUpStarWin:refreshTabPanel()
local type
if self.page==1 then
type=SEC_FULL_TAB_TYPE.gubaoupstar
elseif self.page==2 then
type=SEC_FULL_TAB_TYPE.gubaoawake
end

local tabName={}
local eType=oneTabScreenConfig:getScreenLookupMain(type)
local config=oneTabScreenConfig:getScreenConfig(eType)
for i,v in ipairs(config.children)do
local luaCfg=tabScreenConfig:getTabScreenConfig(v)
local tabCfg=tabScreenConfig:getTabConfig(v)
local isOpen=tabScreenConfig.isTabActive(v,luaCfg,{gbid=self.gbid})
if isOpen then
table.insert(tabName,tabCfg.name)
end
end

UIManager:invokeUIMethod("UITabListComponent","refreshItemName",tabName)

end

function UIGuBaoUpStarWin:onLeftBtn()
local index
local key=self.gbIndex-1
if key<=0 then
key=#self.indexList
end

index=self.indexList[key]

self.gbIndex=key
self.gbid=self.gubaoList[index]
self.page=self:judgeGbState(self.gbid)

self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),0,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),100,0.2,function()
self.winlua:SetChildActive(self.root:getID(),false)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-100,0.1,function()
self.winlua:SetChildActive(self.root:getID(),true)
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),0,0.2)
end)
end)

gubaoModel:setYetGubaoIndex(index)
self:initGoodList()
self:initView()
self:refreshView(true)
self:initItemList()
self:refreshTabPanel()
end

function UIGuBaoUpStarWin:onRightBtn()
local index
local key=self.gbIndex+1
if self.gbIndex+1>#self.indexList then
key=1
end

index=self.indexList[key]

self.gbIndex=key
self.gbid=self.gubaoList[index]

self.page=self:judgeGbState(self.gbid)
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),0,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-100,0.2,function()
self.winlua:SetChildActive(self.root:getID(),false)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),100,0.1,function()
self.winlua:SetChildActive(self.root:getID(),true)
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.2)
self.winlua:SetChildDOLocalMoveX(self.root:getID(),0,0.2)
end)
end)

gubaoModel:setYetGubaoIndex(index)
self:initGoodList()
self:initView()
self:refreshView(true)
self:initItemList()
self:refreshTabPanel()
end
