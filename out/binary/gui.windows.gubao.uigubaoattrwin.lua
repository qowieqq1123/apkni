







def_class("UIGuBaoAttrWin",UIWindowBase)









function UIGuBaoAttrWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.descTxt=UIText.get(self,1)
self.fightText=UIText.get(self,2)
self.infoRoot=UIObject.get(self,3)
self.lookScrollView=UIObject.get(self,4)
self.menuGridPanel=UIObject.get(self,5)
self.progressGrid=UIObject.get(self,6)
self.rewadProgress=UIObject.get(self,7)
self.rewardContent=UIObject.get(self,8)
self.rewardGrid=UIObject.get(self,9)
self.rewardProgressBar=UIObject.get(self,10)
self.rewardScrollView=UIObject.get(self,11)
self.root=UIObject.get(self,12)
self.title=UIText.get(self,13)



end


function UIGuBaoAttrWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.lookScrollView);self.lookScrollView=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.progressGrid);self.progressGrid=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end
















local styleLookup={
[3]=6,
[4]=5,
}
local pageConfig=
{
[1]={
name='总览',
checkReddot=function()
return false
end,
open=function(self_)
self_:openInfoPanel()
end,
close=function(self_)
self_:closeInfoPanel()
end,
},
}
local _this=nil
local menu_slot_name='button_dytab'


function UIGuBaoAttrWin:onLoaded(...)
_this=self
self:bindComponents()

self.pageConfig={}
for i,v in ipairs(pageConfig)do
self.pageConfig[i]=v
end
self.colorNames2={[2]="古宝",[3]="珍宝",[4]="灵宝",[5]="至宝",[6]="混沌"}
local colorNames=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'colorNames')
for color,name in pairsBySortKey(colorNames)do
local lp=gubaoLookup:getColorCollectList(color)
if lp then
local d={name=self.colorNames2[color],title=colorNames[color]}
local color_=color
d.checkReddot=function()
return gubaoModel:checkColorCollectReddot(color_)
end
d.open=function(self_)
self_:openCollectPanel(color_)
end
d.close=function(self_)
self_:closeCollectPanel()
end
table.insert(self.pageConfig,d)
end
end
self.colorNames=colorNames

self.initLookup={}
end


function UIGuBaoAttrWin:__delete()
_this=nil
self:unbindComponents()
end


function UIGuBaoAttrWin:onHide()

end




function UIGuBaoAttrWin:onShow(argtable,afterOnloaded)
local page=1

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local cnt=#self.pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.pageConfig[i]
item:SetChildText(1,cfg.name)
self:refreshMenuItemSelect(item,i,i==page)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
self.root:setChildCanvasGroupDOFade(1,1,nil)
end
self:onMenuItemClick(page)
end



function UIGuBaoAttrWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(4,flag)
end

function UIGuBaoAttrWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.pageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(2,isReddot)
end

function UIGuBaoAttrWin:onMenuItemClick(page)
if page==self.curPage then
return
end

local old=self.curPage
self.curPage=page
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
self:refreshMenuPage(old,false)
end
self:refreshMenuItemSelect(nil,page,true)
self:refreshMenuPage(page,true)
local cfg=self.pageConfig[page]
self.title:setText(cfg.title)
end

function UIGuBaoAttrWin:refreshMenuPage(page,flag)
local cfg=self.pageConfig[page]
if flag then
cfg.open(self)
else
cfg.close(self)
end
end





function UIGuBaoAttrWin:openInfoPanel()
self.infoRoot:setActive(true)
if self.isInfoInit then return end
self.isInfoInit=true
local allGFList=gubaoLookup:getAllList()
local sortType=1
local list=gubaoLookup:getSortList(allGFList,sortType,nil,eSortOrder.eUp,true)
local c=#list
self.progressGrid:setChildLayoutGroupCreateItems(c,nil)
local progressGridList=self.progressGrid:getChildLayoutGroupGridList()
if c>0 then
for i=1,c do
local item=progressGridList[i-1]
local pageData=list[i]

local color=pageData.typo
local name_str=self.colorNames[color]
if color<6 then
name_str=toColorString(color,name_str)
else
name_str=string.format('<color=#ECCA76>%s</color>',name_str)
end
item:SetChildText(1,name_str)

local max=#pageData.childlist
local cur=0
for i,v in ipairs(pageData.childlist)do
if gubaoModel:checkActive(v.id)then
cur=cur+1
end
end
local progress_str=FMT.fmt('{0}/{1}',cur,max)
item:SetChildProgressValue(0,cur,max)
item:SetChildProgressText(0,progress_str)
item:SetChildActive(2,color>=6)
end
end


local attrs=gubaoModel:getAllAttrLookup(false)

local fight=cfgHelper.getFight(attrs)

fight=fight*5
self.fightText:setText(tostring(fight))

local attrlist={}
self.addAttrDescStr(attrlist,attrs)
local cc=#attrlist
self.attrGrid:setChildLayoutGroupCreateItems(cc,nil)
local attrGridList=self.attrGrid:getChildLayoutGroupGridList()
if cc>0 then
for i=1,cc do
local item=attrGridList[i-1]
local str=attrlist[i]
item:SetChildText(0,str)
end
end

local desc_str=cfgHelper.getlang('gubao_tips_7')
self.descTxt:setText(desc_str)


end

function UIGuBaoAttrWin:closeInfoPanel()
self.infoRoot:setActive(false)
end

function UIGuBaoAttrWin.addAttrDescStr(res,attrs)
if attrs==nil then
return
end












