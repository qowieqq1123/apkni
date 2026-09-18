







def_class("UIZhiYeEquipZHSelectWin",UIWindowBase)









function UIZhiYeEquipZHSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollView=UILoopListView.new(self,1)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIZhiYeEquipZHSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
end
















local _this
local equipidx=
{
item=0,
name=1,
att1=2,
att2=3,
back=4,
icon=5,
lvbg=6,
lv=7,
selectbtn=8,
}



function UIZhiYeEquipZHSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIZhiYeEquipZHSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UIZhiYeEquipZHSelectWin:onShow(argtable,afterOnloaded)
self.leftItemId=argtable.leftItemId
self.leftitemguId=argtable.leftitemguId
self.jinglianlv=argtable.jinglianlv

self.selectCallback=argtable.selectCallback

self.equipids=cfgHelper.get(cfg_disciplevocequipswitchconfig_get,1,"equipids")
local list={}
for k,equipid in ipairs(self.equipids)do
if equipid~=self.leftItemId then
table.insert(list,equipid)
end
end
self.equiplist=list

self:setItemList()
end


function UIZhiYeEquipZHSelectWin:onHide()

end
function UIZhiYeEquipZHSelectWin:onCloseClick()
self:closeSelf()
end


function UIZhiYeEquipZHSelectWin:setItemList()
local _slotName='item'
self.scrollView:initData(_slotName,self.equiplist)
end
function UIZhiYeEquipZHSelectWin:onStartAction()

end

function UIZhiYeEquipZHSelectWin:onFreshAction(i,widget,data)
self:onFreshWidget(i,widget,data)
end

function UIZhiYeEquipZHSelectWin:onFreshWidget(i,item,data)
local itemid=self.equiplist[i]
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local colorPage=itemConfig.colorPage or 0
local jinglianlv=self.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
if jinglianlv>0 then
item:SetChildActive(equipidx.lvbg,true)
item:SetChildText(equipidx.lv,jinglianStr)
else
item:SetChildActive(equipidx.lvbg,false)
end
item:SetChildText(equipidx.name,itemConfig.name)
item:SetChildQulaityEx(equipidx.back,colorPage,color)
local iconName=iconHelper.getIconName(itemid)
item:SetChildIcon(equipidx.icon,iconName,false)


item:SetChildButtonClickWithID(equipidx.icon,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=itemid,attach={showEnhancelv=self.jinglianlv}})
end,i)


item:SetChildButtonClick(equipidx.selectbtn,function()
if _this==nil then return end
_this:onSelectBtn(itemid)
end)

end


function UIZhiYeEquipZHSelectWin:onSelectBtn(itemid)
self.selectCallback(itemid)
self:onCloseClick()
end

