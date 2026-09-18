







def_class("UILingShouQianLiWin",UIWindowBase)









function UILingShouQianLiWin:bindComponents()

self.root=UIObject.get(self,0)
self.mapObj=UIObject.get(self,1)
self.qianliTxt=UIText.get(self,2)
self.attrGrid=UIObject.get(self,3)
self.costObj=UIObject.get(self,4)
self.tipsTxt=UIText.get(self,5)
self.characterBtn=UIImage.get(self,6)



end


function UILingShouQianLiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.mapObj);self.mapObj=nil;
_UIObject_release(self.qianliTxt);self.qianliTxt=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.characterBtn);self.characterBtn=nil;
end
















local _this=nil


function UILingShouQianLiWin:onLoaded(...)
self:bindComponents()
_this=self
self.floorPointNum=10
self.gainTable={}
end


function UILingShouQianLiWin:__delete()
_this=nil
self:unbindComponents()
end


function UILingShouQianLiWin:onHide()

end




function UILingShouQianLiWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid
self.lsData=lingshouModel:getLingShouData(self.ls_guid)

self:initMapView()
self:refreshView()
end

function UILingShouQianLiWin:onChangeLingShou(guid)
self:onShow({ls_guid=guid})
end

function UILingShouQianLiWin:refresCurIndex()
local lsData=self.lsData
self.curIndex=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)%10
self.curTipsIndex=self.curIndex+1
end

function UILingShouQianLiWin:initMapView()
self:refresCurIndex()

local lsData=self.lsData
self.ql_floor=lingshouModel.getQianLiFloor(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
if self.curIndex==0 then
self.ql_floor=self.ql_floor+1
end
local floorcfg=cfgHelper.get1(cfg_lingshouqianlifloorconfig_get,self.ql_floor)
local points=floorcfg.points
self.floorPoints=table.deepCopy(points)

local gridlist=self.mapObj:getChildCommonLayoutGroupWidgetList()
for i,v in ipairs(self.floorPoints)do
local item=gridlist[i-1]
local pos=self.floorPoints[i][1]
item:SetChildLocalPos(-1,pos[1],pos[2],0)
if i<self.floorPointNum then

local nextpos=self.floorPoints[i+1][1]
local dis=mathHelper.distance(pos[1],pos[2],nextpos[1],nextpos[2])
local angle=mathHelper.getAngleByPos(pos[1],pos[2],nextpos[1],nextpos[2])
local progress=0
if i<self.curIndex then
progress=dis
end
pos[3]=dis
pos[4]=angle
item:SetChildRotation(1,0,0,angle)
local width_b=4
local width_p=5
item:SetChildSizeDelta(1,dis,width_b)

item:SetChildSizeDelta(2,progress,width_p)
else

item:SetChildCSImageIcon(0,FMT.fmt('icon_skill_{0}',floorcfg.icon),false)
end
self:refreshMapItem(item,i)

item:SetChildButtonClick(0,function()
self:onPointClick(i)
end)
end

self:refreshMapTips()
end

function UILingShouQianLiWin:refreshMapItem(item,idx)
if item==nil then
item=self.mapObj:getChildCommonLayoutGroupWidgetItem(idx-1)
end
local isactive=self.curIndex>=idx
if idx<self.floorPointNum then
item:SetChildCSImageSprite(0,globalABLookup.lingshoumain,isactive==true and'image_qianlid_1'or'image_qianlid_2')

local isSelect=idx==self.curIndex
item:SetChildActive(3,isSelect)
else

item:SetChildImageExGray(0,not isactive)
item:SetChildImageExGray(1,not isactive)
end
end


function UILingShouQianLiWin:mapItemPlay(idx)
local new_idx=idx+1
self:refresCurIndex()
if idx==0 then

self:refreshMapItem(nil,new_idx)
self:refreshMapTips()
self:refreshView()
else
local pos=self.floorPoints[idx][1]
local item=self.mapObj:getChildCommonLayoutGroupWidgetItem(idx-1)
local dis=pos[3]
local func
if idx<self.floorPointNum-1 then

func=function()
if _this==nil then return end
_this.playLock=false
_this:refreshMapItem(item,idx)
_this:refreshMapItem(nil,new_idx)
_this:refreshMapTips()
_this:refreshView()
end
else

func=function()
if _this==nil then return end
_this:refreshMapItem(item,idx)
_this:refreshMapItem(nil,new_idx)
_this:refreshView()
_this:changeFloor()
end
end
self.playLock=true
item:SetChildDOSizeDelta(2,Vector2(dis,8),0.3,func)
end
end

function UILingShouQianLiWin:changeFloor()
local func=function()
self.playLock=false
self:initMapView()
end
self:delayDo(0.2,func)
end



function UILingShouQianLiWin:refreshMapTips()
local race=self.lsData.cfg.race
local point=self.floorPoints[self.curTipsIndex]
local qianli=(self.ql_floor-1)*10+self.curTipsIndex
local desclist={}


table.insert(desclist,'潜力+1')

local cfg=cfgHelper.get(cfg_lingshouqianliconfig_get,qianli)
local cfg_before=cfgHelper.get(cfg_lingshouqianliconfig_get,qianli-1)

local attrs=table.deepCopy(cfg.attrs)
local temp1={}
if cfg_before~=nil then
temp1=cfg_before.attrs
end
if#temp1>0 then
for i,v in ipairs(attrs)do
for i2,v2 in ipairs(temp1)do
if v[1]==v2[1]then
v[2]=v[2]-v2[2]
break
end
end
end
end
for i,v in ipairs(attrs)do
if v[2]>0 then
table.insert(desclist,helper.getAttributeStr(v[1],v[2],1,'{0}+{1}'))
end
end

if cfg_before~=nil and cfg_before.jingjie_xiulian~=nil then
local temp2=cfg.jingjie_xiulian-cfg_before.jingjie_xiulian
if temp2>0 then
table.insert(desclist,FMT.fmt('境界属性提升{0}%',temp2))
end
end

if self.curTipsIndex==10 then
local effects=table.deepCopy(cfg.effect)
local temp3=cfg_before.effect
for i,v in ipairs(effects)do
for i2,v2 in ipairs(temp3)do
if v[1]==v2[1]and v[2]==v2[2]then
v[3]=v[3]-v2[3]
break
end
end
if v[3]>0 then
table.insert(desclist,lingshouModel.getQianLiEffectDesc(v))
end
end
end

local item=self.mapObj:getChildCommonLayoutGroupWidgetItem(10)
local desc_str=''
for i,v in ipairs(desclist)do
if i>1 then
desc_str=FMT.fmt('{0}\n{1}',desc_str,v)
else
desc_str=v
end
end
item:SetChildText(0,desc_str)
local x=point[1][1]+point[2][1]
local y=point[1][2]+point[2][2]
item:SetChildLocalPos(-1,x,y,0)
end

function UILingShouQianLiWin:onPointClick(idx)
if self.curTipsIndex==idx then return end
self.curTipsIndex=idx
self:refreshMapTips()
end

function UILingShouQianLiWin:refreshView()
local guid=self.ls_guid
local lsData=self.lsData
local lscfg=lsData.cfg
local qlcfg=cfgHelper.get(cfg_lingshouqianliconfig_get,lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))


