







def_class("UIXianJie_LeyLineRepairDetailWin",UIWindowBase)









function UIXianJie_LeyLineRepairDetailWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.empty=UIObject.get(self,2)
self.scrollView=UILoopListView.new(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXianJie_LeyLineRepairDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
self.scrollView:deleteSelf();self.scrollView=nil;
end















local _this=nil
local _itemShowCnt=7
local _itemPrefabName='item'



function UIXianJie_LeyLineRepairDetailWin:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(35,90,self.on_35_90)
self:addProNotify(35,91,self.on_35_91)

self.loopListView=self.winlua:GetChildUILoopListView(self.scrollView:getID())
self.loopListViewCmp=self.winlua:GetChildLoopListView2(self.scrollView:getID())
self.loopListView:SetAction(function(...)
self:onFreshListView(...)
end,function(...)
self:onStartView(...)
end)
end


function UIXianJie_LeyLineRepairDetailWin:__delete()

self.loopListView:SetAction(nil,nil)
self.loopListView=nil

self:unbindComponents()
_this=nil
end




function UIXianJie_LeyLineRepairDetailWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

self:initDatas()
self:refreshList()
end


function UIXianJie_LeyLineRepairDetailWin:onHide()

end




function UIXianJie_LeyLineRepairDetailWin:onBackground()
self:onCloseBtn()
end


function UIXianJie_LeyLineRepairDetailWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIXianJie_LeyLineRepairDetailWin:initDatas()
self.datas=xianjieModel:getLeyLineRepairLogs()







end

function UIXianJie_LeyLineRepairDetailWin:refreshList()
local count=#self.datas
self.empty:setActive(count<=0)
self.scrollView:setActive(count>0)
self.beginIdx=1
self.endIdx=count
if count>0 then
local prefablist={}
local itemidlist={}
for i=1,count do
table.insert(prefablist,_itemPrefabName)
table.insert(itemidlist,i)
end

self.loopListView:InitDataList(count,prefablist,itemidlist,nil,nil)
self.loopListView:JumpIndex(0)
end
end

function UIXianJie_LeyLineRepairDetailWin:onFreshListView(index,widget)
local data=self.datas[index+1]
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,xjClientBuildType.flcbXianYuLingMai)
local langId=FMT.fmt("leyline_repair_log_{0}",data.log_type)
local maxStage=#buildCfg.param.fixed_build_conf
data.actor_name=data.log_type==2 and maxStage or data.actor_name
local descStr=FMT.fmt(cfgHelper.getlang(langId),data.name,data.actor_name,buildCfg.name,data.score)
local width=widget:GetChildSizeDeltaX(3)
local str=comHelper.getCheckLayoutStr(widget:GetChildGameObject(3),width,descStr)
widget:SetChildText(2,str)
local longstamp=timeHelper.convertLongStamp(data.times)
local timeStr=timeHelper.dateServerStamp('%Y-%m-%d\n%H:%M:%S',longstamp)
widget:SetChildText(1,timeStr)
widget:ForceLayoutVertical(2)
widget:ForceLayoutRect(0)
end

function UIXianJie_LeyLineRepairDetailWin:onStartView()

end

function UIXianJie_LeyLineRepairDetailWin:onAddMesgList(msgs)
local empty=self.endIdx<=0
local since=#self.datas
local count=#msgs
if count>0 then
if self.endIdx<=0 then
self.empty:setActive(false)
self.scrollView:setActive(true)
end
end

for i=1,count do
local v=msgs[i]
table.insert(self.datas,v)
self.endIdx=self.endIdx+1
self.loopListView:AddItem(_itemPrefabName,self.endIdx,int64.zero,nil,false)
end

local removeList={}
local removeCnt=self.endIdx-self.beginIdx+1-_itemShowCnt
for i=1,removeCnt do
table.insert(removeList,self.beginIdx+i-1)
table.remove(self.datas,1)
end
if removeCnt>0 then
self.beginIdx=self.beginIdx+#removeList
self.loopListView:DeleteItemListByItemId(removeList)
end
end

function UIXianJie_LeyLineRepairDetailWin.on_35_90()
_this:initDatas()
_this:refreshList()
end

function UIXianJie_LeyLineRepairDetailWin.on_35_91(fairylandFixBuild)
if fairylandFixBuild.fix_build_id==xjClientBuildType.flcbXianYuLingMai then
_this.on_35_90()
end
end