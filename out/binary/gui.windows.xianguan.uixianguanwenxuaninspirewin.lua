







def_class("UIXianGuanWenXuanInspireWin",UIWindowBase)









function UIXianGuanWenXuanInspireWin:bindComponents()

self.againstBtn=UIButton.get(self,0)
self.againstCost=UIText.get(self,1)
self.againstTx=UIText.get(self,2)
self.agreeBtn=UIButton.get(self,3)
self.agreeCost=UIText.get(self,4)
self.agreeTx=UIText.get(self,5)
self.background=UIButton.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.contentTx=UILinkImageText.get(self,8)
self.descTitle=UIText.get(self,9)
self.gotoBtn=UIButton.get(self,10)
self.head=UIObject.get(self,11)
self.mbg=UIObject.get(self,12)
self.modelHead=UIObject.get(self,13)
self.modelHeadIcon=UIImage.get(self,14)
self.moneyRoot1=UIObject.get(self,15)
self.moneyRoot2=UIObject.get(self,16)
self.moneyRoot3=UIObject.get(self,17)
self.nameTx=UIText.get(self,18)
self.playerInfo=UIObject.get(self,19)
self.root=UIObject.get(self,20)
self.serverNameTx=UIText.get(self,21)
self.xmNameTx=UIText.get(self,22)

self.againstBtn:setButtonClick(function()self:onAgainstBtn()end)

self.agreeBtn:setButtonClick(function()self:onAgreeBtn()end)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIXianGuanWenXuanInspireWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.againstBtn);self.againstBtn=nil;
_UIObject_release(self.againstCost);self.againstCost=nil;
_UIObject_release(self.againstTx);self.againstTx=nil;
_UIObject_release(self.agreeBtn);self.agreeBtn=nil;
_UIObject_release(self.agreeCost);self.agreeCost=nil;
_UIObject_release(self.agreeTx);self.agreeTx=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.contentTx);self.contentTx=nil;
_UIObject_release(self.descTitle);self.descTitle=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.modelHead);self.modelHead=nil;
_UIObject_release(self.modelHeadIcon);self.modelHeadIcon=nil;
_UIObject_release(self.moneyRoot1);self.moneyRoot1=nil;
_UIObject_release(self.moneyRoot2);self.moneyRoot2=nil;
_UIObject_release(self.moneyRoot3);self.moneyRoot3=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.playerInfo);self.playerInfo=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.serverNameTx);self.serverNameTx=nil;
_UIObject_release(self.xmNameTx);self.xmNameTx=nil;
end
















local _this
local _jx_ab=globalABLookup.xianguanJingXuan




function UIXianGuanWenXuanInspireWin:onLoaded(...)
self:bindComponents()
_this=self
self.fmTweener={}
self._onItemListChanged=function(...)self:onItemListChanged(...)end
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self._onItemListChanged)
end


function UIXianGuanWenXuanInspireWin:__delete()
self:unbindComponents()

for k,v in pairs(self.fmTweener)do
v:Kill()
end
notifySystem:removelistener(notifyConfig.on_item_list_changed,self._onItemListChanged)
_this=nil
end




function UIXianGuanWenXuanInspireWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.curJobId=argtable.jobId
self.actorId=argtable.actorId
self.bwFlag=argtable.bwFlag

for k,v in pairs(self.fmTweener)do
v:Kill()
end
self.fmTweener={}
self.lastcount={}

self.config=cfgHelper.get1(cfg_officerelectionbasic1config_get,1)

