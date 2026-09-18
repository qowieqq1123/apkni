







def_class("UIBuffStateWin",UIWindowBase)









function UIBuffStateWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.pval1=UIText.get(self,2)
self.pval2=UIText.get(self,3)
self.pval3=UIText.get(self,4)



end


function UIBuffStateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.pval1);self.pval1=nil;
_UIObject_release(self.pval2);self.pval2=nil;
_UIObject_release(self.pval3);self.pval3=nil;
end



















function UIBuffStateWin:onLoaded(...)
self:bindComponents()

self.root:setScale(Vector3.New(1,0,1))

self.edes1={'消耗','时间','产量'}
self.edes2={'弟子特质：','专业技能：','宗门状态：','宗门古宝：','加成建筑：','事件影响：','庶务弟子：','仙居图录：','科技加成：','星辰加成：','巅峰仙宝：','灵秀加成：'}

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIBuffStateWin:__delete()
self:unbindComponents()

UIManager:invokeUIMethod('UIManufactureWin','setStateButton',false)
end

function UIBuffStateWin:getValueText(val,br)
val=val or 0
val=math.floor(val*10)/10
local isAdd=val>0
if br then
isAdd=val<0
end
local color=isAdd and'#76d81e'or'#c82c2c'
if val>0 then
return FMT.fmt('<color={1}>+{0}%</color>',val,color)
elseif val<0 then
return FMT.fmt('<color={1}>{0}%</color>',val,color)
else
return'无影响'
end
end

function UIBuffStateWin:getEffectText(data)
local str=''
for k,v in pairs(data)do
v=math.floor(v*10)/10
local isAdd=v>0
local cv=isAdd
if k~=3 then
cv=v<0
end
local color=cv and'#76d81e'or'#c82c2c'
local sign=isAdd and'+'or''
local des=self.edes1[k]
str=FMT.fmt('{0}{1} ',str,FMT.fmt('<color={1}>{0}{2}{3}%</color>',des,color,sign,v))
end
return str
end




function UIBuffStateWin:onShow(argtable,afterOnloaded)
self.bdData=argtable

local cfg=cfg_monijybuildconfig_get(self.bdData.build_id)
local skillId=cfg.pro_skill_id
local scfg=cfg_discipleproskillconfig_get(skillId)
self.edes2[2]=FMT.fmt('{0}技能：',scfg.name)


local edatas=zongmenModel:getManufactureEffect(self.bdData)
local tdatas=zongmenModel:getMergeManufactureEffect(edatas)

self.pval1:setText(self:getValueText(tdatas[3]))
self.pval2:setText(self:getValueText(tdatas[2],true))
self.pval3:setText(self:getValueText(tdatas[1],true))

self.scrollview:setChildScrollViewCreateGrids(#edatas,1)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=edatas[i]
item:SetChildText(0,self.edes2[data.type])
item:SetChildText(1,self:getEffectText(data.data))
end

self.root:setChildDOScaleY(1,0.35,nil)
end


function UIBuffStateWin:onHide()

end





function UIBuffStateWin:onCloseClick()
self:closeSelf()
end