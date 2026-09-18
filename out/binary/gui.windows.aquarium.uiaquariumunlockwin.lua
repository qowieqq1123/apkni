







def_class("UIAquariumUnlockWin",UIWindowBase)









function UIAquariumUnlockWin:bindComponents()

self.scrollView=UIObject.get(self,0)
self.actScrollView=UIObject.get(self,1)
self.count=UIText.get(self,2)



end


function UIAquariumUnlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.actScrollView);self.actScrollView=nil;
_UIObject_release(self.count);self.count=nil;
end
















local _item_index=
{
select=0,
count=1,
desc=2,
gou=3,
suo=4,
jindu1=5,
jindu2=6,
jindu3=7,
jindu4=8,
xin=9,
}




function UIAquariumUnlockWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.actScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIAquariumUnlockWin:__delete()
self:unbindComponents()

UIAquariumControl:recordCollectFlagData()
UIAquariumControl:recordSuitFlagData()
reddotControl.on_change_catch_type(CATCH_TYPE.eYueLongChi)
UIManager:callWindowFunc('UIAquariumWin','setHBReddot')
UIManager:callWindowFunc('UIYYHYWin','refreshtujianreddot')
end




function UIAquariumUnlockWin:onShow(argtable,afterOnloaded)
self:showCountList()
self:showUnlockList()
end

function UIAquariumUnlockWin:showCountList()
local unlockNum=UIAquariumControl:getHBActiveCount()
local cfgs=cfg_yuelongchicollectconfig()
local checkData=UIAquariumControl:getCollectFlagData()
local len=#cfgs
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local lastCfg=cfgs[i-1]
local cfg=cfgs[i]
local nextCfg=cfgs[i+1]
local checkLast=lastCfg~=nil
local check=unlockNum>=cfg.total
local checkNext=nextCfg~=nil
item:SetChildActive(_item_index.select,check)
if check then
item:SetChildText(_item_index.count,FMT.fmt('<color=#ca631d>{0}</color>',cfg.total))
else
item:SetChildText(_item_index.count,cfg.total)
end
local yt,val=next(cfg.show_percent)
local tname=UIAquariumControl:getYuTypeName(yt)
local dstr='<color=#9a682e>收集鱼类{0}种</color>\n<color=#6833c0>{1}</color>灵韵值增加{2}%'
item:SetChildText(_item_index.desc,FMT.fmt(dstr,cfg.total,tname,val))
item:SetChildActive(_item_index.gou,check)
item:SetChildActive(_item_index.suo,not check)
item:SetChildActive(_item_index.xin,check and not checkData[i])
item:SetChildIconFillAmount(_item_index.jindu1,i==count and 0.5 or 1)
item:SetChildActive(_item_index.jindu2,not check)
local jd=0
if check then
if checkNext then
local hf=(nextCfg.total-cfg.total)/2
local dv=unlockNum-cfg.total
jd=math.min(1,(dv/hf)*0.5+0.5)
else
jd=0.5
end
else
if checkLast then
local hf=(cfg.total-lastCfg.total)/2
local dv=unlockNum-lastCfg.total-hf
jd=math.min(0.5,(dv/hf)*0.5)
else
jd=math.min(0.5,(unlockNum/cfg.total)*0.5)
end
end
jd=math.max(0,jd)
item:SetChildIconFillAmount(_item_index.jindu3,jd)
item:SetChildActive(_item_index.jindu4,check)
end

local mcfg=cfgs[len]
self.count:setText(FMT.fmt('{0}/{1}',unlockNum,mcfg.total))
end

function UIAquariumUnlockWin:showUnlockList()
local itemIndexs={3,4,5,6}
local cfgs=cfg_yuelongchisuitconfig()
local checkData=UIAquariumControl:getSuitFlagData()
local len=#cfgs
self.actScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.actScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=cfgs[i]
local isAct=true
for i,v in ipairs(itemIndexs)do
local data=cfg.active[i]
if data then
item:SetChildActive(v,true)
local need=data[2]
local hbcfg=cfgHelper.get1(cfg_yuelongchibookconfig_get,data[1])
local info=cfgHelper.get1(cfg_ylcinfoconfig_get,hbcfg.info)
local itemConfig=itemsConfig.getConfig(info.show_item)
local widget=item:GetChildWidgetBase(v)
widget:SetChildCSImageSprite(0,self.abName,'image_cyhyyupj_'..(hbcfg.color+math.floor(need/5)))
widget:SetChildIcon(1,iconHelper.getIconName(itemConfig.icon),true)
local hbdata=UIAquariumControl:getHandleBookData(data[1])
widget:SetChildButtonClick(1,function()
itemsComponentHelper.onItemClickEx(info.show_item)
end)
local unlock=hbdata and hbdata.star>=need
item:SetChildGraphicGray(v,not unlock,true)
if not unlock then
isAct=false
end
else
item:SetChildActive(v,false)
end
end
item:SetChildActive(2,isAct)
if isAct then
item:SetChildText(0,FMT.fmt('<color=#7d3b17>{0}</color>',cfg.name))
item:SetChildText(1,FMT.fmt('<color=#ca631d>灵韵+{0}</color>',cfg.lingyun))
else
item:SetChildText(0,cfg.name)
item:SetChildText(1,FMT.fmt('灵韵+{0}',cfg.lingyun))
end
item:SetChildActive(7,isAct and not checkData[tostring(i)])
end
end


function UIAquariumUnlockWin:onHide()

end



