







def_class("UIGongFaSelectWin",UIWindowBase)









function UIGongFaSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.gfListGrid=UIObject.get(self,1)
self.leftBtn=UIButton.get(self,2)
self.rightBtn=UIButton.get(self,3)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UIGongFaSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gfListGrid);self.gfListGrid=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
end
















local pageFrameIcon=
{
'image_pzshang','image_pzzhong','image_pzxia'
}
local deskPosXLookup={
0,7,12,22
}
local colorEffectLookup={
[0]=10155,10145,10146,10147,10148,10149
}
local menuNum=8
local _this=nil


function UIGongFaSelectWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIGongFaSelectWin:__delete()
self:unbindComponents()
_this=nil
end


function UIGongFaSelectWin:onHide()

end

function UIGongFaSelectWin:doFadeIn(fadeInData,old_page,page)
local delay=0
if fadeInData then
delay=delay+fadeInData[1]
end
if old_page==2 or old_page==3 then
delay=delay+0.2
end
if delay>0 then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(delay,func)
else
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5,nil)
end
end




function UIGongFaSelectWin:onShow(argtable,afterOnloaded)
local fadeInData=argtable.fadeInData
if not afterOnloaded then
fadeInData=nil
end
local page=argtable.page
local old_page=argtable.old_page
self:doFadeIn(fadeInData,old_page,page)

self.sortType=0
self.sortCondition2=argtable.sortType
self.sortCondition={}
self.sortOrder=eSortOrder.eDown
self.curMenuIndex=1

self:initGFListPanel()
end

function UIGongFaSelectWin:getGFList()
if self.allGFList==nil then
self.allGFList=gongfaLookup:getAllGongFaList()
end

local list=gongfaLookup:getSortGongFaList(self.allGFList,self.sortType,self.sortCondition,self.sortCondition2,self.sortOrder)
self.gongfalist=list

local c=#list

local list2={}
local s=(self.curMenuIndex-1)*menuNum+1
local e=self.curMenuIndex*menuNum
for i=s,e do
if i<=c then
table.insert(list2,list[i])
end
end
self.gongfalist2=list2
end

function UIGongFaSelectWin:findGFIndex(gfID)
for i,v in ipairs(self.gongfalist2)do
if v.id==gfID then
return i
end
end
return nil
end

function UIGongFaSelectWin:initGFListPanel()
self:getGFList()
self:refreshArrow()
local dataNum=#self.gongfalist2
local func=function(idx)
local item=self.gfListGrid:getChildLayoutGroupGridItem(idx-1)
item:SetChildButtonClick(6,function()
self:onClickItemCallback(idx)
end)
self:refreshGFItem(item,idx)
end

self.gfListGrid:setChildLayoutGroupCreateItems(dataNum,func)
end

function UIGongFaSelectWin.getPageFrameIcon(page)
return pageFrameIcon[page]
end

function UIGongFaSelectWin:refreshGFItem(item,idx)
if item==nil then
item=self.gfListGrid:getChildLayoutGroupGridItem(idx-1)
end

local cfg=self.gongfalist2[idx]
local gfID=cfg.id
local active=UIGongFaModel:isGongFaActive(gfID)
local canActivePage=UIGongFaModel:hasCanActivePage(gfID)


local elements=UIGongFaModel:getGFElements(gfID)
local elementIcon=ELEMENT_TYPE.getIcon(elements[1])
item:SetChildCSImageSprite(0,globalABLookup.global,elementIcon)
item:SetChildActive(0,true)

local color
local effectId=nil
if active then
color=UIGongFaModel:getGFColor(gfID)
else
color=0
end
effectId=colorEffectLookup[color]
if effectId then
item:SetChildShowEffect(11,effectId,true)
else
item:SetChildShowEffect(11,0,false)
end
local pos=self:getChildCanvas(-1)
item:SetChildCanvas(2,pos[1],pos[2]+2)
local colorIcon=UIGongFaModel:getGFColorKuangIcon(color)
item:SetChildCSImageSprite(2,globalABLookup.cangjingge,colorIcon)
item:SetChildIcon(3,iconHelper.getGongFaIcon(cfg.icon),false)
item:SetChildImageExGray(3,not active)

item:SetChildText(1,cfg.name)

local defaultActive=UIGongFaModel:isGongFaDefaultActive(gfID)
local allActive=UIGongFaModel:isPageAllActive(gfID)
local showProgress=active and not allActive

