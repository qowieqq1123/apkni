







def_class("UIHuDaoFuSelectWin",UIWindowBase)









function UIHuDaoFuSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.infoPanel=UIObject.get(self,2)
self.scrollview=UIObject.get(self,3)
self.notItemTips=UIText.get(self,4)



end


function UIHuDaoFuSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.notItemTips);self.notItemTips=nil;
end
















local _this

local huDaoFuItemCmp=
{
select=0,
item=1,
name=2,
desc=3,
selectFlag=4,

}



function UIHuDaoFuSelectWin:onLoaded(...)
_this=self
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
end


function UIHuDaoFuSelectWin:__delete()
_this=nil
self:unbindComponents()
end




function UIHuDaoFuSelectWin:onShow(argtable,afterOnloaded)
if argtable and argtable.discipleGuid then

self.discipleGuid=argtable.discipleGuid
else
logErr("护道符界面无法获取当前弟子guid 请检查前端代码中调用此窗口时传参是否正确")
return self.closeSelf()
end

local cb=function()
self:onLoadFinish()
end
self.infoPanel:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)

self.useItemId=FeiShengTaiModel:getSelectHuDaoFuItemId()
self:refreshHuDaoFuList()
end

function UIHuDaoFuSelectWin:refresh()
self.useItemId=FeiShengTaiModel:getSelectHuDaoFuItemId()
self:refreshHuDaoFuList()
end


function UIHuDaoFuSelectWin:onHide()

end

function UIHuDaoFuSelectWin:onLoadFinish()
local func=function()
self.infoPanel:setChildCanvasGroupDOFade(1,0.25,nil)
end
self:delayDo(0.3,func)
end

function UIHuDaoFuSelectWin:getHuDaoFuList()

self.huDaoFuList={}
local jinJieLevel=UIDiscipleModel:getDiscipleJJLevel(self.discipleGuid)
local dzFloor=UIDiscipleModel:getJJFloor(jinJieLevel)

local lp={}
local maxlp={}
local list=itemsLookup:get_function_items(item_funtion_type.huDaoFu)or{}
for k,v in pairs(list)do
local stage=v.stage or 0
local needFloorList=lp[stage]
if needFloorList==nil then
needFloorList=FeiShengTaiModel.getHuDaoFuRetainJJFloor(stage)or{}
lp[stage]=needFloorList
maxlp[stage]=table.maxn(needFloorList)
end
if needFloorList[dzFloor]==1 then
local num=bagModel.getItemCountById(v.id)
if num>0 then
local stage=v.stage or 0
local weight=stage*10+v.color
local max_floor=maxlp[stage]
table.insert(self.huDaoFuList,{v,weight,max_floor})
end
end
end

if#self.huDaoFuList>0 then
table.sort(self.huDaoFuList,function(a,b)
return a[2]<b[2]
end)
end
end

function UIHuDaoFuSelectWin:refreshHuDaoFuList()
self:getHuDaoFuList()
self.scrollview:setChildScrollViewCreateGrids(#self.huDaoFuList,1)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
if widget then
local data=self.huDaoFuList[i]
local max_floor=data[3]
local itemData=data[1]
local itemId=itemData.id
local itemcount=itemBagModel:getItemCountByItemID(itemId)
local countStr=''
local cfg=itemsConfig.getConfig(itemId)
if itemcount then
if itemcount>0 then
countStr=itemcount
else
countStr=FMT.cfmt(FONT_COLOR.eRedColor,tostring(itemcount))
end
end

local conf={itemid=itemId,itemcount=countStr,showCountBG=countStr~='',showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local isSelect=self.useItemId and itemId==self.useItemId or false
widget:SetChildPropData(huDaoFuItemCmp.item,prop)
widget:SetBaseItemClickEvent(huDaoFuItemCmp.item,function()
if _this==nil then return end
_this:onGoodItemClick(i)
end)

local name_str=FMT.fmt('{0}（{1}）',cfg.name,UIDiscipleModel:getJJFloorName(max_floor))
widget:SetChildText(huDaoFuItemCmp.name,name_str)
widget:SetChildActive(huDaoFuItemCmp.selectFlag,isSelect)

local funcparam=cfg.funcparam
local percent=funcparam and funcparam.percent
if percent then
widget:SetChildText(huDaoFuItemCmp.desc,FMT.fmt("渡劫失败时修为保留{0}%",percent))
else
logErr(FMT.fmt("找不到道具Id为{0} 所对应的护道符保留经验百分比 请确认配置是否正确",itemId))
end
end
end

self.notItemTips:setActive(not count or count<=0)
end

function UIHuDaoFuSelectWin:onGoodItemClick(idx)
local data=self.huDaoFuList[idx]
local itemData=data[1]
local itemId=itemData.id
local itemNum=itemBagModel:getItemCountByItemID(itemId)
local attach=nil
if itemNum>0 then
local idx_=idx-1
attach={}
attach.insertBtnList={TIPS_BTNS_TYPE.eHuDaoFuSelect}
attach.hudaofuSelectFunc=function()
if _this==nil then return end
UIHuDaoFuSelectWin.on_item_click(0,idx_)
end
end
itemsComponentHelper.onItemClick(itemId,nil,nil,attach)
end

function UIHuDaoFuSelectWin.on_item_click(clickNum,index)
local data=_this.huDaoFuList[index+1]
if data then

local itemData=data[1]
local itemId=itemData.id
local itemNum=itemBagModel:getItemCountByItemID(itemId)
if itemNum<=0 then


return gainControl:showGainWin(itemId)
end


FeiShengTaiModel:setSelectHuDaoFuItemId(itemId)

UIManager:invokeUIMethod("UIDiscipleJingJieBrokeWin","refreshFuLuItemPanel")


return _this:closeSelf()
end
end

function UIHuDaoFuSelectWin:onCloseClick()
self:closeSelf()
end




