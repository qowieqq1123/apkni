







def_class("UIGongFaRecycleWin",UIWindowBase)









function UIGongFaRecycleWin:bindComponents()

self.backNum=UIText.get(self,0)
self.center=UIObject.get(self,1)
self.recycleBtn=UIButton.get(self,2)
self.recycleContent=UIObject.get(self,3)
self.selectAll=UIToggleButton.get(self,4)
self.titleTxt=UIText.get(self,5)

self.recycleBtn:setButtonClick(function()self:onRecycleBtn()end)



end


function UIGongFaRecycleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backNum);self.backNum=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.recycleBtn);self.recycleBtn=nil;
_UIObject_release(self.recycleContent);self.recycleContent=nil;
_UIObject_release(self.selectAll);self.selectAll=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end



















function UIGongFaRecycleWin:onLoaded(...)
self:bindComponents()
self.selectAll:setToggleChange(function(...)self:onSelectAll(...)end)
end


function UIGongFaRecycleWin:__delete()
self:unbindComponents()
end




function UIGongFaRecycleWin:onShow(argtable,afterOnloaded)
self.selectGongFaIndex={}
self.recycleList=UIGongFaModel:getGongFaRecycleList()
if#self.recycleList<=0 then
return self:closeSelf()
else
self.recycleContent:setChildLayoutGroupCreateItems(#self.recycleList,function(index)
local item=self.recycleContent:getChildLayoutGroupGridItem(index-1)
local data=self.recycleList[index]
local gfID=data.gfID
local gfNum=data.gfNum
local pieceItemId=data.piece
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local countStr=gfNum>1 and mathHelper.formatNumber(gfNum)or''
local showCountBG=gfNum>1
local conf={itemid=pieceItemId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetText,4)]=gfCfg.name
item:SetBaseItemChildIndex(0,index)
item:SetBaseItemClickEvent(0,function(...)
if not self or self.isClose then return end
self:onClickGongFaItem(...)
end)
item:SetBaseItemLongTouchEvent(0,function(...)
if not self or self.isClose then return end
self:onLongClickGongFaItem(...)
end)
item:SetChildPropData(0,prop)
item:SetChildActive(2,false)
end)
self.backNum:setText(0)
self.selectAll:setToggle(false)
self.selectAll:setToggle(true)
end
end

function UIGongFaRecycleWin:onSelectAll(name,on,data)
if on then
for index,_ in ipairs(self.recycleList)do
if not self.selectGongFaIndex[index]then
self.selectGongFaIndex[index]=true
local item=self.recycleContent:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,true)
end
end
else
for index,_ in ipairs(self.recycleList)do
if self.selectGongFaIndex[index]then
self.selectGongFaIndex[index]=nil
local item=self.recycleContent:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,false)
end
end
end
self:refreshBackMoney()
end

function UIGongFaRecycleWin:onClickGongFaItem(itemid,index,itemguid,attach)
local item=self.recycleContent:getChildLayoutGroupGridItem(index-1)
if not self.selectGongFaIndex[index]then
self.selectGongFaIndex[index]=true
item:SetChildActive(2,true)
else
self.selectGongFaIndex[index]=nil
item:SetChildActive(2,false)
end
self:refreshBackMoney()
end

function UIGongFaRecycleWin:onLongClickGongFaItem(itemid,index,itemguid,attach)
local data=self.recycleList[index]
local gfID=data.gfID
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eGongFaRecycle,itemid=itemid,itemguid=itemguid,attach={nameReplace=gfCfg.name,hideTipsHasNum=true}})
end

function UIGongFaRecycleWin:refreshBackMoney()
local total=0
for index,flag in pairs(self.selectGongFaIndex)do
if flag then
local data=self.recycleList[index]
local gfID=data.gfID
local gfNum=data.gfNum
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
total=total+(gfCfg.study_back*gfNum)
end
end
self.backNum:setText(string.format("x%d",total))
end


function UIGongFaRecycleWin:onRecycleBtn()
local back_list={}
for index,flag in pairs(self.selectGongFaIndex)do
if flag then
local data=self.recycleList[index]
local gfID=data.gfID
table.insert(back_list,gfID)
end
end
if#back_list<=0 then
return UIManager.info("请先选择需要回收的功法")
end
local str='是否将已达到研习满级的\n多余功法典籍回收？'
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
UIGongFaController:reqGongFaOneKeyRecycle(#back_list,back_list)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

