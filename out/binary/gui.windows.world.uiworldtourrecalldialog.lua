







def_class("UIWorldTourRecallDialog",UIWindowBase)







local tickTimer=nil

function UIWorldTourRecallDialog:bindComponents()

self.Icon=UIObject.get(self,0)
self.Name=UIText.get(self,1)
self.TimeTx=UIText.get(self,2)
self.Scroll_View=UIScrollView.get(self,3)
self.Button=UIImage.get(self,4)
self.ButtonTx=UIText.get(self,5)

self.Scroll_View:setClickAction(itemsComponentHelper.onItemClick)


end


function UIWorldTourRecallDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.Name);self.Name=nil;
_UIObject_release(self.TimeTx);self.TimeTx=nil;
_UIObject_release(self.Scroll_View);self.Scroll_View=nil;
_UIObject_release(self.Button);self.Button=nil;
_UIObject_release(self.ButtonTx);self.ButtonTx=nil;
end



















function UIWorldTourRecallDialog:onLoaded(...)
self:bindComponents()
end


function UIWorldTourRecallDialog:__delete()
self:unbindComponents()
self:stopTick()
end




function UIWorldTourRecallDialog:onShow(argtable,afterOnloaded)
if argtable then
self:initView(argtable)
end
end


function UIWorldTourRecallDialog:onHide()

end




function UIWorldTourRecallDialog:onClickClose()
self:closeSelf()
end

function UIWorldTourRecallDialog:onClickButton()
local nowTime=timeHelper.getServerShortTime()
local least=self.pointData.endtime-nowTime
if least<=0 then
worldTourController:send_5_72({self.pointData.travelpointid})
self:closeSelf()
else
local show_data={
type='UIDialouge',
title='召回弟子',
content=cfgHelper.get1(cfg_lang_get,'recall_tour_dz_tips'),
oktext='召回',
canceltext='取消',
okcallback=function()
worldTourController:send_5_72({self.pointData.travelpointid})
self:closeSelf()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
end

function UIWorldTourRecallDialog:initView(point)
self.pointData=worldTourModel:getData(point)
if self.pointData==nil then
loggerUtil.logErrFMT('没有找到pointData：{0}',point)
end
local discipleguid=self.pointData.discipleguid
self.discipleData=UIDiscipleModel:getDiscipleData(discipleguid)
comHelper.setChildHead(self.winlua,discipleguid,self.Icon:getID())
self.Name:setText(self.discipleData.disciplename)
local nowTime=timeHelper.getServerShortTime()
local least=self.pointData.endtime-nowTime
if least<=0 then
self.TimeTx:setText("已完成")
self.winlua:SetChildSpriteByPrefabIndex(self.Button:getID(),0,false)
self.ButtonTx:setText("领  取")
else
local duration=cfgHelper.getdef(cfg_worldtravelpointconfig,"duration")
self.TimeTx:setText(FMT.fmt("已游历<color=#549327>{0}</color>",timeHelper.format_time_stamp2(duration-least)))
self.winlua:SetChildSpriteByPrefabIndex(self.Button:getID(),1,false)
self.ButtonTx:setText("召回弟子")


if not tickTimer then
tickTimer=self:setTimer(1,0,function()self:onTickUpdate()end)
end
end



local pass=nowTime-self.pointData.begintime
local propDatas={}
local showConf={showname=false}
self.rewards=worldTourModel:calculateReward(point,pass)
for i,v in ipairs(self.rewards)do
table.insert(propDatas,itemsComponentHelper.getCommonFillData(v,showConf))
end
local cnt=#propDatas
local col=4
local row=math.ceil(cnt,col)
self.Scroll_View:freshGridsNum(cnt,row,col,false)
self.Scroll_View:initPropData(propDatas)
end

function UIWorldTourRecallDialog:onTickUpdate()
local nowTime=timeHelper.getServerShortTime()
local least=self.pointData.endtime-nowTime
if least>0 then
local duration=cfgHelper.getdef(cfg_worldtravelpointconfig,"duration")
self.TimeTx:setText(FMT.fmt("已游历<color=#549327>{0}</color>",timeHelper.format_time_stamp2(duration-least)))

else
self.TimeTx:setText("已完成")
self.winlua:SetChildSpriteByPrefabIndex(self.Button:getID(),1,false)
self.ButtonTx:setText("领  取")

self:stopTick()
end

local pass=nowTime-self.pointData.begintime
local rewards=worldTourModel:calculateReward(self.pointData.travelpointid,pass)
if#rewards==#self.rewards then
for i,v in ipairs(rewards)do
if itemsConfig.isMoney(v.itemid)then
self.Scroll_View:freshItem(i-1,PropIndex(DataPropKey.eWidgetText,4),v.itemcount)
else
local itemConfig=itemsConfig.getConfig(v.itemid)
if itemsConfig.dup then
self.Scroll_View:freshItem(i-1,PropIndex(DataPropKey.eWidgetText,4),v.itemcount)
end
end
end
else
self.Scroll_View:clearItems()
local propDatas={}
local showConf={showname=false}
for i,v in ipairs(rewards)do
table.insert(propDatas,itemsComponentHelper.getCommonFillData(v,showConf))
end
local cnt=#propDatas
local col=4
local row=math.ceil(cnt,col)
self.Scroll_View:freshGridsNum(cnt,row,col,false)
self.Scroll_View:initPropData(propDatas)
end
self.rewards=rewards
end

function UIWorldTourRecallDialog:stopTick()
if tickTimer then
self:stopTimerByID(tickTimer)
end
tickTimer=nil
end