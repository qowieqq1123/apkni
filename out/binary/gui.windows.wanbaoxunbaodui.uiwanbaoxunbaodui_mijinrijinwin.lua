







def_class("UIWanBaoXunBaoDui_MiJinRiJinWin",UIWindowBase)









function UIWanBaoXunBaoDui_MiJinRiJinWin:bindComponents()

self.topTipsText=UIText.get(self,0)
self.showRankBtn=UIButton.get(self,1)
self.rankFirstList=UIObject.get(self,2)
self.leftBtn=UIButton.get(self,3)
self.rightBtn=UIButton.get(self,4)
self.timeText=UIText.get(self,5)
self.bottomTipsText=UIText.get(self,6)
self.Content=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.time=UIText.get(self,9)
self.catpanel=UIObject.get(self,10)
self.catmodelone=UIObject.get(self,11)
self.catmodeltwo=UIObject.get(self,12)
self.catmodelthree=UIObject.get(self,13)
self.mask=UIButton.get(self,14)
self.onclosebtn=UIButton.get(self,15)
self.bgModel=UIObject.get(self,16)

self.showRankBtn:setButtonClick(function()self:onShowRankBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.onclosebtn:setButtonClick(function()self:onOnclosebtn()end)



end


function UIWanBaoXunBaoDui_MiJinRiJinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topTipsText);self.topTipsText=nil;
_UIObject_release(self.showRankBtn);self.showRankBtn=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.bottomTipsText);self.bottomTipsText=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.catpanel);self.catpanel=nil;
_UIObject_release(self.catmodelone);self.catmodelone=nil;
_UIObject_release(self.catmodeltwo);self.catmodeltwo=nil;
_UIObject_release(self.catmodelthree);self.catmodelthree=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.onclosebtn);self.onclosebtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
end

















local _this
local abname="ui/windows/wanbaoxunbaodui/wanbaoxunbaodui_atlas_pak.ab"
local maxOpenNum=3


function UIWanBaoXunBaoDui_MiJinRiJinWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:__delete()
self:unbindComponents()
_this=nil
end




function UIWanBaoXunBaoDui_MiJinRiJinWin:onShow(argtable,afterOnloaded)
self.bgModel:setChildUIModelShowTarget(5041,1,{},eAnimationID.enter,false,false,0,nil)
self:refreshScrollerView()
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:onHide()

end





function UIWanBaoXunBaoDui_MiJinRiJinWin:onShowRankBtn()
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:onLeftBtn()
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:onRightBtn()
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:recvRefresh()

self:refreshScrollerView()
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:getAdvPoints()
local severdata=MysteryModel:getWanBaoXunBaoDuiData()

local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local cfg_mj=cfg_catcatmijingbaseconfig_get(1).ptMiJing
local list={}
local tempnum=0
local num=MysteryModel:getWanBaoXunBaoDuiTXNum()



for k,v in ipairs(cfg_mj)do
local mj_idx=v
local cfg_mj=cfg_catcatmijingconfig_get(mj_idx)
local mj_id=cfg_mj.id
local mj_sever_data=severlist[mj_id]
if mj_sever_data then

local sever_jindu=mj_sever_data.percent or 0
local sever_ismj=mj_sever_data.closeFlag or 0
local rwFlag=mj_sever_data.rwFlag or 0
if sever_jindu<100 or sever_ismj==0 then
table.insert(list,{v,sever_jindu,rwFlag})
tempnum=tempnum+1
else
local isopen=self:checkopenmijin(cfg_mj)
if isopen then
table.insert(list,{v,sever_jindu,rwFlag})
end
end
else

local isopen=self:checkopenmijin(cfg_mj)
if isopen then
table.insert(list,{v,0,0})
tempnum=tempnum+1
end
end
if tempnum>=maxOpenNum then
break
end
end




local newlist={}

















local mijindata=userActorSetting.get('UIWanBaoXunBaoDui_MiJinTipsWin_openMiJin',{})