for i,v in pairsBySortKey(attrs)do
local str=helper.getAttributeStr(i,v,1,'{0}：{1}')






table.insert(res,str)
end







end





function UIGuBaoAttrWin:getCollectIndex()
local curnum=self.collectNum
local collectIndex
for i,v in ipairs(self.collectList)do
if curnum>=v.num then
collectIndex=i
end
end
if collectIndex==nil then
local d=self.collectList[1]
if curnum<d.num then
collectIndex=1
end
end
return collectIndex
end

function UIGuBaoAttrWin:openCollectPanel(color)
self.rewardScrollView:setActive(true)
if self.collectColor==color then return end
self.collectColor=color
self.collectNum=gubaoModel:getGuBaoColorNum(color)



local list=gubaoLookup:getColorCollectList(color)
self.collectList=list

self.collectIndex=self:getCollectIndex()
self.speed=400
self.stepHeight=90
local contentOffset={43,43}
self.rewardProgressBar:setChildAnchoredPosition(Vector2(-175,-contentOffset[1]))
self.rewardGrid:setChildAnchoredPosition(Vector2(-175,-contentOffset[1]))

local max=#self.collectList

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for idx=1,max do
local item=grids[idx-1]

local posY=(idx-1)*self.stepHeight
item:SetChildAnchoredPosition(-1,Vector2(0,-posY))

item:SetChildButtonClick(3,function(...)
if _this==nil then return end
_this:onClickItemActive(idx)
end)
self:refreshItemState(item,idx)
end

local max_height=(max-1)*self.stepHeight+contentOffset[1]+contentOffset[2]
self.rewardContent:setChildSizeDelta(430,max_height)


self:refreshProgress()
local isInit=self.initLookup[color]~=nil
if not isInit then
self.initLookup[color]=true
local showHeight=self.rewardScrollView:getChildRectHeight()
local progress_height=self.cur_height+showHeight/2+contentOffset[2]
local moveY=progress_height-showHeight
if moveY>0 then
self.rewardContent:setLocalPosY(moveY)
end
end
end

function UIGuBaoAttrWin:closeCollectPanel()
self.rewardScrollView:setActive(false)
end

function UIGuBaoAttrWin:refreshAllItemState()
local max=#self.collectList
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for idx=1,max do
local item=grids[idx-1]
self:refreshItemState(item,idx)
end
self:refreshProgress()
end

function UIGuBaoAttrWin:refreshItemState(item,idx)
if item==nil then
item=self.rewardGrid:getChildLayoutGroupGridItem(idx-1)
end
local d=self.collectList[idx]
local cur=self.collectNum
local max=d.num
local color=d.color
local isActive=cur>=max
local done=gubaoModel:checkColorCollect(color,max)

item:SetChildActive(0,isActive)

local bgicon=isActive and'image_jihuojdui_5'or'image_jihuojdui_4'
item:SetChildCSImageSprite(5,globalABLookup.gubaotipsicons,bgicon)

local title_str=FMT.fmt('激活{0}件{1}',max,self.colorNames[color])
if isActive then
title_str=FMT.fmt('<color=#549327>{0}</color>',title_str)
end
item:SetChildText(1,title_str)

local attr
if d.attr then
for k,v in pairs(d.attr)do
attr={k,v}
break
end
end
local bonus
if d.bonus then
for k,v in pairs(d.bonus)do
bonus={k,v}
break
end
end
local desc_str
if attr then
desc_str=helper.getAttributeStr(attr[1],attr[2],4,'所有弟子{0}+{1}')
elseif bonus then
desc_str=FMT.fmt('所有古宝{0}+{1}%',helper.getAttributeName(bonus[1]),bonus[2])
else
desc_str='没配置属性'
end
if isActive then
desc_str=FMT.fmt('<color=#549327>{0}</color>',desc_str)
end
item:SetChildText(2,desc_str)

item:SetChildActive(3,isActive and not done)

item:SetChildActive(4,isActive and done)
end

function UIGuBaoAttrWin:refreshProgress(anim)
local curIndex=self.collectIndex
local max=#self.collectList
local max_height=(max-1)*self.stepHeight
self.rewardProgressBar:setChildSizeDelta(12,max_height)

local max_height_=max_height
local stepHeight_=self.stepHeight
local cur_height
if curIndex>=max then
cur_height=max_height_
else
if curIndex>1 then
cur_height=(curIndex-1)*stepHeight_
else
cur_height=0
end
end
self.cur_height=cur_height

if anim then
local old_height=self.rewardProgressBar:getChildSizeDeltaY()
local lerp=math.abs(cur_height-old_height)
self.rewadProgress:setChildDOSizeDelta(Vector2(12,cur_height),lerp/self.speed,nil)
else
self.rewadProgress:setChildSizeDelta(12,cur_height)
end
end

function UIGuBaoAttrWin:onClickItemActive(idx)
local d=self.collectList[idx]
local color=d.color
local cur=self.collectNum
local num
for i,v in ipairs(self.collectList)do
if cur>=v.num then
if not gubaoModel:checkColorCollect(v.color,v.num)then
num=v.num
end
end
end
if num~=nil then
gubaoController:req_activeCollect(color,num)
end
end

function UIGuBaoAttrWin:rec_active()
self.isInfoInit=nil
if self.curPage==1 then
self:openInfoPanel()
else
self:refreshAllItemState()
end
self:refreshMenuItemReddot(nil,self.curPage)
end