local ql_str=lingshouModel:getQianLiDesc(guid)
self.qianliTxt:setText(FMT.fmt('潜力：{0}',ql_str))

local attrDesclist={}
self.addAttrDescStr(attrDesclist,qlcfg.attrs)
local c=#attrDesclist
if c%2==1 then
table.insert(attrDesclist,'')
end
table.insert(attrDesclist,FMT.fmt('<color=#6833c0>境界属性提升{0}%</color>',qlcfg.jingjie_xiulian))
local num=#attrDesclist
self.attrGrid:setChildLayoutGroupCreateItems(num)
local gridlist=self.attrGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
local desc=attrDesclist[i]
item:SetChildText(0,desc)
end

self.isfull=lingshouModel.checkQianLiFull(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
self.costObj:setActive(not self.isfull)
self.tipsTxt:setActive(self.isfull)
self.gainTable={}
if not self.isfull then
local costWidget=self.costObj:getWidgetBase()
local costlist=cfgHelper.get(cfg_lingshouqianliconfig_get,lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)+1,'cost')
local costNum=#costlist
costWidget:SetChildLayoutGroupCreateItems(0,costNum)
local costgridlist=costWidget:GetChildLayoutGroupGridList(0)
for i=1,costNum do
local item=costgridlist[i-1]
local cost=costlist[i]
local itemid=cost[1]
local itemnum=cost[2]
local hasnum
local num_str
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
num_str=tostring(hasnum)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
num_str=string.format('%d/%d',hasnum,itemnum)
end
local grayNum=0
if hasnum<=0 then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
elseif hasnum<itemnum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
if grayNum~=0 then
num_str=FMT.fmt('<color=red>{0}</color>',num_str)
end
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=i,gray=grayNum,showStage=true,showCountBG=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.gainTable[itemid]=itemnum
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end

local isreddot=lingshouModel.checkQLEnoughUp(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI),false)
costWidget:SetChildActive(1,isreddot)
else
self.tipsTxt:setText('当前灵兽潜力已极致')
end
end

function UILingShouQianLiWin:onItemClick(itemid,index,guid,attach)
if itemid==-1 then return end
local need=self.gainTable[itemid]or 0
if gainControl:showGainWin(itemid,need)then return end
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UILingShouQianLiWin.addAttrDescStr(res,attrs)
for i,v in ipairs(attrs)do
local str=helper.getAttributeStr(v[1],v[2],1,'{0}：<color=#171311>{1}</color>')
table.insert(res,str)
end
end

function UILingShouQianLiWin:onCharacterBtn()
local func=function()
self.characterBtn:setSprite(globalABLookup.lingshoumain,'button_texing_1')
end
self.characterBtn:setSprite(globalABLookup.lingshoumain,'button_texing_2')
UIManager:showWindow('UILingShouCharacterWin',{ls_guid=self.ls_guid,callback=func})
end

function UILingShouQianLiWin:onRuleBtn()
local d={}
d.title='灵兽潜力介绍'
d.mode=3
d.name='lingshou_qianli_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILingShouQianLiWin:onUpBtn()
if self.playLock then return end
if self.isfull then
UIManager.error('当前灵兽潜力已达极值')
return
end

local guid=self.ls_guid
local lsData=self.lsData
if not lingshouModel.checkQLEnoughUp(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI),true)then
return
end

lingshouController:reqQlUp(guid)
end

function UILingShouQianLiWin:rec_qianliUp(guid)
local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local oldIndex=self.curIndex
self:mapItemPlay(oldIndex)
end

function UILingShouQianLiWin:rec_awake(guid)
self:onShow({ls_guid=guid})
end