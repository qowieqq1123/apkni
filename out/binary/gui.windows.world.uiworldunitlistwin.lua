







def_class("UIWorldUnitListWin",UIWindowBase)






local _this=nil

local subItemKid={
button=0,
name=1,
}
local _UI_Data={

{
name="挑战",
list={

{name="秘境",system=SYSTEM_DEFINE.eMiJing,panel="UIMysteryListWin",},

{name="妖怪",system=SYSTEM_DEFINE.eWorldMonster,panel="UIWorldMonsterListWin",},
},
},

{
name="情报",
list={

{name="家族",system=SYSTEM_DEFINE.eXiuZhenFamily,panel="UIWorldXiuZhenJiaZuListWin",},

{name="仙友",system=SYSTEM_DEFINE.eNPCOpen,panel="UIWorldNPCListWin",},

{name="宗门",system=SYSTEM_DEFINE.eXiTongZongMen,panel="UISystemZongMenListWin",},
},
},
}



local selected=0
local anim_lock=false

function UIWorldUnitListWin:bindComponents()



self.cmps={}
local cnt=#_UI_Data
for i,v in ipairs(_UI_Data)do
local cmp={}
local idx=i-1
cmp.button=UIButton.get(self,idx)
cmp.subview=UIObject.get(self,cnt+idx)
cmp.scrollview=UIScrollView.get(self,cnt*2+idx)
cmp.scrollcontent=UIObject.get(self,cnt*3+idx)
table.insert(self.cmps,cmp)
cmp.button:setButtonClick(function()self:onClickMainBtn(i)end)
cmp.scrollview:setClickAction(function(id,index,guid,attach)
self:onClickSubItem(i,index)
end)
end



end


function UIWorldUnitListWin:unbindComponents()
local _UIObject_release=UIObject.release
for i,v in ipairs(_UI_Data)do
local cmp=self.cmps[i]
_UIObject_release(cmp.button)
_UIObject_release(cmp.subview)
_UIObject_release(cmp.scrollview)
_UIObject_release(cmp.scrollcontent)
end
self.cmps=nil
end

















function UIWorldUnitListWin:onLoaded(...)
self:bindComponents()
self:initSubView()
_this=self
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


function UIWorldUnitListWin:__delete()
self:unbindComponents()
selected=0
_this=nil
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
end




function UIWorldUnitListWin:onShow(argtable,afterOnloaded)

self:onClickMainBtn(selected)
end


function UIWorldUnitListWin:OnEnable()

end


function UIWorldUnitListWin:OnDisable()

end


function UIWorldUnitListWin:initSubView()
for i,v in ipairs(_UI_Data)do
local propDatas={}
for j,w in ipairs(v.list)do
if systemModel.isOpen(w.system)then
local propData={
[PropIndex(DataPropKey.eWidgetText,0)]=w.name
}
table.insert(propDatas,propData)
end
end
local cnt=#propDatas
local cmp=self.cmps[i]
cmp.scrollview:freshGridsNum(cnt,cnt,1,false)
cmp.scrollview:initPropData(propDatas)
cmp.scrollview:setChildSizeDelta(112,cnt>=4 and 385 or(81+cnt*90-10))
cmp.subview:setActive(false)
end
end

function UIWorldUnitListWin:refreshSubView(i)
local propDatas={}
for j,w in ipairs(_UI_Data[i].list)do
if systemModel.isOpen(w.system)then
local propData={
[PropIndex(DataPropKey.eWidgetText,0)]=w.name
}
table.insert(propDatas,propData)
end
end
local cnt=#propDatas
local cmp=self.cmps[i]
cmp.scrollview:freshGridsNum(cnt,cnt,1,false)
cmp.scrollview:initPropData(propDatas)
cmp.scrollview:setChildSizeDelta(112,cnt>=4 and 385 or(81+cnt*90-10))
end

function UIWorldUnitListWin:onClickSubItem(main,sub)
local data=_UI_Data[main]
if data then
local info=data.list[sub]
if info and info.panel then
worldController:changeLeftView(info.panel)
end
else

end
end

function UIWorldUnitListWin:onClickMainBtn(index)
if selected~=index then
if selected then
self:ExpandView(selected,false)
end
selected=index
self:ExpandView(selected,true)
elseif index>0 then
self:ExpandView(selected,false)
selected=0
end
end

function UIWorldUnitListWin:ExpandView(index,expand)
local cmp=self.cmps[index]
if cmp then
local spid=(index-1)*#_UI_Data+(expand and 1 or 0)
self.winlua:SetChildSpriteByPrefabIndex(cmp.button:getID(),spid,true)
cmp.subview:setActive(expand)
cmp.scrollcontent:setChildAnchoredPosition(Vector2.zero)
end
end

function UIWorldUnitListWin:checkSystemId(sysid)
for i,v in ipairs(_UI_Data)do
for j,w in ipairs(v.list)do
if w.system==sysid then
return i
end
end
end
end

function UIWorldUnitListWin.on_system_open(sysid)
local refresh=_this:checkSystemId(sysid)
if refresh then
_this:refreshSubView(refresh)
end
end