local list=xianguanModel:getWenXuanRecordList(self.curJobId)
if not list or xianguanModel:getIsSendWenXuanRecord(self.curJobId)then
xianguanController:req_send_40_5(self.curJobId)
else
self:refreshPanel()
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(5901,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end


function UIXianGuanWenXuanInspireWin:onHide()

end

function UIXianGuanWenXuanInspireWin:refreshPanel()
local rank=xianguanModel:getWenXuanElectionRecordRankByActorId(self.curJobId,self.actorId)
local myRecordData=xianguanModel:getWenXuanRecordData(self.curJobId,rank)
if not myRecordData then
return
end
local agreeStr=FMT.fmt("支持数：{0}",myRecordData.agree_num)
local againstStr=FMT.fmt("反对数：{0}",myRecordData.against_num)
self.agreeTx:setText(agreeStr)
self.againstTx:setText(againstStr)

local serverName=loginModel:getServerName(myRecordData.server_id)
serverName=FMT.fmt('[{0}]',serverName)
local guild_name=myRecordData.guild_name~=""and FMT.fmt('[{0}]',myRecordData.guild_name)or"暂无"

self.nameTx:setText(myRecordData.name)
self.serverNameTx:setText(serverName)
self.xmNameTx:setText(guild_name)

local jobCfg=xianguanConfig.getJobConfig(1,self.curJobId)
local declarationStr=cfgHelper.get2(cfg_officerelectiondeclarationconfig_get,myRecordData.declaration_idx,"desc")

local desc
if self.bwFlag and self.bwFlag==1 then
desc=FMT.fmt("帮帮我，我正在参加<color=#ca631d>【{0}】</color>补位仙官文选！\n我的参选宣言是：",jobCfg.name)
else
desc=FMT.fmt("帮帮我，我正在参加<color=#ca631d>【{0}】</color>仙官文选！\n我的参选宣言是：",jobCfg.name)
end

self.descTitle:setText(desc)
self.contentTx:setText(chatEmotHelper.decodeEmot(declarationStr))

local iconInfo=myRecordData.iconInfo
playerController:setHeadIcon(self.winlua,self.head:getID(),{scale=1,iconInfo=iconInfo})
playerController:setImage(self.winlua,self.modelHeadIcon:getID(),nil,iconInfo,false,nil,nil)

local wxData=xianguanModel:getWenXuanData()
local use_vote_agree_num=wxData and wxData.use_vote_agree_num or 0
local count1=self.config.free_vote_agree-use_vote_agree_num
local widget1=self.winlua:GetChildWidgetBase(self.moneyRoot1:getID())
widget1:SetChildCSImageSprite(0,_jx_ab,"image_dianzan_1")
widget1:SetChildText(1,count1)
widget1:SetChildActive(3,false)
self.lastcount[1]=count1

local use_vote_against_num=wxData and wxData.use_vote_against_num or 0
local count2=self.config.free_vote_against-use_vote_against_num
local widget2=self.winlua:GetChildWidgetBase(self.moneyRoot2:getID())
widget2:SetChildCSImageSprite(0,_jx_ab,"image_dianzan_2")
widget2:SetChildText(1,count2)
widget2:SetChildActive(3,false)
self.lastcount[2]=count2

local widget3=self.winlua:GetChildWidgetBase(self.moneyRoot3:getID())
local itemid=self.config.item_vote_agree
local itemCount=bagModel.getNotExpireItemCountById(itemid)
local iconName=iconHelper.getIconName(itemid)
widget3:SetChildIcon(0,iconName,false)
widget3:SetChildText(1,itemCount)
widget3:SetChildActive(3,true)
widget3:SetChildButtonClick(2,function()
gainControl:showGainWin(itemid)
end)
self.lastcount[3]=itemCount

self.agreeBtn:setGray(count1+itemCount<=0)
self.againstBtn:setGray(count2+itemCount<=0)
end

function UIXianGuanWenXuanInspireWin:refreshView(actorid,vote)
if not mathHelper.compareInt64(actorid,self.actorId)then
return
end

local wxData=xianguanModel:getWenXuanData()

local use_vote_agree_num=wxData and wxData.use_vote_agree_num or 0
local count1=self.config.free_vote_agree-use_vote_agree_num

local use_vote_against_num=wxData and wxData.use_vote_against_num or 0
local count2=self.config.free_vote_against-use_vote_against_num

local itemCount=bagModel.getNotExpireItemCountById(self.config.item_vote_agree)

if vote==1 then
self:freshMoneyValue(1,count1)
elseif vote==2 then
self:freshMoneyValue(2,count2)
end

self.agreeBtn:setGray(count1<=0 and itemCount<=0)
self.againstBtn:setGray(count2<=0 and itemCount<=0)

local rank=xianguanModel:getWenXuanElectionRecordRankByActorId(self.curJobId,self.actorId)
local myRecordData=xianguanModel:getWenXuanRecordData(self.curJobId,rank)
local agreeStr=FMT.fmt("支持数：{0}",myRecordData.agree_num)
local againstStr=FMT.fmt("反对数：{0}",myRecordData.against_num)
self.agreeTx:setText(agreeStr)
self.againstTx:setText(againstStr)
end

function UIXianGuanWenXuanInspireWin:freshMoneyValue(index,itemCount)
local rootStr=FMT.fmt('moneyRoot{0}',index)
local widget=self.winlua:GetChildWidgetBase(self[rootStr]:getID())
self:clearFMTweener(index)
self.fmTweener[index]=_DOTweenProxy.DoValueTo(function()
return self.lastcount[index]
end,function(val)
local count=math.floor(val)
self.lastcount[index]=count
widget:SetChildText(1,count)
end,itemCount,1)
end

function UIXianGuanWenXuanInspireWin:clearFMTweener(index)
if self.fmTweener[index]then
self.fmTweener[index]:Kill()
self.fmTweener[index]=nil
end
end

function UIXianGuanWenXuanInspireWin:showVoteTips(vote)
local wxData=xianguanModel:getWenXuanData()
local count
local itemCount=bagModel.getItemCountById(self.config.item_vote_agree)
if vote==1 then
local use_vote_agree_num=wxData and wxData.use_vote_agree_num or 0
count=self.config.free_vote_agree-use_vote_agree_num
else
local use_vote_against_num=wxData and wxData.use_vote_against_num or 0
count=self.config.free_vote_against-use_vote_against_num
end
if itemCount<=0 and count<=0 then
UIManager.error("暂无选票")
return
end
local rank=xianguanModel:getWenXuanElectionRecordRankByActorId(self.curJobId,self.actorId)
local myRecordData=xianguanModel:getWenXuanRecordData(self.curJobId,rank)
local args={
parentWin=self,
actorId=self.actorId,
vote=vote,
job=self.curJobId,
actorName=myRecordData.name,
}
self:showWindow("UIXianGuanWenXuanVoteTipsWin",args)
end

function UIXianGuanWenXuanInspireWin:onItemListChanged(list)
if list==nil then return end

for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]

if itemid==self.config.item_vote_agree then
local itemCount=bagModel.getNotExpireItemCountById(self.config.item_vote_agree)
self:freshMoneyValue(3,itemCount)
self:refreshView(self.actorId)
break
end
end
end





function UIXianGuanWenXuanInspireWin:onBackground()
self:onCloseBtn()
end



function UIXianGuanWenXuanInspireWin:onCloseBtn()
if self.parentwin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end



function UIXianGuanWenXuanInspireWin:onAgreeBtn()
self:showVoteTips(1)
end



function UIXianGuanWenXuanInspireWin:onAgainstBtn()
self:showVoteTips(2)
end



function UIXianGuanWenXuanInspireWin:onGotoBtn()
local curJobId=self.curJobId
self:onCloseBtn()
UIManager:closeWindow("UIChatWin")
jumpManager:jump({id=JUMP_TYPE.eXianGuanWenXuan,jobId=curJobId})
end