for k,v in ipairs(mijindata)do
for i,j in ipairs(list)do
if v==j[1]then
newlist[#newlist+1]=j
end
end
end






local listnew={}
for i,v in ipairs(newlist)do
local state
if v[3]==0 and v[2]==100 then
state=1
elseif v[3]==0 and v[2]<100 then
state=0
elseif v[3]==1 then
state=-1
end
local weight=state*100+(100-i)
table.insert(listnew,{v,weight})
end

table.sort(listnew,function(a,b)
return a[2]>b[2]
end)


return listnew
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:checkopenmijin(cfg_mj)
local isopen=true
local openLimit=cfg_mj.openLimit

if openLimit[1]then
local day_=timeHelper.getServerOpenDay()
if day_<openLimit[1]then
isopen=false
end
end

if openLimit[2]then
local level=zongmenModel:getLevel()
if level<openLimit[2]then
isopen=false
end
end

if openLimit[3]then
local oldVal=playerModel:getActorFightValue()
if oldVal<openLimit[3]then
isopen=false
end
end
return isopen
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:refreshScrollerViewSingle(ccmjId)

if#_this.olddatalist==0 or not ccmjId then return end
local _index
for k,v in ipairs(_this.olddatalist)do
local mjidx=v[1][1]
if mjidx==ccmjId then
_index=k
end
end
if _index then
local grids=_this.rankFirstList:getChildScrollViewItemWidgets()
local item=grids[_index-1]
local mjidx=ccmjId

local cfg_mj=cfg_catcatmijingconfig_get(mjidx)
local mjId=cfg_mj.id
local cfg_mj_ditu=cfg_secretscenefubenconfig_get(mjId)
local name=cfg_mj_ditu.name
local rijidesc=cfg_mj.rijidesc
local rijidesc_ywc=cfg_mj.rijidescywc
rijidesc=string.replaceSpace(rijidesc)
rijidesc_ywc=string.replaceSpace(rijidesc_ywc)
local iconbigimg=cfg_mj.iconbigimg
local rewards=cfg_mj.rewards[1]



item:SetChildText(4,rijidesc)


local flag=1
local severdata=MysteryModel:getWanBaoXunBaoDuiData()
local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local mj_sever_data=severlist[mjId]
local rwFlag
local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
rwFlag=mj_sever_data.rwFlag
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end


if sever_jindu>=100 and sever_ismj==1 then
item:SetChildActive(3,true)
item:SetChildText(4,rijidesc_ywc)
else
item:SetChildActive(3,false)
item:SetChildText(4,rijidesc)
end


if rwFlag then
if rwFlag==1 then
flag=3
elseif rwFlag==0 and sever_jindu>=100 and sever_ismj==1 then
flag=2
end
else
flag=1
end


local itemwidget=item:GetChildWidgetBase(5)
if flag==2 then
itemwidget:SetChildActive(3,true)
elseif flag==3 then
itemwidget:SetChildActive(2,true)
itemwidget:SetChildActive(3,false)
elseif flag==1 then
itemwidget:SetChildActive(2,false)
itemwidget:SetChildActive(3,false)
end









end
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:refreshScrollerView()
local datalist=self:getAdvPoints()
_this.olddatalist=self:getAdvPoints()
if#datalist==0 then return end
local cfg_ptMiJing=cfg_catcatmijingbaseconfig_get(1).ptMiJing
local _list={}







for k,v in ipairs(cfg_ptMiJing)do
_list[#_list+1]=v
end
if#datalist<#_list then
datalist[#datalist+1]={{100},-10000}
end
_this.rankFirstList:setChildScrollViewCreateGrids(#datalist,#datalist)
local grids=_this.rankFirstList:getChildScrollViewItemWidgets()
_this.pageCount=#_this.rankFirstList
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local mjidx=datalist[i][1][1]
if mjidx~=100 then
local cfg_mj=cfg_catcatmijingconfig_get(mjidx)
local mjId=cfg_mj.id
local cfg_mj_ditu=cfg_secretscenefubenconfig_get(mjId)
local name=cfg_mj_ditu.name
local rijidesc=cfg_mj.rijidesc
local rijidesc_ywc=cfg_mj.rijidescywc
rijidesc=string.replaceSpace(rijidesc)
rijidesc_ywc=string.replaceSpace(rijidesc_ywc)
local iconbigimg=cfg_mj.iconbigimg
local rewards=cfg_mj.rewards[1]

item:SetChildText(2,name)
item:SetChildCSImageSprite(1,abname,iconbigimg)
item:SetChildText(4,rijidesc)


local flag=1
local severdata=MysteryModel:getWanBaoXunBaoDuiData()
local severlist={}
if severdata and#severdata>0 then
for k,v in ipairs(severdata)do
severlist[v.ssId]=v
end
end
local mj_sever_data=severlist[mjId]
local rwFlag
local sever_jindu=0
local sever_ismj=0
if mj_sever_data then
rwFlag=mj_sever_data.rwFlag
sever_jindu=mj_sever_data.percent
sever_ismj=mj_sever_data.closeFlag
end


if sever_jindu>=100 and sever_ismj==1 then
item:SetChildActive(3,true)
item:SetChildText(4,rijidesc_ywc)
else
item:SetChildActive(3,false)
item:SetChildText(4,rijidesc)
end


if rwFlag then
if rwFlag==1 then
flag=3
elseif rwFlag==0 and sever_jindu>=100 and sever_ismj==1 then
flag=2
end
else
flag=1
end


local itemwidget=item:GetChildWidgetBase(5)

if flag==2 then
itemwidget:SetChildActive(3,true)
elseif flag==3 then
itemwidget:SetChildActive(2,true)
itemwidget:SetChildActive(3,false)
elseif flag==1 then
itemwidget:SetChildActive(2,false)
itemwidget:SetChildActive(3,false)
end
local showCountBG=rewards[2]>1
local countStr=rewards[2]>1 and rewards[2]or""
local conf={itemid=rewards[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemwidget:SetChildPropData(0,prop)
itemwidget:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onclickitem(flag,rewards[1],mjidx)
end)
else
item:SetChildText(2,"<color=#65615f>???</color>")
item:SetChildGray(1,true)
item:SetChildActive(4,false)
item:SetChildActive(6,false)
item:SetChildActive(7,true)
end
end
end


function UIWanBaoXunBaoDui_MiJinRiJinWin:onclickitem(flag,itemId,ccmjId)
if flag==2 then
MysteryController.send_4_82(ccmjId)
else
tipsManager.showTips({itemid=itemId,itemguid=nil})
end
end

function UIWanBaoXunBaoDui_MiJinRiJinWin:onMask()
self:closeSelf()
end
function UIWanBaoXunBaoDui_MiJinRiJinWin:onOnclosebtn()
self:closeSelf()
end
