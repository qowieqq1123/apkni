




if jit then
jit.off();jit.flush()








end

if DebugServerIp then
require("mobdebug").start(DebugServerIp)
end

require"tolua.misc.functions"
Mathf=require"tolua.UnityEngine.Mathf"
Vector3=require"tolua.UnityEngine.Vector3"
Quaternion=require"tolua.UnityEngine.Quaternion"
Vector2=require"tolua.UnityEngine.Vector2"
Vector4=require"tolua.UnityEngine.Vector4"
Color=require"tolua.UnityEngine.Color"
Ray=require"tolua.UnityEngine.Ray"
Bounds=require"tolua.UnityEngine.Bounds"
RaycastHit=require"tolua.UnityEngine.RaycastHit"
Touch=require"tolua.UnityEngine.Touch"
LayerMask=require"tolua.UnityEngine.LayerMask"
Plane=require"tolua.UnityEngine.Plane"
Time=reimport"tolua.UnityEngine.Time"

list=require"tolua.list"
utf8=require"tolua.misc.utf8"

require"tolua.event"
require"tolua.typeof"
require"tolua.slot"
require"tolua.System.Timer"
require"tolua.System.coroutine"
require"tolua.System.ValueType"
require"tolua.System.Reflection.BindingFlags"
require"tolua.encrypt"



if jit then
if jit.status()then
local t=os.clock()

for i=1,10000 do
local q1=Quaternion.Euler(i,i,i)
Quaternion.Slerp(Quaternion.identity,q1,0.5)
end

jit.flush(true)
end

if not jit.status()then

end
end