item:SetChildActive(4,showProgress)
if showProgress then
local page_num=0
if cfg.piece then
page_num=#cfg.piece
end
local pagelist={}
if page_num==2 then
local page1=UIGongFaModel:isPageActive(gfID,cfg.piece[1][1])
local page2=UIGongFaModel:isPageActive(gfID,cfg.piece[2][1])
if page1 then
table.insert(pagelist,self.getPageFrameIcon(1))
end
if page2 then
table.insert(pagelist,self.getPageFrameIcon(3))
end
elseif page_num==3 then
local page1=UIGongFaModel:isPageActive(gfID,cfg.piece[1][1])
local page2=UIGongFaModel:isPageActive(gfID,cfg.piece[2][1])
local page3=UIGongFaModel:isPageActive(gfID,cfg.piece[3][1])
if page1 then
table.insert(pagelist,self.getPageFrameIcon(1))
end
if page2 then
table.insert(pagelist,self.getPageFrameIcon(2))
end
if page3 then
table.insert(pagelist,self.getPageFrameIcon(3))
end
end
local c=#pagelist
item:SetChildLayoutGroupCreateItems(4,c)
local grids=item:GetChildLayoutGroupGridList(4)
if c>0 then
for i=1,c do
local pageItem=grids[i-1]
local d=pagelist[i]
pageItem:SetChildCSImageSprite(0,globalABLookup.cangjingge,d)
end
end
end


if active then
local studylv=UIGongFaModel:getStudyLevel(gfID)
local showStudy=studylv>0
item:SetChildActive(7,showStudy)
if showStudy then
item:SetChildText(8,studylv)
end
else
item:SetChildActive(7,false)
end

local reddot=canActivePage or UIGongFaModel:hasActiveAnyPageReward(gfID)or UIGongFaModel:checkStudyReddot(gfID)
item:SetChildActive(5,reddot)

local isLDGF=liandonModel:getLianDonLinkageIdByGFId(gfID)>0
item:SetChildActive(12,isLDGF)
item:SetChildImageExGray(12,not active)

local posIdx=idx%4
if posIdx==0 then
posIdx=4
end
local posX=deskPosXLookup[posIdx]
item:SetChildAnchoredPosition(9,Vector2(posX,0))
end

function UIGongFaSelectWin:refreshGFItemByID(gfID)
local idx=self:findGFIndex(gfID)
if idx then
local item=self.gfListGrid:getChildLayoutGroupGridItem(idx-1)
if item then
self:refreshGFItem(item,idx)
end
end
end


function UIGongFaSelectWin:onClickItemCallback(index)
local cfg=self.gongfalist2[index]
local gfID=cfg.id
local canActivePage=UIGongFaModel:getCanActivePage(gfID)
if canActivePage then
self:onPageActive(gfID,canActivePage)
else


UIManager:showWindow('UIGongFaTipsThreeWin',{gfID=gfID})

end
end

function UIGongFaSelectWin:onPageActive(gfID,canActivePage)
local pagelist={}

local gllist={}
for i,v in ipairs(canActivePage)do
if v[3]and v[1]then

gllist[#gllist+1]={liandongZY.gongfa,v[3],v[1],1}
end
table.insert(pagelist,{v[1],v[2]})
end
liandonController:send_254_96(#gllist,gllist)

UIGongFaController:reqGongFaCollectAndReward(gfID,pagelist)
end

function UIGongFaSelectWin:onSortTypeChange(args)
self.sortCondition2=args.sortType
self.curMenuIndex=1
self:initGFListPanel()
end

function UIGongFaSelectWin:onSortConditionClick()
if self.filterName==nil or self.filterFlag==nil then
self.filterName,self.filterFlag=gongfaLookup:getConditonFilter()
end
local args={filterName=self.filterName,filterFlag=self.filterFlag,comfirmCallback=self.selecConditionBack}
args.titleName=cfgHelper.getlang('filter_title_name_gf')
UIManager:showWindow('UIFilterTwoWin',args)
end

function UIGongFaSelectWin.selecConditionBack(data)

if _this==nil then
return
end
_this.filterFlag=data.filterFlag
_this.sortCondition={}
for i,v in ipairs(_this.filterFlag)do
_this.sortCondition[i]={}
local fns=_this.filterName[i][2]
for i1,v1 in ipairs(v)do
if v1==true then
table.insert(_this.sortCondition[i],fns[i1].typeid)
end
end
end

_this:initGFListPanel()
end

function UIGongFaSelectWin:refreshArrow(isupdate)
local c=#self.gongfalist
local max=math.ceil(c/8)
if max==0 then
max=1
end
self.maxMenuIndex=max
if self.curMenuIndex>max then
self.curMenuIndex=1
end
self.leftBtn:setActive(self.curMenuIndex>1)
self.rightBtn:setActive(self.curMenuIndex<max)
end

function UIGongFaSelectWin:onLeftBtn()
if self.curMenuIndex>1 then
self.curMenuIndex=self.curMenuIndex-1
self:initGFListPanel()
end
end

function UIGongFaSelectWin:onRightBtn()
if self.curMenuIndex<self.maxMenuIndex then
self.curMenuIndex=self.curMenuIndex+1
self:initGFListPanel()
end
end


function UIGongFaSelectWin:rec_activepage()
self:initGFListPanel()
end

function UIGongFaSelectWin:rec_pageReward()
self:initGFListPanel()
end

function UIGongFaSelectWin:rec_study(gfID)

self:initGFListPanel()
end
