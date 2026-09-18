






LuaProgress=simple_class()


function LuaProgress:__init()
self.MaskTransform=null;
self.Wigth=0;
self.Higth=0;
end

function LuaProgress:SetUIObject(MaskTransform,Wigth,Higth)
self.MaskTransform=MaskTransform;
self.Wigth=Wigth;
self.Higth=Higth;
end

function LuaProgress:SetProgressValue(Value)
if Value<0 then
Value=0;
end
self.MaskTransform.sizeDelta=Vector2.New(math.max(self.Wigth*Value,0.1),self.Higth);
end
