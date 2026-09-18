







def_class("UIZhenTuYanJiuDetailWin",UIWindowBase)









function UIZhenTuYanJiuDetailWin:bindComponents()

self.scrollView=UIObject.get(self,0)
self.lzgmbtn=UIButton.get(self,1)
self.btnspine=UIObject.get(self,2)
self.gmtxt=UIText.get(self,3)

self.lzgmbtn:setButtonClick(function()self:onLzgmbtn()end)



end


function UIZhenTuYanJiuDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.lzgmbtn);self.lzgmbtn=nil;
_UIObject_release(self.btnspine);self.btnspine=nil;
_UIObject_release(self.gmtxt);self.gmtxt=nil;
end



















function UIZhenTuYanJiuDetailWin:onLoaded(...)
self:bindComponents()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIZhenTuYanJiuDetailWin:__delete()
self:unbindComponents()
end




function UIZhenTuYanJiuDetailWin:onShow(argtable,afterOnloaded)
local ztId=argtable
self:setAttrList(ztId)
self.zhentuId=ztId
self:refreshgmNum()
end

function UIZhenTuYanJiuDetailWin:setAttrList(ztId)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,ztId)
local len=#cfg.attr
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=cfg.attr[i]
local pr=UIYuFuLingZhenControl:getPrefixName(data[2])
local need=FMT.fmt('{0}灵阵需要<color=#549327>{1}级</color>',pr,data[3])
item:SetChildText(0,need)
local attrList=data[4]
local widgetIdx={{3,4},{5,8}}
local len=#attrList
for i,attr in ipairs(attrList)do
local stype=attr[1]
if stype==2 then
self:setAttrText(item,widgetIdx[i][1],stype,attr[2][1])
self:setAttrText(item,widgetIdx[i][2],stype,attr[2][2])
if len==1 and i==1 then
self:setAttrText(item,widgetIdx[i+1][1],stype,attr[2][3])
self:setAttrText(item,widgetIdx[i+1][2],stype,attr[2][4])
end
elseif stype==1 then
self:setAttrText(item,widgetIdx[i][1],stype,attr)
self:setAttrText(item,widgetIdx[i][2],stype,nil)
end
end













local abName,imgName="ui/windows/yufulingzhen/yufulingzhen_atlas_pak.ab",UIYuFuLingZhenControl:getZYIconName(data[2])

item:SetChildCSImageSprite(7,abName,imgName)
end
end

function UIZhenTuYanJiuDetailWin:setAttrText(item,index,stype,attr)
if attr then
item:SetChildActive(index,true)











if stype==2 then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
item:SetChildText(index,FMT.fmt('{0}+{1}',name,str))
elseif stype==1 then
item:SetChildText(index,FMT.fmt('该阵图中{0}灵阵的总属性+{1}%',attr[2]==0 and'所有'or UIYuFuLingZhenControl:getPrefixName(attr[2]),attr[3]*100))
end
else
item:SetChildActive(index,false)
end
end


function UIZhenTuYanJiuDetailWin:onHide()

end




function UIZhenTuYanJiuDetailWin:onCloseClick()
self:closeSelf()
end


function UIZhenTuYanJiuDetailWin:onLzgmbtn()
UIManager:showWindow("UILZGMTipsWin",{0,5,0,{zhentuId=self.zhentuId}})
end
function UIZhenTuYanJiuDetailWin:refreshgmNum()
self.gmtxt:setText("0/5")
local actionid=eAnimationID.stand
self.btnspine:setChildUIModelShowTarget(5705,1,nil,actionid)
end